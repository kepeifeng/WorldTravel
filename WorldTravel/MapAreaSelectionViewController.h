//
//  MapAreaSelectionViewController.h
//  OfficialDemo3D
//
//  Created by Kent Peifeng Ke on 12/25/14.
//  Copyright (c) 2014 songjian. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "LAMap.h"
#import "MapHelper.h"
#import "KML.h"

#import "LAMapView.h"
@class MapAreaSelectionViewController;
@protocol MapAreaSelectionDelegate <NSObject>

-(void)mapSelectionViewController:(MapAreaSelectionViewController *)viewController didSelectedAreaFromCoordinate:(CLLocationCoordinate2D)startCoordinate toCoordinate:(CLLocationCoordinate2D)endCoordinate;

@end

@interface MapAreaSelectionViewController : UIViewController< UIActionSheetDelegate,
LAMapViewDelegate>
@property (nonatomic, weak) id<MapAreaSelectionDelegate> delegate;
@property (nonatomic, strong) NSArray * excludeMapTypes;
@property (nonatomic, weak) LAMapView * mapView;
@property (nonatomic) LACoordinateRegion mapRegion;
@property (nonatomic) LAMapType mapType;
@property (nonatomic) BOOL displayMapTypeSelector;
@property (nonatomic) BOOL disableAreaSelection;
@property (nonatomic) NSArray * coordinates;
@end
