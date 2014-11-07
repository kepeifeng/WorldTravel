//
//  AnimationViewController.m
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 14/10/31.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import "AnimationViewController.h"

@interface AnimationViewController ()
@property (weak, nonatomic) IBOutlet UIView *blockView;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)goTapped:(id)sender {
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformTranslate(transform, 0, -CGRectGetHeight(self.view.frame));
    transform = CGAffineTransformRotate(transform, 0.35);
    self.blockView.transform = transform;
//    [UIView animateWithDuration:0.5 delay:0 options:(UIViewAnimationOptionCurveEaseOut) animations:^{
//        self.blockView.transform = CGAffineTransformIdentity;
//    } completion:NULL];
    self.bgView.alpha = 0;
    [UIView animateWithDuration:0.5 delay:0 options:(UIViewAnimationOptionCurveEaseOut) animations:^{
        
        self.bgView.alpha = 1;
//        self.blockView.transform = CGAffineTransformIdentity;
    } completion:NULL];
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.2 options:0 animations:^{
        self.blockView.transform = CGAffineTransformIdentity;
    } completion:NULL];
    
}

@end
