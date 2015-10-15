//
//  WTDocumentViewController.m
//  WorldTravel
//
//  Created by Kent on 10/12/15.
//  Copyright © 2015 Kent Peifeng Ke. All rights reserved.
//

#import "WTDocumentViewController.h"

@interface WTDocumentViewController ()

@end

@implementation WTDocumentViewController
{
    
    UIDocumentInteractionController * _documentController;//yes, you must retain it, or the app will crash when a app selected.
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)openButtonTapped:(id)sender {
    @try {
        NSURL * url = [[NSBundle mainBundle] URLForResource:@"main@2x" withExtension:@"jpg"];
        _documentController = [UIDocumentInteractionController interactionControllerWithURL:url];
        [_documentController presentOpenInMenuFromRect:self.view.bounds inView:self.view animated:YES];
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }

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
