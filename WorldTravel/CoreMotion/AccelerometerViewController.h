//
//  AccelerometerViewController.h
//  WorldTravel
//
//  Created by Kent on 10/9/15.
//  Copyright © 2015 Kent Peifeng Ke. All rights reserved.
//

#import <UIKit/UIKit.h>

//https://developer.apple.com/library/ios/documentation/CoreMotion/Reference/CoreMotion_Reference/

@interface AccelerometerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *xLabel;
@property (weak, nonatomic) IBOutlet UILabel *yLabel;
@property (weak, nonatomic) IBOutlet UILabel *zLabel;

@end
