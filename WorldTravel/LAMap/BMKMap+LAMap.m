//
//  BMKMapView+LAMapAdopt.m
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 1/13/15.
//  Copyright (c) 2015 Kent Peifeng Ke. All rights reserved.
//

#import "BMKMap+LAMap.h"

@implementation BMKMapView(LAMap)

//@synthesize showsBuildings = _showsBuildings;
//@synthesize pitchEnabled = _pitchEnabled;
//@synthesize showsPointsOfInterest = _showsPointsOfInterest;

-(NSSet *)annotationsInMapRect:(LAMapRect)mapRect{
    return nil;
}

-(void)setZoomLevel:(float)zoomLevel animated:(BOOL)animated{
    self.zoomLevel = zoomLevel;
}

-(NSArray *)selectedAnnotations{
    return nil;
}

-(CGRect)annotationVisibleRect{
    return CGRectNull;
}

-(void)setUserTrackingMode:(LAUserTrackingMode)mode animated:(BOOL)animated{
    [super setUserTrackingMode:(BMKUserTrackingMode)mode];
}





@end

@implementation LATileOverlay

@synthesize geometryFlipped = _geometryFlipped;
@synthesize tileSize = _tileSize;
@synthesize minimumZ = _minimumZ;
@synthesize maximumZ = _maximumZ;
@synthesize URLTemplate = _URLTemplate;
@synthesize canReplaceMapContent = _canReplaceMapContent;
@synthesize coordinate = _coordinate;
@synthesize boundingMapRect = _boundingMapRect;

-(instancetype)initWithURLTemplate:(NSString *)URLTemplate{
    self = [super init];
    if (self) {
        _URLTemplate = URLTemplate;
        _tileSize = CGSizeMake(256, 256);
        _geometryFlipped = NO;
    }
    return self;
}

@end

@implementation LATileOverlayView
-(instancetype)initWithTileOverlay:(id)overlay{
    self = [super initWithOverlay:overlay];
    return self;
}

@end

@implementation BMKPolylineView (LAMap)

-(void)setLineJoin:(CGLineJoin)lineJoin{
}
-(CGLineJoin)lineJoin{
    return 0;
}

-(void)setLineCap:(CGLineCap)lineCap{

}

-(CGLineCap)lineCap{
    return 0;
}


@end

@implementation BMKUserLocation (LAMap)

-(CLHeading *)heading{
    return nil;
}

@end