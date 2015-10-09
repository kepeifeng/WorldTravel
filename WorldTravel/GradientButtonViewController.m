//
//  GradientButtonViewController.m
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 1/30/15.
//  Copyright (c) 2015 Kent Peifeng Ke. All rights reserved.
//

#import "GradientButtonViewController.h"

@interface GradientButtonViewController ()

@end

@implementation GradientButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    self.button.backgroundColor = [UIColor lightGrayColor];
    UIColor * startingColor = [UIColor colorWithRed:0.000 green:0.828 blue:0.005 alpha:1.000];
    UIColor * endingColor = [UIColor colorWithRed:0.000 green:0.414 blue:0.002 alpha:1.000];
    UIColor * borderColor = [UIColor colorWithRed:0.000 green:0.549 blue:0.003 alpha:1.000];
    [self.button setStartingGradientColor:startingColor forState:(UIControlStateNormal)];
    [self.button setEndingGradientColor:endingColor forState:(UIControlStateNormal)];
    [self.button setStartingGradientColor:endingColor forState:(UIControlStateHighlighted)];
    [self.button setEndingGradientColor:startingColor forState:(UIControlStateHighlighted)];
    [self.button setBorderColor:borderColor forState:(UIControlStateNormal)];
    self.button.borderWidth = 1;
    self.button.radius = 5;
    [self.button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    
    
    self.button.layer.shadowColor = [[UIColor colorWithWhite:0.000 alpha:0.2] CGColor];
    self.button.layer.shadowOffset = CGSizeMake(0, 3);
    self.button.layer.shadowOpacity = 1;

    self.button.enabled = NO;
    
    
    [self.squareButton setStartingGradientColor:startingColor forState:(UIControlStateNormal)];
    [self.squareButton setEndingGradientColor:endingColor forState:(UIControlStateNormal)];
    [self.squareButton setStartingGradientColor:endingColor forState:(UIControlStateHighlighted)];
    [self.squareButton setEndingGradientColor:startingColor forState:(UIControlStateHighlighted)];
    [self.squareButton setBorderColor:borderColor forState:(UIControlStateNormal)];
    self.squareButton.borderWidth = 1;
    self.squareButton.radius = 5;
    [self.squareButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    
    [self.squareButton.titleLabel setNumberOfLines:2];

    
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    scrollView.userInteractionEnabled = YES;
//    scrollView.exclusiveTouch = YES;
//    scrollView.canCancelContentTouches = YES;
//    scrollView.delaysContentTouches = YES;
//    
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:scrollView];
    scrollView.scrollEnabled = YES;
    scrollView.showsVerticalScrollIndicator = YES;
    [self.button removeFromSuperview];
    [scrollView addSubview:self.button];
    [scrollView addSubview:self.squareButton];
    
    CGFloat buttonHeight = 40;
    for (NSInteger i=0; i<=AKGradientButtonBlack; i++) {
        UIButton * button = [AKGradientButton buttonWithPreset:i];
        button.frame = CGRectMake(80, CGRectGetMaxY(self.squareButton.frame)+ 10 +i*(buttonHeight+10), 160, buttonHeight);
        [button setTitle:@"Button" forState:(UIControlStateNormal)];
        [scrollView addSubview:button];
        scrollView.contentSize = CGSizeMake(320, CGRectGetMaxY(button.frame));
    }
    
    
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
