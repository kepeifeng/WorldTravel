//
//  NavigationBarViewController.m
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 14/11/7.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import "NavigationBarViewController.h"
#import "AKNavigationBar.h"

@interface NavigationBarViewController ()

@end

@implementation NavigationBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.navigationBarBackgroundColor = [UIColor colorWithRed:0.841 green:0.143 blue:0.230 alpha:1.000];

    self.navigationItem.rightBarButtonItem = [[AKBarButtonItem alloc] initWithTitle:@"历史纪录" style:(UIBarButtonItemStylePlain) target:self action:@selector(historyButtonTapped:)];
    self.navigationItem.leftBarButtonItem = [[AKBarButtonItem alloc] initWithTitle:@"历史纪录" style:(UIBarButtonItemStylePlain) target:self action:@selector(historyButtonTapped:)];
    self.navigationItem.leftItemsSupplementBackButton = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)historyButtonTapped:(id)sender{
    NSLog(@"historyButtonTapped");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
