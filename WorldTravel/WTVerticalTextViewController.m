//
//  WTVerticalTextViewController.m
//  WorldTravel
//
//  Created by Kent on 10/30/15.
//  Copyright © 2015 Kent Peifeng Ke. All rights reserved.
//

#import "WTVerticalTextViewController.h"
#import "WTVerticalTextView.h"
@interface WTVerticalTextViewController ()

@end

@implementation WTVerticalTextViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    WTVerticalTextView * textView = [[WTVerticalTextView alloc] initWithFrame:self.view.bounds];
    textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    textView.backgroundColor = [UIColor whiteColor];
//    textView.font = [UIFont fontWithName:@"ChekiangShuKeSung" size:18];
//    textView.font = [UIFont fontWithName:@"LiSongPro" size:18];
    textView.font = [UIFont fontWithName:@"TpldYiFengScripture" size:18];
    textView.text = @"春宵一刻值千金, Come on baby on more time.\n精誠所至,金石為開\n精诚所至,金石为开";
    [self.view addSubview:textView];
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
