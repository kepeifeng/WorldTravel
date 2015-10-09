//
//  AlertViewController.m
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 14/11/11.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import "AlertViewController.h"

@interface AlertViewController ()

@end

@implementation AlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
- (IBAction)helloButtonTapped:(id)sender {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Warning!" message:@"Do you want to expose the universe?" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"Cancle" style:(UIAlertActionStyleCancel) handler:NULL];
    [alert addAction:cancelAction];
    
    UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"Just Do It" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        
    }];
    [alert addAction:okAction];
    
    UIAlertAction * thirdAction = [UIAlertAction actionWithTitle:@"Let me think about it" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        
    }];
    [alert addAction:thirdAction];
    [self presentViewController:alert animated:YES completion:NULL];
}

- (IBAction)actionSheetButtonTapped:(id)sender {
    
    UIAlertController * alert = [[UIAlertController alloc] init];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"Hello" style:(UIAlertActionStyleDefault) handler:NULL];
    action.enabled = NO;
    [alert addAction:action];
    [alert addAction:[UIAlertAction actionWithTitle:@"World" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        NSLog(@"Oh");
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:(UIAlertActionStyleCancel) handler:NULL]];
    [self presentViewController:alert animated:YES completion:NULL];
}
- (IBAction)exposeButtonTapped:(id)sender {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Warning!" message:@"Do you want to expose the universe?" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"Cancle" style:(UIAlertActionStyleCancel) handler:NULL];
    [alert addAction:cancelAction];
    UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"Just Do It" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:NULL];

}
- (IBAction)alertViewButtonTapped:(id)sender {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Somebody is watching you!" preferredStyle:(UIAlertControllerStyleAlert)];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:(UIAlertActionStyleCancel) handler:NULL]];
    [self presentViewController:alert animated:YES completion:NULL];


}

@end
