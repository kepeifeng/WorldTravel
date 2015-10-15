//
//  WTCopyQuoteViewController.m
//  WorldTravel
//
//  Created by Kent on 10/12/15.
//  Copyright © 2015 Kent Peifeng Ke. All rights reserved.
//

#import "WTCopyQuoteViewController.h"

@interface WTCopyQuoteViewController ()

@end

@implementation WTCopyQuoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.frame = CGRectMake(20, 20, 280, 200);
    
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;

    self.view.backgroundColor = [UIColor clearColor];
    UIView * overlayView = [[UIView alloc] initWithFrame:self.view.bounds];
    overlayView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:overlayView];
    
    UIView * contentView = [[UIView alloc] initWithFrame:(CGRectMake(20, 20, CGRectGetWidth(self.view.bounds) - 20 * 2, 200.0f))];
    contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:contentView];
    
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.borderWidth = 1.0f;
    contentView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    contentView.layer.cornerRadius = 5.0f;
    
    UIButton * cancelButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    cancelButton.frame = CGRectMake(0, 0, 80, 40);
    [cancelButton setTitle:@"Cancel" forState:(UIControlStateNormal)];
    [cancelButton addTarget:self action:@selector(cancelButtonTapped:) forControlEvents:(UIControlEventTouchUpInside)];
    [contentView addSubview:cancelButton];
    
    UILabel * textLabel = [[UILabel alloc] initWithFrame:(CGRectMake(10, 40, CGRectGetWidth(contentView.bounds) - 20, 120))];
    textLabel.text = self.text;
    textLabel.numberOfLines = 0;
    [contentView addSubview:textLabel];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)cancelButtonTapped:(id)sender{

    [self dismissViewControllerAnimated:YES completion:NULL];
    
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
