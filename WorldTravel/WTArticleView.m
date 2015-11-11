//
//  WTArticleView.m
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 15/10/31.
//  Copyright © 2015年 Kent Peifeng Ke. All rights reserved.
//

#import "WTArticleView.h"
#import "WTPoetryContentView.h"
#import "WTNote.h"
#import "NSString+Utility.h"
#import <CoreText/CoreText.h>

@implementation WTArticleView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialSetup];
    }
    return self;
}

-(void)initialSetup{

    _titleView = [[WTVerticalTextView alloc] init];
    _titleView.font = [UIFont fontWithName:@"MingLiU" size:24];
//    _titleView.backgroundColor = [UIColor redColor];
    [self addSubview:_titleView];
    
    _authorLabel = [[WTVerticalTextView alloc] init];
    _authorLabel.font = [UIFont fontWithName:@"MingLiU" size:18];
//    _authorLabel.backgroundColor = [UIColor yellowColor];
    [self addSubview:_authorLabel];
    
    _contentLabel = [[WTVerticalTextView alloc] init];
    _contentLabel.font = [UIFont fontWithName:@"MingLiU" size:18];
//    _contentLabel.backgroundColor = [UIColor blueColor];
    [self addSubview:_contentLabel];

}

-(void)didMoveToWindow{
    [super didMoveToWindow];
    
}

-(void)layout{

    //Need no NSStringDrawingUsesLineFragmentOrigin
    
    CGRect titleRect = [_titleView.attributedText boundingRectWithSize:CGSizeMake(CGRectGetHeight(self.bounds), 9999)
                                                               options:(NSStringDrawingUsesLineFragmentOrigin)
                                                               context:nil];
    _titleView.frame = CGRectMake(0, 0, CGRectGetHeight(titleRect), CGRectGetWidth(titleRect));
    
    CGRect authorRect = [_authorLabel.attributedText boundingRectWithSize:CGSizeMake(CGRectGetHeight(self.bounds), 9999)
                                                                  options:(NSStringDrawingUsesLineFragmentOrigin)
                                                                  context:nil];
    
    _authorLabel.frame = CGRectMake(CGRectGetMaxX(_titleView.frame), 0, CGRectGetHeight(authorRect), CGRectGetWidth(authorRect));
    
    CGRect contentRect = [_contentLabel.attributedText boundingRectWithSize:CGSizeMake(CGRectGetHeight(self.bounds), 9999)
                                                                    options:(NSStringDrawingUsesLineFragmentOrigin)
                                                                    context:nil];
    
    
    _contentLabel.frame = CGRectMake(CGRectGetMaxX(_authorLabel.frame)+20, 0, CGRectGetHeight(contentRect), CGRectGetWidth(contentRect));
    
    NSArray * views = @[_titleView, _authorLabel, _contentLabel];
    CGFloat width = MAX(CGRectGetMaxX(_contentLabel.frame), CGRectGetWidth(self.bounds) - self.padding.right - self.padding.left);
    self.contentSize = CGSizeMake(width + self.padding.right + self.padding.left, CGRectGetHeight(self.bounds));
    //反向排列
    for (UIView * view in views) {
        CGRect frame = view.frame;
        frame.origin.x = width - CGRectGetMaxX(frame) + self.padding.left;
        view.frame = frame;
    }
    
    self.contentOffset = CGPointMake(self.contentSize.width - CGRectGetWidth(self.bounds), -self.contentInset.top);
    

}

-(void)layoutSubviews{

    [super layoutSubviews];
    
//    NSLog(@"layoutSubviews");
  
}

-(void)setArticle:(WTArticleEntity *)articleEntity{
    _article = articleEntity;
    
    self.titleView.text = articleEntity.title;
    self.authorLabel.text = articleEntity.author;
    self.contentLabel.text = articleEntity.content;
    
    NSMutableAttributedString * newText = [self.contentLabel.attributedText mutableCopy];
    
    NSArray * notes = [WTArticleView getNotesOfText:articleEntity.content fromSummary:articleEntity.summary];
    for (WTNote * note in notes) {
        if (note.range.length == 0) {
            continue;
        }
        [newText addAttributes:@{NSForegroundColorAttributeName: [UIColor redColor]} range:note.range];
        NSString * chineseNumber = [NSString convertArabicNumbersToChinese:note.index];
        NSDictionary * attr = [WTArticleView attributeDictionaryWithRubyText:chineseNumber];
        [newText addAttributes:attr range:note.range];
    }
    
    
    self.contentLabel.attributedText = newText;
    [self layout];
}


