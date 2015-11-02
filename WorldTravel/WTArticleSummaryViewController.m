//
//  WTArticleSummaryViewController.m
//  WorldTravel
//
//  Created by Kent on 11/2/15.
//  Copyright © 2015 Kent Peifeng Ke. All rights reserved.
//

#import "WTArticleSummaryViewController.h"
#import "WTVerticalTextView.h"

@interface WTArticleSummaryViewController ()

@end

@implementation WTArticleSummaryViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect frame = self.view.bounds;
    frame.origin.y = 64;
    frame.size.height -= 64*2;
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:frame];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    WTVerticalTextView * textView = [[WTVerticalTextView alloc] initWithFrame:self.view.bounds];
    textView.text = self.articleEntity.summary;
    textView.font = [UIFont fontWithName:FONT_NAME size:ARTICLE_FONT_SIZE];
    CGSize size = [textView sizeThatFits:CGSizeMake(9999, CGRectGetHeight(scrollView.bounds))];
    textView.frame = CGRectMake(0, 0, size.width, size.height);
    
    [scrollView addSubview:textView];
    scrollView.contentSize = size;
    CGFloat width = MAX(size.width, CGRectGetWidth(scrollView.bounds) - scrollView.contentInset.right);
    
    scrollView.contentOffset = CGPointMake(width - CGRectGetWidth(scrollView.bounds) + scrollView.contentInset.right, -scrollView.contentInset.top);

    self.navigationController.toolbarHidden = NO;
    self.navigationController.navigationBarHidden = YES;
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:(UIBarButtonItemStylePlain) target:self action:@selector(backButtonTapped:)];
    
    self.toolbarItems = @[backItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backButtonTapped:(id)sender{

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
