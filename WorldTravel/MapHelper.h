//
//  MapHelper.h
//  officialDemo2D
//
//  Created by Kent Peifeng Ke on 12/19/14.
//  Copyright (c) 2014 AutoNavi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "LAMap.h"

@interface MapTile : NSObject<NSCopying, NSCoding>

-(instancetype)initWithX:(NSInteger)x Y:(NSInteger)y zoomLevel:(NSInteger)zoomLevel;

@property (nonatomic) NSInteger x;
@property (nonatomic) NSInteger y;
@property (nonatomic) NSInteger zoomLevel;

@property (nonatomic, readonly) CGPoint pointValue;

@end

@interface MapHelper : NSObject
+(MapTile *)coordinateToTilePosition:(CLLocationCoordinate2D) coordinate atZoomLevel:(NSInteger)zoomLevel;

+(CLLocationCoordinate2D)tilePositionToCoordinate:(CGPoint)tilePosition asZoomLevel:(NSInteger)zoomLevel;


+(NSInteger)numberTilesFromCoordinate:(CLLocationCoordinate2D)startCoordinate toCoordinate:(CLLocationCoordinate2D)endCoordinate atZoomLevel:(NSInteger)zoomLevel;

+(NSString *)urlForTileAtZoomLevel:(NSInteger)zoomLevel x:(NSInteger)x y:(NSInteger)y mapType:(LAMapType)mapType;
@end
