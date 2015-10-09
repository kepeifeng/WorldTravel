//
//  LAConfigure.h
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 1/14/15.
//  Copyright (c) 2015 Kent Peifeng Ke. All rights reserved.
//

#ifndef WorldTravel_LAConfigure_h
#define WorldTravel_LAConfigure_h

#define GAODE_MAP

#ifdef BAIDU_MAP
#import "BMapKit.h"
#elif defined(APPLE_MAP)
#import <MapKit/MapKit.h>
#elif defined(GAODE_MAP)
#import <MAMapKit/MAMapKit.h>
#endif

#endif
