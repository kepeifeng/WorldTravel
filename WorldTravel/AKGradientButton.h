//
//  AKGradientButton.h
//  2bulu-NewAssistant
//
//  Created by Kent Peifeng Ke on 1/29/15.
//  Copyright (c) 2015 È≠èÊñ∞Êù∞. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AKGradientButtonPreset) {
    AKGradientButtonRed,
    AKGradientButtonOrange,
    AKGradientButtonYellow,
    AKGradientButtonGreen,
    AKGradientButtonCyan,
    AKGradientButtonBlue,
    AKGradientButtonPurple,
    AKGradientButtonWhite,
    AKGradientButtonGray,
    AKGradientButtonBlack,
};
@interface AKGradientButton : UIButton

+(instancetype)buttonWithPreset:(AKGradientButtonPreset)preset;

-(void)setBorderColor:(UIColor *)borderColor forState:(UIControlState)state;
-(UIColor *)borderColorForState:(UIControlState)state;

-(void)setStartingGradientColor:(UIColor *)color forState:(UIControlState)state;
-(UIColor *)startingGradientColorForState:(UIControlState)state;

-(void)setEndingGradientColor:(UIColor *)color forState:(UIControlState)state;
-(UIColor *)endingGradientColorForState:(UIControlState)state;

@property (nonatomic) CGFloat radius;
@property (nonatomic) CGFloat borderWidth;
@end
