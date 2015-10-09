//
//  LAAnnotation.h
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 1/14/15.
//  Copyright (c) 2015 Kent Peifeng Ke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LAConfigure.h"
#import "LAGeometry.h"

//#ifdef BAIDU_MAP
//@protocol LAAnnotation <BMKAnnotation>
//#elif defined(APPLE_MAP)
//@protocol LAAnnotation <MKAnnotation>
//#endif
//@end




#ifdef BAIDU_MAP


#define LAMapView BMKMapView

#define LAAnnotation BMKAnnotation
#define LAOverlay BMKOverlay
#define LAPointAnnotation BMKPointAnnotation
#define LACircle BMKCircle
#define LAPolygon BMKPolygon
#define LAPolyline BMKPolyline
#define LAAnnotationView BMKAnnotationView
#define LAPolylineView BMKPolylineView
#define LACircleView BMKCircleView
#define LAPolygonView BMKPolygonView
#define LAAnnotationView BMKAnnotationView
#define LAOverlayView BMKOverlayView
#define LAOverlayPathView BMKOverlayPathView
#define LAPinAnnotationView BMKPinAnnotationView

#define LAUserLocation BMKUserLocation







#elif defined(APPLE_MAP)


#define LAMapView MKMapView

//typedef MKPointAnnotation LAPointAnnotation;
#define LAAnnotation MKAnnotation
#define LAOverlay MKOverlay
#define LAPointAnnotation MKPointAnnotation
#define LACircle MKCircle
#define LAPolygon MKPolygon
#define LAPolyline MKPolyline
#define LATileOverlay MKTileOverlay
#define LAAnnotationView MKAnnotationView
#define LAPolylineView MKPolylineView
#define LACircleView MKCircleView
#define LAPolygonView MKPolygonView
#define LAAnnotationView MKAnnotationView
#define LAOverlayView MKOverlayView
#define LAOverlayPathView MKOverlayPathView
#define LAPinAnnotationView MKPinAnnotationView

#define LAUserLocation MKUserLocation

//typedef MKCircle LACircle;
//typedef MKPolygon LAPolygon;
//typedef MKPolyline LAPolyline;
//typedef MKTileOverlay LATileOverlay;
//typedef MKAnnotationView LAAnnotationView;
//typedef MKPolylineView LAPolylineView;
//typedef MKCircleView LACircleView;
//typedef MKPolygonView LAPolygonView;
//typedef MKAnnotationView LAAnnotationView;

//@interface LAPointAnnotation : MKPointAnnotation<LAShape>
//@end
//
//@interface LACircle : MKCircle<LAMultiPoint, LAOverlay>
//
//@end
//
//@interface LAPolygon : MKPolygon<LAMultiPoint, LAOverlay>
//
//@end
//
//@interface LAPolyline : MKPolyline<LAMultiPoint, LAOverlay>
//
//@end
//
//@interface LATileOverlay : MKTileOverlay<LAOverlay>
//@end


//@interface LAOverlayView:MKOverlayView
//
//@end

//typedef MKOverlayView LAOverlayView;
//typedef MKOverlayPathView LAOverlayPathView;
//typedef MKPinAnnotationView LAPinAnnotationView;

//@interface LAAnnotationView : MKAnnotationView
//@end
//@interface LAPolylineView : MKPolylineView
//@end




//@interface LACircleView : MKCircleView
//@end
//@interface LAPolygonView : MKPolygonView
//@end
//@interface LAAnnotationView : MKAnnotationView
//@end

#elif defined(GAODE_MAP)

//#define LAMapView MAMapView

#define LAAnnotation MAAnnotation
#define LAOverlay MAOverlay
#define LAPointAnnotation MAPointAnnotation
#define LACircle MACircle
#define LAPolygon MAPolygon
#define LAPolyline MAPolyline
#define LATileOverlay MATileOverlay
#define LAAnnotationView MAAnnotationView
#define LAPolylineView MAPolylineView
#define LACircleView MACircleView
#define LAPolygonView MAPolygonView
#define LAAnnotationView MAAnnotationView
#define LAOverlayView MAOverlayView
#define LAOverlayPathView MAOverlayPathView
#define LAPinAnnotationView MAPinAnnotationView

#define LAUserLocation MAUserLocation


#endif

@protocol LATileOverlayProtocol <NSObject, LAOverlay>

- (instancetype)initWithURLTemplate:(NSString *)URLTemplate; // URL template is a string where the substrings "{x}", "{y}", "{z}", and "{scale}" are replaced with values from a tile path to create a URL to load. For example: http://server/path?x={x}&y={y}&z={z}&scale={scale}.

@property CGSize tileSize; // default is 256x256

@property (getter=isGeometryFlipped) BOOL geometryFlipped; // Default is NO. If NO, a tile at x=0, y=0 is the upper left, otherwise it is in the lower left.

// The minimum/maximum zoom level at which tile data is available for this overlay. A tile at level 0 covers the entire world, at level 1 it covers 1/4th of the world, at level 2 it covers 1/16th of the world, and so on.
@property NSInteger minimumZ;
@property NSInteger maximumZ;

@property (readonly) NSString *URLTemplate;

@property (nonatomic) BOOL canReplaceMapContent;

@end

@protocol LAAnnotationViewProtocol <NSObject>

@property (nonatomic) UIView * calloutView;

@end


