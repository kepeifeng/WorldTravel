//
//  GyroViewController.m
//  WorldTravel
//
//  Created by Kent on 10/9/15.
//  Copyright © 2015 Kent Peifeng Ke. All rights reserved.
//

#import "GyroViewController.h"

#import <CoreMotion/CoreMotion.h>
@interface GyroViewController ()

@property (nonatomic, strong) CMMotionManager * motionManager;
@end

@implementation GyroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.gyroUpdateInterval = 0.5;
    
    if (self.motionManager.isAccelerometerAvailable) {
        NSOperationQueue * queue = [[NSOperationQueue alloc] init];
        [self.motionManager startGyroUpdatesToQueue:queue withHandler:^(CMGyroData * _Nullable gyroData, NSError * _Nullable error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.xLabel.text = [NSString stringWithFormat:@"%.2f", gyroData.rotationRate.x];
                self.xLabel.frame = CGRectMake(CGRectGetWidth(self.view.frame)/2, 80, (CGRectGetWidth(self.view.frame)*gyroData.rotationRate.x)/2, 60);
                self.yLabel.text = [NSString stringWithFormat:@"%.2f", gyroData.rotationRate.y];
                self.yLabel.frame = CGRectMake(CGRectGetWidth(self.view.frame)/2, 80 * 2, (CGRectGetWidth(self.view.frame)*gyroData.rotationRate.y)/2, 60);
                self.zLabel.text = [NSString stringWithFormat:@"%.2f", gyroData.rotationRate.z];
                self.zLabel.frame = CGRectMake(CGRectGetWidth(self.view.frame)/2, 80 * 3, (CGRectGetWidth(self.view.frame)*gyroData.rotationRate.z)/2, 60);
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
