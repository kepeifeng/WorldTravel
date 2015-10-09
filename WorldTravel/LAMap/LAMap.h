//
//  LAMap.h
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 1/13/15.
//  Copyright (c) 2015 Kent Peifeng Ke. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "LAMapDefine.h"

#ifdef BAIDU_MAP
#import "BMKMap+LAMap.h"
#elif defined(APPLE_MAP)
#import "MKMap+LAMap.h"
#elif defined(GAODE_MAP)
#import "MAMap+LAMap.h"
#endif