-(NSAttributedString * )processNoteNumberOfAttributedString:(NSMutableAttributedString *)_attributedText{

    
    NSRegularExpression * numberExp = [NSRegularExpression regularExpressionWithPattern:@"\\[(\\d+)\\]" options:0 error:nil];
    NSMutableAttributedString * newString = [_attributedText mutableCopy];
    NSString * text = [_attributedText string];
    
    NSArray<NSTextCheckingResult *> * matches = [numberExp matchesInString:text options:0 range:(NSMakeRange(0, text.length))];
    NSInteger offset = 0;
    UIFont * markFont = [UIFont fontWithName:@"MingLiU" size:9];
    
    /*
     for (NSTextCheckingResult * result in matches) {
     
     NSMutableString * matchString = [[self.text substringWithRange:result.range] mutableCopy];
     [numberExp replaceMatchesInString:matchString options:0 range:NSMakeRange(0, matchString.length) withTemplate:@"$1"];
     NSString * chineseNumberString = [NSString convertArabicNumbersToChinese:[matchString integerValue]];
     NSAttributedString * numberString = [[NSAttributedString alloc] initWithString:chineseNumberString attributes:@{NSVerticalGlyphFormAttributeName:@(YES),
     NSFontAttributeName:markFont,
     (NSString *)kCTSuperscriptAttributeName:@(1),
     NSVerticalGlyphFormAttributeName:@(YES)}];
     
     NSRange range = NSMakeRange(result.range.location - offset, result.range.length);
     [newString replaceCharactersInRange:range withAttributedString:numberString];
     offset+=(result.range.length - numberString.length);
     
     }
     
     */
    
    
    
    for (NSTextCheckingResult * result in matches) {
        
        
        
        NSMutableString * matchString = [[text substringWithRange:result.range] mutableCopy];
        [numberExp replaceMatchesInString:matchString options:0 range:NSMakeRange(0, matchString.length) withTemplate:@"$1"];
        NSString * chineseNumberString = [NSString convertArabicNumbersToChinese:[matchString integerValue]];
        // Ruby Annotation
        CFStringRef furiganaRef[kCTRubyPositionCount] = {
            (__bridge CFStringRef) chineseNumberString, NULL, NULL, NULL
        };
        CTRubyAnnotationRef ruby = CTRubyAnnotationCreate(kCTRubyAlignmentAuto, kCTRubyOverhangAuto, 1, furiganaRef);
        //CFSTR("HiraMinProN-W6")
        CTFontRef font = CTFontCreateWithName((CFStringRef)@"MingLiU", 9, NULL);
        CFStringRef keys[] = { kCTFontAttributeName, kCTRubyAnnotationAttributeName,kCTVerticalFormsAttributeName};
        CFBooleanRef vertical = (__bridge CFBooleanRef)@(YES);
        
        CFTypeRef values[] = { font, ruby, vertical};
        
        CFDictionaryRef attr = CFDictionaryCreate(NULL,
                                                  (const void **)&keys,
                                                  (const void **)&values,
                                                  sizeof(keys) / sizeof(keys[0]),
                                                  &kCFTypeDictionaryKeyCallBacks,
                                                  &kCFTypeDictionaryValueCallBacks);
        
        CFAttributedStringRef attributes = CFAttributedStringCreate(NULL, (__bridge CFStringRef)@" ", attr);
        CFRelease(attr);
        
        NSAttributedString * numberString = (__bridge NSAttributedString *)(attributes);
        NSRange range = NSMakeRange(result.range.location - offset, result.range.length);
        [newString replaceCharactersInRange:range withAttributedString:numberString];
        offset+=(result.range.length - numberString.length);
        CFAutorelease(attributes);
        
        
        
        
        /*
         NSMutableString * matchString = [[self.text substringWithRange:result.range] mutableCopy];
         [numberExp replaceMatchesInString:matchString options:0 range:NSMakeRange(0, matchString.length) withTemplate:@"$1"];
         NSString * chineseNumberString = [NSString convertArabicNumbersToChinese:[matchString integerValue]];
         NSAttributedString * numberString = [[NSAttributedString alloc] initWithString:chineseNumberString attributes:@{NSVerticalGlyphFormAttributeName:@(YES),
         NSFontAttributeName:markFont,
         (NSString *)kCTSuperscriptAttributeName:@(1),
         NSVerticalGlyphFormAttributeName:@(YES)}];
         
         NSRange range = NSMakeRange(result.range.location - offset, result.range.length);
         [newString replaceCharactersInRange:range withAttributedString:numberString];
         offset+=(result.range.length - numberString.length);
         
         */
    }
    
    
    return newString;
    

}

