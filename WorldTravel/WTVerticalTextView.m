//
//  WTVerticalTextView.m
//  WorldTravel
//
//  Created by Kent on 10/30/15.
//  Copyright © 2015 Kent Peifeng Ke. All rights reserved.
//

#import "WTVerticalTextView.h"
#import <CoreText/CoreText.h>

@implementation WTVerticalTextView{

    NSAttributedString * _attributed;
}
@synthesize font = _font;
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.minimumLineHeight = 28;
    }
    return self;
}

-(void)setFont:(UIFont *)font{
    _font = font;
    [self updateAttributedString];
}

-(UIFont *)font{

    if (!_font) {
        return [UIFont fontWithName:@"HiraMinProN-W3" size:14];
    }
    return _font;
}

-(void)setText:(NSString *)text{
    _text = text;
    [self updateAttributedString];
}

-(void)updateAttributedString{

    if (!_text) {
        _attributed = nil;
        [self setNeedsDisplay];
        return;
    }
    
    NSMutableAttributedString * attributed = [[NSMutableAttributedString alloc] initWithString:_text attributes:nil];
    
    //    CTParagraphStyleSetting settings[1];
    //    CTParagraphStyleSetting setting;
    //    setting.spec = kCTParagraphStyleSpecifierMinimumLineHeight;
    //    CGFloat height = 28.0;
    //    setting.valueSize = sizeof(height);
    //    setting.value = &height;
    //    settings[0] = setting;
    //
    //    CTParagraphStyleRef style = CTParagraphStyleCreate(settings, 1);
    NSMutableParagraphStyle * style = [[NSMutableParagraphStyle alloc] init];
    style.minimumLineHeight = self.minimumLineHeight;
    
    [attributed addAttributes:@{NSFontAttributeName:self.font, //吐血, 用 systemFont 就会排版出错
                                NSVerticalGlyphFormAttributeName:@(YES),
                                NSParagraphStyleAttributeName:style} range:NSMakeRange(0, attributed.length)];
    
    _attributed = attributed;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    

//    NSString * text = @"iOS开发之Attributes文字的操作\n你是谁 Who are you.";
    

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextAddRect(context, rect);
    CGContextFillPath(context);
    
    CGContextRotateCTM(context, M_PI_2);
    CGContextTranslateCTM(context, 30.0, 35.0);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)_attributed);
    CGPathRef path = CGPathCreateWithRect(CGRectMake(0.0, 0.0, rect.size.height, rect.size.width), nil);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, nil);
    CTFrameDraw(frame, context);
    
    
    
}

- (BOOL)isChinese:(NSString *)s index:(int)index {
    NSString *subString = [s substringWithRange:NSMakeRange(index, 1)];
    const char *cString = [subString UTF8String];
    return strlen(cString) == 3;
}
@end
