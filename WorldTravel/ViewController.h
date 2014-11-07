//
//  ViewController.h
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 14-5-5.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"

@interface ViewController : UIViewController<BMKMapViewDelegate>
@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
- (IBAction)fineMeButtonTapped:(id)sender;
- (IBAction)profileButtonTapped:(id)sender;

/**
 *  这是一条Objective-C的消息
 *
 *  @param someString 某一个字符串
 */
-(void)someMessage:(NSString *)someString;
@end
