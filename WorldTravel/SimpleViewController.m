//
//  SimpleViewController.m
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 1/10/15.
//  Copyright (c) 2015 Kent Peifeng Ke. All rights reserved.
//

#import "SimpleViewController.h"

@interface SimpleViewController ()

@end

@implementation SimpleViewController
@synthesize text = _text;

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100)/100.0 green:arc4random_uniform(100)/100.0 blue:arc4random_uniform(100)/100.0 alpha:1.000];
        self.text = @"Hello";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = self.backgroundColor;
    self.label.text = self.text;
    

}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"[%@]viewWillAppear",self.text);
    //    if ([self.text isEqualToString:@"1"]) {
    //        self.navigationController.navigationBarHidden = YES;
    //    }else{
    //        self.navigationController.navigationBarHidden = NO;
    //
    //    }
    
}
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    NSLog(@"[%@]viewWillDisappear",self.text);
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    NSLog(@"[%@]viewDidAppear",self.text);
}

-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    NSLog(@"[%@]viewDidDisappear",self.text);
}
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    if ([self.text isEqualToString:@"1"]) {
//        self.navigationController.navigationBarHidden = YES;
//    }else{
//        self.navigationController.navigationBarHidden = NO;
//    
//    }
//}

//-(void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    if ([self.text isEqualToString:@"1"]) {
//        self.navigationController.navigationBarHidden = YES;
//    }else{
//        self.navigationController.navigationBarHidden = NO;
//    
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonTapped:(id)sender {
    
    SimpleViewController * viewController = [[SimpleViewController alloc] init];
    viewController.text = [self.text stringByAppendingString:self.text];
    [self.navigationController pushViewController:viewController animated:YES];
}

-(NSString *)text{
    return _text;
}

-(void)setText:(NSString *)text{
    _text = text;
    self.label.text = text;
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
