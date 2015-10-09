//
//  CircleButtonViewController.m
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 14-9-11.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import "CircleButtonViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImage+Utility.h"

@interface CircleButtonViewController ()

@end

@implementation CircleButtonViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    [self.view addSubview:button];
    button.center = self.view.center;
    button.backgroundColor = [UIColor colorWithRed:0.486 green:0.698 blue:0.694 alpha:1.000];
    button.layer.cornerRadius = CGRectGetWidth(button.frame)/2;
    [button addTarget:self action:@selector(showImageViewTapped:) forControlEvents:(UIControlEventTouchUpInside)];
    

    
    CGPoint center = CGPointMake(button.frame.size.width/2, button.frame.size.height/2);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:CGRectGetWidth(button.frame)/2 startAngle:0 endAngle:M_PI*2 clockwise:NO];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.lineWidth = 5;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor darkGrayColor].CGColor;
    layer.path = path.CGPath;
    [button.layer addSublayer:layer];
    

    UIImage * image = [UIImage imageNamed:@"star"];
    CALayer * markLayer = [CALayer layer];
    //    markLayer.backgroundColor = [[UIColor redColor] CGColor];
    markLayer.contents = (id)image.CGImage;
    markLayer.frame = CGRectMake(CGRectGetWidth(button.frame)-24+6, CGRectGetHeight(button.frame)-24+6, 24, 24);
    [button.layer addSublayer:markLayer];

    UIButton * button2 = [[UIButton alloc] initWithFrame:CGRectMake(30, 30, 60, 60)];
    button2.backgroundColor = [UIColor redColor];
    [self.view addSubview:button2];
    
    NSLog(@"%@", NSStringFromCGPoint([button convertPoint:(CGPointZero) toView:self.view]));
    NSLog(@"%@", NSStringFromCGPoint([button convertPoint:(CGPointZero) fromView:self.view]));
    NSLog(@"%@", NSStringFromCGPoint([self.view convertPoint:(CGPointZero) toView:button]));
    NSLog(@"%@", NSStringFromCGPoint([self.view convertPoint:(CGPointZero) fromView:button]));
    
    NSLog(@"%@", NSStringFromCGPoint([button convertPoint:CGPointZero toView:button2]));
    
    UILabel * label = [[UILabel alloc] initWithFrame:(CGRectMake(0, -20, 150, 20))];
    label.text = @"Hello0101";
    label.textColor = [UIColor redColor];
    label.backgroundColor = [UIColor clearColor];
    label.opaque = NO;
    CALayer * subViewLayer = [CALayer layer];
    subViewLayer.contents = (id)[UIImage imageWithView:label].CGImage;
    
    subViewLayer.frame = label.frame;
//    [button.layer addSublayer:subViewLayer];
    
     
    [button.layer addSublayer:label.layer];
    

    
    
    
    
}

-(void)showImageViewTapped:(id)sender{
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectInset(self.view.bounds, 50, 50)];
    imageView.image = [UIImage imageNamed:@"main.jpg"];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [self.view addSubview:imageView];
    
    UILabel * label = [[UILabel alloc] initWithFrame:imageView.bounds];
    label.textColor = [UIColor whiteColor];
    label.text = @"Hello";

    [imageView addSubview:label];
    
    CGPoint center = CGPointMake(imageView.frame.size.width/2, imageView.frame.size.height/2);
    CGFloat radius = sqrtf(pow(CGRectGetHeight(imageView.frame), 2) + pow(CGRectGetWidth(imageView.frame), 2))/2;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0 endAngle:M_PI*2 clockwise:NO];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.lineWidth = 5;
    shapeLayer.fillColor = [UIColor blackColor].CGColor;
    shapeLayer.frame = imageView.layer.bounds;
//    shapeLayer.strokeColor = [UIColor darkGrayColor].CGColor;
    shapeLayer.path = path.CGPath;
//    shapeLayer.affineTransform = CGAffineTransformMakeScale(0.1, 0.1);
    CATransform3D transform = CATransform3DMakeScale(0.1, 0.1, 1);
    shapeLayer.transform = transform;
    imageView.layer.mask = shapeLayer;

    shapeLayer.anchorPoint = CGPointMake(0.5, 0.5);
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    [scale setFromValue:[NSNumber numberWithFloat:0.0f]];
    [scale setToValue:[NSNumber numberWithFloat:1.0f]];
    [scale setDuration:0.5f];
    [scale setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [scale setRemovedOnCompletion:NO];
    [scale setFillMode:kCAFillModeForwards];
    
    [shapeLayer addAnimation:scale forKey:nil];

    
//    [UIView animateWithDuration:0.5 animations:^{
//        
//        shapeLayer.affineTransform = CGAffineTransformIdentity;
//    }];
    
//    [imageView.layer addSublayer:layer];
    
/*
    CGRect layerFrame = imageView.layer.frame;
    imageView.layer.frame = CGRectMake(100, 100, 160.0, 160.0);
    imageView.layer.cornerRadius = 80.0;

    
    
    [UIView animateWithDuration:0.5 animations:^{
        imageView.layer.frame = CGRectMake(100, 100, 320.0, 320.0);
        imageView.layer.cornerRadius = 160.0;
    }];
*/
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
