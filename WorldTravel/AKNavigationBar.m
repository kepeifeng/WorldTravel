//
//  AKNavigationBar.m
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 14/11/7.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import "AKNavigationBar.h"
#import <objc/runtime.h>
#import "CamButton.h"

@implementation UINavigationItem (BackgroundColor)

-(UIColor *)navigationBarBackgroundColor{
    return objc_getAssociatedObject(self, @selector(navigationBarBackgroundColor));
}

-(void)setNavigationBarBackgroundColor:(UIColor *)navigationBarBackgroundColor{
    objc_setAssociatedObject(self, @selector(navigationBarBackgroundColor), navigationBarBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
@implementation AKNavigationBar


-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self setupDefaultView];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDefaultView];
    }
    return self;
}
-(void)setupDefaultView{
    [self setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];

}


-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* gradientColor = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 0.314];
    UIColor* gradientColor2 = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 0.706];
    UIColor* spotLight = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 0.2];
    
    //// Gradient Declarations
    CGFloat gradientLocations[] = {0, 1};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)@[(id)gradientColor.CGColor, (id)gradientColor2.CGColor], gradientLocations);
    //// Image Declarations
    UIImage* camButton = [UIImage imageNamed: @"cam_button_bg.jpg"];
    
    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: self.bounds];
    CGContextSaveGState(context);
    [rectanglePath addClip];
    CGContextDrawTiledImage(context, CGRectMake(0, 0, camButton.size.width, camButton.size.height), camButton.CGImage);

    
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, -0), CGPointMake(0, CGRectGetHeight(self.bounds)), 0);
    CGContextRestoreGState(context);
    [[UIColor colorWithWhite:0.000 alpha:0.400] setStroke];
    rectanglePath.lineWidth = 2;
    [rectanglePath stroke];
    
    
    //// Rectangle 2 Drawing
//    CGRect spotLightRect = self.bounds;
    CGRect spotLightRect = CGRectInset(self.bounds, 1, 1);
    spotLightRect.size.height = spotLightRect.size.height/2;
    UIBezierPath* rectangle2Path = [UIBezierPath bezierPathWithRect: spotLightRect];
    [spotLight setFill];
    [rectangle2Path fill];
    
    
    //// Cleanup
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);


}
-(void)layoutSubviews{
    [super layoutSubviews];

}

@end

@implementation AKNavigationController

-(NSArray *)popToRootViewControllerAnimated:(BOOL)animated{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    return [super popToRootViewControllerAnimated:animated];
}

-(UIViewController *)popViewControllerAnimated:(BOOL)animated{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    return [super popViewControllerAnimated:animated];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [super pushViewController:viewController animated:animated];
}

-(NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    return [super popToViewController:viewController animated:animated];
}

@end

@implementation AKBarButtonItem

-(instancetype)initWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action{

    CamButton * button = [[CamButton alloc] init];
    [button setImage:image
            forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(action) forControlEvents:(UIControlEventTouchUpInside)];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    [button sizeToFit];
    CGRect buttonRect = button.bounds;
    buttonRect.size.width += 10;
    buttonRect.size.height = 31;
    self = [super initWithCustomView:button];
    if (self) {
        
    }
    return self;
}

-(instancetype)initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action{
    CamButton * button = [[CamButton alloc] init];
    [button setTitle:title
            forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(action) forControlEvents:(UIControlEventTouchUpInside)];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:12];

    button.titleLabel.layer.shadowColor = [[UIColor colorWithWhite:0.000 alpha:1] CGColor];
    button.titleLabel.layer.shadowOffset = CGSizeMake(1/[[UIScreen mainScreen] scale], 1/[[UIScreen mainScreen] scale]);
    button.titleLabel.layer.shadowRadius = 1;
    button.titleLabel.layer.shadowOpacity = 1;
    button.titleLabel.layer.masksToBounds = NO;
//    [button setTitleShadowColor:[UIColor colorWithWhite:0.000 alpha:0.650] forState:UIControlStateNormal];
//    button.titleLabel.shadowOffset = CGSizeMake(1.0, 1.0);

    
    [button sizeToFit];
    CGRect buttonRect = button.bounds;
    buttonRect.size.width += 10;
    buttonRect.size.height = 31;

    button.frame = buttonRect;
    self = [super initWithCustomView:button];
    if (self) {
        
    }
    return self;
}

@end