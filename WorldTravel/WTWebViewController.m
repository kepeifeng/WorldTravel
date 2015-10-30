//
//  WTWebViewController.m
//  WorldTravel
//
//  Created by Kent on 10/21/15.
//  Copyright © 2015 Kent Peifeng Ke. All rights reserved.
//

#import "WTWebViewController.h"

@interface WTWebViewController ()<UIWebViewDelegate>

@end

@implementation WTWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIWebView * webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.delegate = self;
    webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:webView];
    NSURL * url = [[NSBundle mainBundle] URLForResource:@"page" withExtension:@"html"];
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:url];
    [webView loadRequest:request];
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
