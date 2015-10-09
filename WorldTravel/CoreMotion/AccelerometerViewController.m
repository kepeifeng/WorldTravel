//
//  AccelerometerViewController.m
//  WorldTravel
//
//  Created by Kent on 10/9/15.
//  Copyright © 2015 Kent Peifeng Ke. All rights reserved.
//

#import "AccelerometerViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface AccelerometerViewController ()
@property (nonatomic, strong) CMMotionManager * motionManager;
@end

@implementation AccelerometerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.accelerometerUpdateInterval = 0.5;
    
    if (self.motionManager.isAccelerometerAvailable) {
        NSOperationQueue * queue = [[NSOperationQueue alloc] init];
        [self.motionManager startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
           
                self.xLabel.text = [NSString stringWithFormat:@"%.2f", accelerometerData.acceleration.x];
                self.xLabel.frame = CGRectMake(CGRectGetWidth(self.view.frame)/2, 80, (CGRectGetWidth(self.view.frame)*accelerometerData.acceleration.x)/2, 60);
                self.yLabel.text = [NSString stringWithFormat:@"%.2f", accelerometerData.acceleration.y];
                self.yLabel.frame = CGRectMake(CGRectGetWidth(self.view.frame)/2, 80 * 2, (CGRectGetWidth(self.view.frame)*accelerometerData.acceleration.y)/2, 60);
                self.zLabel.text = [NSString stringWithFormat:@"%.2f", accelerometerData.acceleration.z];
                self.zLabel.frame = CGRectMake(CGRectGetWidth(self.view.frame)/2, 80 * 3, (CGRectGetWidth(self.view.frame)*accelerometerData.acceleration.z)/2, 60);
            });
        }];
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
