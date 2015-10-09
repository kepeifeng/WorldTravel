//
//  BMKMapView+LAMapAdopt.h
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 1/13/15.
//  Copyright (c) 2015 Kent Peifeng Ke. All rights reserved.
//

#import "BMKMapView.h"
#import "LAMapDefine.h"
#import "BMapKit.h"



#define LAMapSizeWorld BMKMapSizeWorld
// The rect that contains every map point in the world.
#define LAMapRectWorld BMKMapRectWorld
NS_INLINE LACoordinateSpan LACoordinateSpanMake(CLLocationDegrees latitudeDelta, CLLocationDegrees longitudeDelta)
{
    return BMKCoordinateSpanMake(latitudeDelta, longitudeDelta);
}

NS_INLINE LACoordinateRegion MKCoordinateRegionMake(CLLocationCoordinate2D centerCoordinate, LACoordinateSpan span)
{
    return BMKCoordinateRegionMake(centerCoordinate, span);
}

NS_INLINE LACoordinateRegion LACoordinateRegionMakeWithDistance(CLLocationCoordinate2D centerCoordinate, CLLocationDistance latitudinalMeters, CLLocationDistance longitudinalMeters){
    return BMKCoordinateRegionMakeWithDistance(centerCoordinate, latitudinalMeters, longitudinalMeters);
}

// Conversion between unprojected and projected coordinates
NS_INLINE LAMapPoint LAMapPointForCoordinate(CLLocationCoordinate2D coordinate){
    return BMKMapPointForCoordinate(coordinate);
};


NS_INLINE CLLocationCoordinate2D LACoordinateForMapPoint(LAMapPoint mapPoint){
    return BMKCoordinateForMapPoint(mapPoint);
};

// Conversion between distances and projected coordinates
NS_INLINE CLLocationDistance LAMetersPerMapPointAtLatitude(CLLocationDegrees latitude){
    return BMKMetersPerMapPointAtLatitude(latitude);
};
NS_INLINE double LAMapPointsPerMeterAtLatitude(CLLocationDegrees latitude){
    return BMKMapPointsPerMeterAtLatitude(latitude);
};

NS_INLINE CLLocationDistance LAMetersBetweenMapPoints(LAMapPoint a, LAMapPoint b){
    return BMKMetersBetweenMapPoints(a, b);
};

#define LAMapRectNull BMKMapRectNull

#if (__IPHONE_4_0 <= __IPHONE_OS_VERSION_MAX_ALLOWED || __MAC_10_9 <= __MAC_OS_X_VERSION_MAX_ALLOWED)

// Geometric operations on LAMapPoint/Size/Rect.  See CGGeometry.h for
// information on the CGFloat versions of these functions.
NS_INLINE LAMapPoint LAMapPointMake(double x, double y) {
    return BMKMapPointMake(x,y);
}
NS_INLINE LAMapSize LAMapSizeMake(double width, double height){
    return BMKMapSizeMake(width, height);
}
NS_INLINE LAMapRect LAMapRectMake(double x, double y, double width, double height){
    return BMKMapRectMake( x,  y,  width,  height);
}
NS_INLINE double LAMapRectGetMinX(LAMapRect rect){
    return BMKMapRectGetMinX(rect);
}
NS_INLINE double LAMapRectGetMinY(LAMapRect rect){
    return BMKMapRectGetMinY( rect);
}
NS_INLINE double LAMapRectGetMidX(LAMapRect rect){
    return BMKMapRectGetMidX( rect);
}
NS_INLINE double LAMapRectGetMidY(LAMapRect rect){
    return BMKMapRectGetMidY( rect);
}
NS_INLINE double LAMapRectGetMaxX(LAMapRect rect){
    return BMKMapRectGetMaxX( rect);
}
NS_INLINE double LAMapRectGetMaxY(LAMapRect rect){
    return BMKMapRectGetMaxY( rect);
}
NS_INLINE double LAMapRectGetWidth(LAMapRect rect){
    return BMKMapRectGetWidth( rect);
}
NS_INLINE double LAMapRectGetHeight(LAMapRect rect){
    return BMKMapRectGetHeight( rect);
}
NS_INLINE BOOL LAMapPointEqualToPoint(LAMapPoint point1, LAMapPoint point2){
    return BMKMapPointEqualToPoint( point1,  point2);
}
NS_INLINE BOOL LAMapSizeEqualToSize(LAMapSize size1, LAMapSize size2){
    return BMKMapSizeEqualToSize( size1,  size2);
}
NS_INLINE BOOL LAMapRectEqualToRect(LAMapRect rect1, LAMapRect rect2){
    return BMKMapRectEqualToRect( rect1,  rect2);
}

