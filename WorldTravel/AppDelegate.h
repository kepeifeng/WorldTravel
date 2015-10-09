//
//  AppDelegate.h
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 14-5-5.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate, UINavigationControllerDelegate,
UIGestureRecognizerDelegate>{
#ifdef BAIDU_MAP
    BMKMapManager *_mapManager;
#endif
}

@property (strong, nonatomic) UIWindow *window;



@end
