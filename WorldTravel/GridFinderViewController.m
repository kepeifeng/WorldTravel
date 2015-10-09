//
//  GridFinderViewController.m
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 1/5/15.
//  Copyright (c) 2015 Kent Peifeng Ke. All rights reserved.
//

#import "GridFinderViewController.h"
#import "GridView.h"

@interface GridFinderViewController ()

@end

@implementation GridFinderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSInteger edgeLength = MIN(CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
    NSInteger margin = 20.0;
    CGRect rect = CGRectMake((CGRectGetWidth(self.view.frame) - edgeLength)/2, (CGRectGetHeight(self.view.frame) - edgeLength)/2, edgeLength, edgeLength);
    rect = CGRectInset(rect, margin, margin);
    GridView * view  = [[GridView alloc] initWithFrame:rect rows:20 columns:20];
    view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:view];
    
//    useVisionLine(1, 0, 3, 3);
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

@end
