//
//  LocationPickerViewController.h
//  2bulu-QuanZi
//
//  Created by Kent Peifeng Ke on 14-7-8.
//  Copyright (c) 2014年 Lolaage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"

@protocol LocationPickerDelegate;

@interface LocationPickerValue : NSObject
-(instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title subtitle:(NSString *)subtitle;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic) NSString * title;
@property (nonatomic) NSString * subtitle;

@end

@interface LocationPickerViewController : UIViewController
@property (nonatomic, weak) id<LocationPickerDelegate> delegate;
@property (nonatomic) NSString * doneButtonTitle;
@property (nonatomic) BOOL shouldEditTitle;
@property (nonatomic) BOOL displayZoomControls;
@property (nonatomic) LocationPickerValue * location;
@property (nonatomic) BOOL useGPSCoordinate;
@end

@protocol LocationPickerDelegate <NSObject>
@optional
-(void)locationPicker:(id)locationPicker didPickedLocation:(CLLocationCoordinate2D)coordinate withTitle:(NSString *)title subTitle:(NSString *)subTitle;


@end
