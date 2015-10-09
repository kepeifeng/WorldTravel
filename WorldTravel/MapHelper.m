//
//  MapHelper.m
//  officialDemo2D
//
//  Created by Kent Peifeng Ke on 12/19/14.
//  Copyright (c) 2014 AutoNavi. All rights reserved.
//

#import "MapHelper.h"
#import <math.h>
@implementation MapTile

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _x = [aDecoder decodeIntegerForKey:@"x"];
        _y = [aDecoder decodeIntegerForKey:@"y"];
        _zoomLevel = [aDecoder decodeIntegerForKey:@"zoomLevel"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{

    [aCoder encodeInteger:_x forKey:@"x"];
    [aCoder encodeInteger:_y forKey:@"y"];
    [aCoder encodeInteger:_zoomLevel forKey:@"zoomLevel"];
}

-(instancetype)initWithX:(NSInteger)x Y:(NSInteger)y zoomLevel:(NSInteger)zoomLevel
{
    self = [super init];
    if (self) {
        _x = x;
        _y = y;
        _zoomLevel = zoomLevel;
    }
    return self;
}

-(CGPoint)pointValue{
    return CGPointMake(_x, _y);
}

-(id)copyWithZone:(NSZone *)zone{
    
    MapTile * newTile = [[MapTile alloc] initWithX:_x Y:_y zoomLevel:_zoomLevel];
    return newTile;
}

@end

@implementation MapHelper
+(MapTile *)coordinateToTilePosition:(CLLocationCoordinate2D) coordinate atZoomLevel:(NSInteger)zoomLevel{
    
    float x = (float)((coordinate.longitude + 180.0) / 360.0 * (1 << zoomLevel));
    float y = (float)((1.0 - log(tan(coordinate.latitude * M_PI / 180.0) + 1.0 / cos(coordinate.latitude * M_PI / 180.0)) / M_PI) / 2.0 * (1 << zoomLevel));
    
    return [[MapTile alloc] initWithX:x Y:y zoomLevel:zoomLevel];
//    return CGPointMake((NSInteger)x, (NSInteger)y);
    
    
}


+(CLLocationCoordinate2D)tilePositionToCoordinate:(CGPoint)tilePosition asZoomLevel:(NSInteger)zoomLevel{
    
    double n = M_PI - ((2.0 * M_PI * tilePosition.y) / pow(2.0, zoomLevel));
    
    double x = (float)((tilePosition.x / pow(2.0, zoomLevel) * 360.0) - 180.0);
    double y = (float)(180.0 / M_PI * atan(sinh(n)));
    //
    return CLLocationCoordinate2DMake(x, y);
}

+(NSInteger)numberTilesFromCoordinate:(CLLocationCoordinate2D)startCoordinate toCoordinate:(CLLocationCoordinate2D)endCoordinate atZoomLevel:(NSInteger)zoomLevel{

    MapTile * startTilePosition = [self coordinateToTilePosition:startCoordinate atZoomLevel:zoomLevel];
    MapTile * endTilePosition = [self coordinateToTilePosition:endCoordinate atZoomLevel:zoomLevel];
    
    NSInteger totalNumber = (abs(endTilePosition.x - startTilePosition.x)+1) * (abs(endTilePosition.y - startTilePosition.y)+1);
    return totalNumber;

}

+(NSString *)urlForTileAtZoomLevel:(NSInteger)zoomLevel x:(NSInteger)x y:(NSInteger)y mapType:(LAMapType)mapType
{
    NSString * url;
    
    switch (mapType) {
        case LAMapTypeOpenStreetMap:
            url = [NSString stringWithFormat:@"http://tile.openstreetmap.org/%d/%d/%d.png",zoomLevel, x, y];
            break;
        case LAMapTypeOpenCycleMap:
            url = [NSString stringWithFormat:@"http://tile.opencyclemap.org/cycle/%d/%d/%d.png",zoomLevel, x, y];
            break;
        case LAMapTypeGoogleSatellite:
            url = [NSString stringWithFormat:@"http://mt1.google.cn/vt/lyrs=y&hl=zh-CN&gl=cn&x=%d&y=%d&z=%d",x,y,zoomLevel];
            break;
        default:
            url = nil;
            break;
    }
    return url;
    
}

@end
