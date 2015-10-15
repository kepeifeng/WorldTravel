//
//  WTActivityViewController.m
//  WorldTravel
//
//  Created by Kent on 10/12/15.
//  Copyright © 2015 Kent Peifeng Ke. All rights reserved.
//

#import "WTActivityViewController.h"
#import "WTCopyQuoteActivity.h"
@interface WTActivityViewController ()

@end

@implementation WTActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)shareButtonTapped:(id)sender {
    
    NSString * text = @"回乐峰前沙似雪，受降城外月如霜。不知何处吹芦管，一夜征人尽望乡。";
    NSURL * url = [NSURL URLWithString:@"http://www.coffeeandsandwich.com"];
    UIImage * image = [UIImage imageNamed:@"main.jpg"];
    
    WTCopyQuoteActivity * copyActivity = [[WTCopyQuoteActivity alloc] init];

    UIActivityViewController * activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[text, url, image]
                                                                                          applicationActivities:@[copyActivity]];

    [self presentViewController:activityViewController animated:YES completion:NULL];
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


