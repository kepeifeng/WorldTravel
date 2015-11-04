//
//  WTPoetryContentView.m
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 15/11/4.
//  Copyright © 2015年 Kent Peifeng Ke. All rights reserved.
//

#import "WTPoetryContentView.h"

@implementation WTPoetryContentView

-(void)updateAttributedString{

    [super updateAttributedString];
    
    return;
    
    if (self.text.length == 0) {
        return;
    }
    
    NSRegularExpression * numberExp = [NSRegularExpression regularExpressionWithPattern:@"\\[(\\d+)\\]" options:0 error:nil];
    NSMutableAttributedString * newString = [_attributedText mutableCopy];
    
//    [numberExp replaceMatchesInString:newString options:0 range:(NSMakeRange(0, newString.length)) withTemplate:@"$1"];
    NSArray<NSTextCheckingResult *> * matches = [numberExp matchesInString:self.text options:0 range:(NSMakeRange(0, self.text.length))];
//    NSInteger offset = 0;
    for (NSTextCheckingResult * result in matches) {
//        NSArray * alternativeStrings = result.alternativeStrings;
//        NSString * replacement = result.replacementString;
        NSLog(@"%@", result);
//        [newString replaceCharactersInRange:(NSRange) withAttributedString:<#(nonnull NSAttributedString *)#>]
//        [newString setAttributes:@{NSFontAttributeName:} range:<#(NSRange)#>]
    }
}

@end
