//
//  CustomModalViewController.m
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 14/10/31.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import "CustomModalViewController.h"

@interface CustomModalViewController ()

@end

@implementation CustomModalViewController

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
- (IBAction)buttonTapped:(id)sender {
    
//    [self fadeOut];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)fadeOut
{
    [UIView animateWithDuration:0.3f animations:^{
        self.view.alpha = 0.0f;
    } completion:^(BOOL completed) {
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }];
}

@end
