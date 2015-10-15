//
//  TodayViewController.m
//  TodayExtension
//
//  Created by Kent on 10/10/15.
//  Copyright © 2015 Kent Peifeng Ke. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self updateContent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateContent{

    NSString * path = [[NSBundle mainBundle] pathForResource:@"tangshi" ofType:@"plist"];
    NSArray * poemArray = [NSArray arrayWithContentsOfFile:path];
    if (poemArray.count == 0) {
        return;
    }
    
    NSDictionary * poem = [poemArray objectAtIndex:arc4random_uniform(poemArray.count - 1)];
    NSString * content = poem[@"content"];
    self.contentLabel.text = content;
    CGRect frame = self.view.frame;
    CGSize size = [self.contentLabel sizeThatFits:self.view.frame.size];
//    self.contentLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), size.height + 20);
    self.preferredContentSize = CGSizeMake(0, size.height + 20);
    
}

-(UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets{

    return UIEdgeInsetsZero;
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    [self updateContent];
    
    completionHandler(NCUpdateResultNewData);
}

@end
