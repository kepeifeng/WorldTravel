//
//  MKMapView+LAMapAdopt.m
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 1/13/15.
//  Copyright (c) 2015 Kent Peifeng Ke. All rights reserved.
//

#import "MKMap+LAMap.h"

@implementation MKMapView(LAMap)
//@synthesize maxZoomLevel = _maxZoomLevel;
//@synthesize minZoomLevel = _minZoomLevel;
//@synthesize zoomLevel = _zoomLevel;
//@synthesize rotation = _rotation;
//@synthesize overlooking = _overlooking;
-(void)setZoomLevel:(float)zoomLevel animated:(BOOL)animated{

}
@end


@implementation LATileOverlayView
-(instancetype)initWithTileOverlay:(id)overlay{
    self = [super init];
    return self;
}

@end