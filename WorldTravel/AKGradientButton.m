//
//  AKGradientButton.m
//  2bulu-NewAssistant
//
//  Created by Kent Peifeng Ke on 1/29/15.
//  Copyright (c) 2015 È≠èÊñ∞Êù∞. All rights reserved.
//

#import "AKGradientButton.h"

@implementation AKGradientButton
{
    NSMutableDictionary * _borderColorDict;
    NSMutableDictionary * _startingColorDict;
    NSMutableDictionary * _endingColorDict;
}

-(void)setBorderColor:(UIColor *)borderColor forState:(UIControlState)state
{
    if (!_borderColorDict) {
        _borderColorDict = [NSMutableDictionary new];
    }
    
    [_borderColorDict setObject:borderColor forKey:@(state)];
}

-(UIColor *)borderColorForState:(UIControlState)state
{
    UIColor * color = [_borderColorDict objectForKey:@(state)];
    
    if (!color && state != UIControlStateNormal) {
        return [self borderColorForState:(UIControlStateNormal)];
    }
    
    if (!color) {
        color = [UIColor clearColor];
    }
    
    return color;
}

-(void)setStartingGradientColor:(UIColor *)color forState:(UIControlState)state
{
    if (!_startingColorDict) {
        _startingColorDict = [NSMutableDictionary new];
    }
    
    [_startingColorDict setObject:color forKey:@(state)];
	
}

-(UIColor *)startingGradientColorForState:(UIControlState)state
{
    UIColor * color = [_startingColorDict objectForKey:@(state)];
    
    if (!color && state != UIControlStateNormal) {
        return [self startingGradientColorForState:(UIControlStateNormal)];
    }
    
    if (!color) {
        color = [UIColor clearColor];
    }
    return color;
}

-(void)setEndingGradientColor:(UIColor *)color forState:(UIControlState)state
{
    if (!_endingColorDict) {
        _endingColorDict = [NSMutableDictionary new];
    }
    [_endingColorDict setObject:color forKey:@(state)];
}

-(UIColor *)endingGradientColorForState:(UIControlState)state
{
    
    UIColor * color = [_endingColorDict objectForKey:@(state)];
    
    if (!color && state != UIControlStateNormal) {
        return [self endingGradientColorForState:(UIControlStateNormal)];
    }
    
    if (!color) {
        color = [UIColor clearColor];
    }
    return color;
}

-(void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* borderColor = [self borderColorForState:self.state];
    
    UIColor* highlightShadowColor = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 0.667];
    
    //// Gradient Declarations
    CGFloat gradientLocations[] = {0, 1};
    
    UIColor * startingColor = [self startingGradientColorForState:self.state];
    UIColor * endingColor = [self endingGradientColorForState:self.state];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)@[(id)startingColor.CGColor, (id)endingColor.CGColor], gradientLocations);
    
    //// Shadow Declarations
    UIColor* dropShadow = UIColor.blackColor;
    CGSize dropShadowOffset = CGSizeMake(3.1, 3.1);
    CGFloat dropShadowBlurRadius = 5;
    
    UIColor* highlightShadow = highlightShadowColor;
    CGSize highlightShadowOffset = CGSizeMake(0, 1);
    CGFloat highlightShadowBlurRadius = 0;
    
    //// Rectangle Drawing
//    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: self.bounds cornerRadius: self.radius];
//    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectInset(self.bounds, self.borderWidth/2, self.borderWidth/2) cornerRadius: self.radius];
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectInset(self.bounds, self.borderWidth, self.borderWidth) cornerRadius: self.radius];
    CGContextSaveGState(context);
//    CGContextSetShadowWithColor(context, dropShadowOffset, dropShadowBlurRadius, [dropShadow CGColor]);
    CGContextBeginTransparencyLayer(context, NULL);
    [rectanglePath addClip];
    CGContextDrawLinearGradient(context, gradient, CGPointMake(CGRectGetWidth(self.bounds)/2, -0), CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds)), 0);
    CGContextEndTransparencyLayer(context);
    
    ////// Rectangle Inner Shadow
    CGContextSaveGState(context);
    UIRectClip(rectanglePath.bounds);
    CGContextSetShadowWithColor(context, CGSizeZero, 0, NULL);
    
    CGContextSetAlpha(context, CGColorGetAlpha([highlightShadow CGColor]));
    CGContextBeginTransparencyLayer(context, NULL);
    {
        UIColor* opaqueShadow = [highlightShadow colorWithAlphaComponent: 1];
        CGContextSetShadowWithColor(context, highlightShadowOffset, highlightShadowBlurRadius, [opaqueShadow CGColor]);
        CGContextSetBlendMode(context, kCGBlendModeSourceOut);
        CGContextBeginTransparencyLayer(context, NULL);
        
        [opaqueShadow setFill];
        [rectanglePath fill];
        
        CGContextEndTransparencyLayer(context);
    }
    CGContextEndTransparencyLayer(context);
    CGContextRestoreGState(context);

    
    CGContextRestoreGState(context);
    
    [borderColor setStroke];
    rectanglePath.lineWidth = self.borderWidth;
    [rectanglePath stroke];
    
    
    //// Cleanup
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
  
}