+(NSDictionary *)attributeDictionaryWithRubyText:(NSString *)text{
    

    CFStringRef furiganaRef[kCTRubyPositionCount] = {
        (__bridge CFStringRef) text, NULL, NULL, NULL
    };
    CTRubyAnnotationRef ruby = CTRubyAnnotationCreate(kCTRubyAlignmentAuto, kCTRubyOverhangAuto, 0.5, furiganaRef);
    //CFSTR("HiraMinProN-W6")
//    CTFontRef font = CTFontCreateWithName((CFStringRef)@"MingLiU", 9, NULL);
    CFStringRef keys[] = {kCTRubyAnnotationAttributeName,kCTVerticalFormsAttributeName};
    CFBooleanRef vertical = (__bridge CFBooleanRef)@(YES);
    
    CFTypeRef values[] = {ruby, vertical};
    
    CFDictionaryRef attr = CFDictionaryCreate(NULL,
                                              (const void **)&keys,
                                              (const void **)&values,
                                              sizeof(keys) / sizeof(keys[0]),
                                              &kCFTypeDictionaryKeyCallBacks,
                                              &kCFTypeDictionaryValueCallBacks);
    
    NSDictionary * dict = (__bridge NSDictionary *)attr;
    return dict;
//    CFAttributedStringRef attributes = CFAttributedStringCreate(NULL, (__bridge CFStringRef)@" ", attr);
//    CFRelease(attr);
}


+(NSArray *)getNotesOfText:(NSString *)text fromSummary:(NSString *)summary{
    
    if (text.length == 0 || summary.length == 0) {
        return nil;
    }
    
    NSRegularExpression * noteExp = [NSRegularExpression regularExpressionWithPattern:@"\\[\\d+\\]\\s?.+" options:0 error:nil];
    NSArray<NSTextCheckingResult *> * matches = [noteExp matchesInString:summary options:0 range:(NSMakeRange(0, summary.length))];
    NSMutableArray * notes = [[NSMutableArray alloc]initWithCapacity:matches.count];
    for (NSTextCheckingResult * result in matches) {
        
        NSString * noteString = [summary substringWithRange:result.range];
        WTNote * note = [self parseNote:noteString];
        //        note.range = result.range;
        [notes addObject:note];
        
        
        NSInteger numberIndex = [text rangeOfString:[NSString stringWithFormat:@"[%d]",note.index]].location;
        if (numberIndex != NSNotFound) {
            note.range = [text rangeOfString:note.itemName options:(NSBackwardsSearch) range:NSMakeRange(0, numberIndex)];
        }
        
        NSLog(@"%@", NSStringFromRange(note.range));
        
    }
    return notes;
}



+(WTNote *)parseNote:(NSString *)text{
    
    NSRegularExpression * noteExp = [NSRegularExpression regularExpressionWithPattern:@"\\[(\\d+)\\]([^:：]+)[:：]\\s?(.+)" options:0 error:nil];
    NSTextCheckingResult * result = [noteExp firstMatchInString:text options:0 range:(NSMakeRange(0, text.length))];
    
    for (NSInteger i = 0; i<result.numberOfRanges; i++) {
        NSRange range = [result rangeAtIndex:i];
        NSLog(@"%@",[text substringWithRange:range]);
    }
    
    WTNote * note = [WTNote new];
    note.index = [[text substringWithRange:[result rangeAtIndex:1]] integerValue];
    note.title = [text substringWithRange:[result rangeAtIndex:2]];
    note.itemName = [self getCleanItemNameFromTitle:note.title];
    
    note.detail = [text substringWithRange:[result rangeAtIndex:3]];
    return note;
}

+(NSString *)getCleanItemNameFromTitle:(NSString *)title{
    
    NSRange range = [title rangeOfString:@":"];
    if (range.location == NSNotFound) {
        range = [title rangeOfString:@"："];
    }
    
    if (range.location != NSNotFound) {
        return [title substringToIndex:range.location];
    }
    
    return [title copy];
}

@end
