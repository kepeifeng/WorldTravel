//
//  RotateImageViewController.m
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 14-8-15.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import "RotateImageViewController.h"

@interface RotateImageViewController ()

@end

@implementation RotateImageViewController

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
    // Do any additional setup after loading the view from its nib.
    
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = @0.0f;
    animation.toValue = @(2*M_PI);
    animation.duration = 1.0f;             // this might be too fast
    animation.repeatCount = HUGE_VALF;     // HUGE_VALF is defined in math.h so import it
    [self.imageView.layer addAnimation:animation forKey:@"rotation"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