+(instancetype)buttonWithPreset:(AKGradientButtonPreset)preset
{
    
    AKGradientButton * button = [AKGradientButton buttonWithType:(UIButtonTypeCustom)];
    
    UIColor * startingColor;
    UIColor * endingColor;
    UIColor * borderColor;
    
    
    switch (preset) {
        case AKGradientButtonRed:
            
            startingColor = [UIColor colorWithRed:0.850 green:0.218 blue:0.159 alpha:1.000];
            endingColor = [UIColor colorWithRed:0.675 green:0.157 blue:0.109 alpha:1.000];
            borderColor = [UIColor colorWithRed:0.675 green:0.157 blue:0.109 alpha:1.000];
            break;
        case AKGradientButtonOrange:
            
            startingColor = [UIColor colorWithRed:0.853 green:0.422 blue:0.000 alpha:1.000];
            endingColor = [UIColor colorWithRed:0.761 green:0.256 blue:0.000 alpha:1.000];
            borderColor = [UIColor colorWithRed:0.761 green:0.256 blue:0.000 alpha:1.000];
            break;
        case AKGradientButtonYellow:
            
            startingColor = [UIColor colorWithRed:0.986 green:0.780 blue:0.000 alpha:1.000];
            endingColor = [UIColor colorWithRed:0.977 green:0.605 blue:0.000 alpha:1.000];
            borderColor = [UIColor colorWithRed:0.977 green:0.605 blue:0.000 alpha:1.000];
            break;
        case AKGradientButtonGreen:
            
            startingColor = [UIColor colorWithRed:0.230 green:0.777 blue:0.316 alpha:1.000];
            endingColor = [UIColor colorWithRed:0.191 green:0.638 blue:0.261 alpha:1.000];
            borderColor = [UIColor colorWithRed:0.191 green:0.638 blue:0.261 alpha:1.000];
            break;
        case AKGradientButtonCyan:
            
            startingColor = [UIColor colorWithRed:0.182 green:0.694 blue:0.530 alpha:1.000];
            endingColor = [UIColor colorWithRed:0.151 green:0.569 blue:0.437 alpha:1.000];
            borderColor = [UIColor colorWithRed:0.151 green:0.569 blue:0.437 alpha:1.000];
            break;
        case AKGradientButtonBlue:
            
            startingColor = [UIColor colorWithRed:0.194 green:0.509 blue:0.852 alpha:1.000];
            endingColor = [UIColor colorWithRed:0.154 green:0.413 blue:0.691 alpha:1.000];
            borderColor = [UIColor colorWithRed:0.154 green:0.413 blue:0.691 alpha:1.000];
            break;
        case AKGradientButtonPurple:
            
            startingColor = [UIColor colorWithRed:0.371 green:0.257 blue:0.755 alpha:1.000];
            endingColor = [UIColor colorWithRed:0.278 green:0.185 blue:0.593 alpha:1.000];
            borderColor = [UIColor colorWithRed:0.278 green:0.185 blue:0.593 alpha:1.000];
            break;
        case AKGradientButtonWhite:
            
            startingColor = [UIColor colorWithRed:0.908 green:0.926 blue:0.932 alpha:1.000];
            endingColor = [UIColor colorWithRed:0.689 green:0.714 blue:0.734 alpha:1.000];
            borderColor = [UIColor colorWithRed:0.689 green:0.714 blue:0.734 alpha:1.000];
            break;
        case AKGradientButtonGray:
            
            startingColor = [UIColor colorWithRed:0.518 green:0.582 blue:0.586 alpha:1.000];
            endingColor = [UIColor colorWithRed:0.427 green:0.476 blue:0.480 alpha:1.000];
            borderColor = [UIColor colorWithRed:0.427 green:0.476 blue:0.480 alpha:1.000];
            break;
        case AKGradientButtonBlack:
            
            startingColor = [UIColor colorWithWhite:0.126 alpha:1.000];
            endingColor = [UIColor colorWithWhite:0.112 alpha:1.000];
            borderColor = [UIColor colorWithWhite:0.112 alpha:1.000];
            break;
            
        default:
            break;
    }
    
    
    [button setStartingGradientColor:startingColor forState:(UIControlStateNormal)];
    [button setEndingGradientColor:endingColor forState:(UIControlStateNormal)];
    [button setStartingGradientColor:endingColor forState:(UIControlStateHighlighted)];
    [button setEndingGradientColor:startingColor forState:(UIControlStateHighlighted)];
    [button setBorderColor:borderColor forState:(UIControlStateNormal)];
    button.borderWidth = 1;
    button.radius = 5;
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    
    return button;
}




@end
