//
//  AppDelegate.h
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 14-5-5.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    BMKMapManager *_mapManager;
}

@property (strong, nonatomic) UIWindow *window;



@end