NS_INLINE BOOL LAMapRectIsNull(LAMapRect rect){
    return BMKMapRectIsNull( rect);
}

NS_INLINE BOOL LAMapRectIsEmpty(LAMapRect rect){
    return BMKMapRectIsEmpty( rect);
}

NS_INLINE NSString *LAStringFromMapPoint(LAMapPoint point){
    return BMKStringFromMapPoint( point);
}

NS_INLINE NSString *LAStringFromMapSize(LAMapSize size){
    return BMKStringFromMapSize( size);
}

NS_INLINE NSString *LAStringFromMapRect(LAMapRect rect){
    return BMKStringFromMapRect( rect);
}
#endif

NS_INLINE LAMapRect LAMapRectUnion(LAMapRect rect1, LAMapRect rect2){
    return BMKMapRectUnion( rect1,  rect2);
};
NS_INLINE LAMapRect LAMapRectIntersection(LAMapRect rect1, LAMapRect rect2){
    return BMKMapRectIntersection( rect1,  rect2);
};
NS_INLINE LAMapRect LAMapRectInset(LAMapRect rect, double dx, double dy){
    return BMKMapRectInset( rect,  dx,  dy);
};
NS_INLINE LAMapRect LAMapRectOffset(LAMapRect rect, double dx, double dy){
    return BMKMapRectOffset( rect,  dx,  dy);
};
NS_INLINE void LAMapRectDivide(LAMapRect rect, LAMapRect *slice, LAMapRect *remainder, double amount, CGRectEdge edge){
    return BMKMapRectDivide( rect,  slice,  remainder,  amount,  edge);
};

NS_INLINE BOOL LAMapRectContainsPoint(LAMapRect rect, LAMapPoint point){
    return BMKMapRectContainsPoint( rect,  point);
};
NS_INLINE BOOL LAMapRectContainsRect(LAMapRect rect1, LAMapRect rect2){
    return BMKMapRectContainsRect( rect1,  rect2);
};
NS_INLINE BOOL LAMapRectIntersectsRect(LAMapRect rect1, LAMapRect rect2){
    return BMKMapRectIntersectsRect( rect1,  rect2);
};

NS_INLINE LACoordinateRegion LACoordinateRegionForMapRect(LAMapRect rect){
    return BMKCoordinateRegionForMapRect( rect);
};

NS_INLINE BOOL LAMapRectSpans180thMeridian(LAMapRect rect){
    return BMKMapRectSpans180thMeridian( rect);
};
// For map rects that span the 180th meridian, this returns the portion of the rect
// that lies outside of the world rect wrapped around to the other side of the
// world.  The portion of the rect that lies inside the world rect can be
// determined with LAMapRectIntersection(rect, LAMapRectWorld).
NS_INLINE LAMapRect LAMapRectRemainder(LAMapRect rect){
    return BMKMapRectRemainder( rect);
};


@interface BMKMapView(LAMap)<LAMapView>

//@interface BMKMapView (LAMap)

@end

@interface LATileOverlay : NSObject<LATileOverlay>

@end

@interface LATileOverlayView : LAOverlayView
-(instancetype)initWithTileOverlay:(LATileOverlay *)overlay;
@end

@interface BMKPolylineView (LAMap)
@property CGLineJoin lineJoin;
@property CGLineCap lineCap;
@end

@interface BMKUserLocation (LAMap)
@property (readonly, nonatomic) CLHeading *heading;

@end