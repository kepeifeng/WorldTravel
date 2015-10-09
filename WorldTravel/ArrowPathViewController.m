//
//  ArrowPathViewController.m
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 2/27/15.
//  Copyright (c) 2015 Kent Peifeng Ke. All rights reserved.
//

#import "ArrowPathViewController.h"
#import "ArrowPathView.h"

@interface ArrowPathViewController (){
    CGPoint lastPoint;
    
}

@end

@implementation ArrowPathViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ArrowPathView * arrowPathView = [[ArrowPathView alloc] initWithFrame:self.view.frame];
    arrowPathView.autoresizingMask = UIViewAutoresizingFlexibleHeight |UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:arrowPathView];
    

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
