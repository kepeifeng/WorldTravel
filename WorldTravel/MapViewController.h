//
//  MapViewController.h
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 14-6-26.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LAMap.h"
#import "LAMapView.h"
@interface MapViewController : UIViewController
@property (weak, nonatomic) IBOutlet LAMapView *mapView;

@end
