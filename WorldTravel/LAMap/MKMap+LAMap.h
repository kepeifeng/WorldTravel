//
//  LAMapView+LAMapAdopt.h
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 1/13/15.
//  Copyright (c) 2015 Kent Peifeng Ke. All rights reserved.
//


#import "LAMapDefine.h"
#import <MapKit/MapKit.h>
#import "LAGeometry.h"


#define LAMapSizeWorld MKMapSizeWorld
// The rect that contains every map point in the world.
#define LAMapRectWorld MKMapRectWorld

NS_INLINE LACoordinateSpan LACoordinateSpanMake(CLLocationDegrees latitudeDelta, CLLocationDegrees longitudeDelta)
{
    return MKCoordinateSpanMake(latitudeDelta, longitudeDelta);
}

NS_INLINE LACoordinateRegion MKCoordinateRegionMake(CLLocationCoordinate2D centerCoordinate, LACoordinateSpan span)
{
    return MKCoordinateRegionMake(centerCoordinate, span);
}

NS_INLINE LACoordinateRegion LACoordinateRegionMakeWithDistance(CLLocationCoordinate2D centerCoordinate, CLLocationDistance latitudinalMeters, CLLocationDistance longitudinalMeters){
    return MKCoordinateRegionMakeWithDistance(centerCoordinate, latitudinalMeters, longitudinalMeters);
}

NS_INLINE CLLocationCoordinate2D LAMapCoordinateToGpsCoordinate(CLLocationCoordinate2D coordinate){
    return MKCoordinateForMapPoint(mapPoint);
};

NS_INLINE CLLocationCoordinate2D LAGpsCoordinateToMapCoordinate(CLLocationCoordinate2D coordinate){
    return MKCoordinateForMapPoint(mapPoint);
};

// Conversion between unprojected and projected coordinates
NS_INLINE LAMapPoint LAMapPointForCoordinate(CLLocationCoordinate2D coordinate){
    return MKMapPointForCoordinate(coordinate);
};


NS_INLINE CLLocationCoordinate2D LACoordinateForMapPoint(LAMapPoint mapPoint){
    return MKCoordinateForMapPoint(mapPoint);
};

// Conversion between distances and projected coordinates
NS_INLINE CLLocationDistance LAMetersPerMapPointAtLatitude(CLLocationDegrees latitude){
    return MKMetersPerMapPointAtLatitude(latitude);
};
NS_INLINE double LAMapPointsPerMeterAtLatitude(CLLocationDegrees latitude){
    return MKMapPointsPerMeterAtLatitude(latitude);
};

NS_INLINE CLLocationDistance LAMetersBetweenMapPoints(LAMapPoint a, LAMapPoint b){
    return MKMetersBetweenMapPoints(a, b);
};

#define LAMapRectNull MKMapRectNull

#if (__IPHONE_4_0 <= __IPHONE_OS_VERSION_MAX_ALLOWED || __MAC_10_9 <= __MAC_OS_X_VERSION_MAX_ALLOWED)

// Geometric operations on LAMapPoint/Size/Rect.  See CGGeometry.h for
// information on the CGFloat versions of these functions.
NS_INLINE LAMapPoint LAMapPointMake(double x, double y) {
    return MKMapPointMake(x,y);
}
NS_INLINE LAMapSize LAMapSizeMake(double width, double height){
    return MKMapSizeMake(width, height);
}
NS_INLINE LAMapRect LAMapRectMake(double x, double y, double width, double height){
    return MKMapRectMake( x,  y,  width,  height);
}
NS_INLINE double LAMapRectGetMinX(LAMapRect rect){
    return MKMapRectGetMinX(rect);
}
NS_INLINE double LAMapRectGetMinY(LAMapRect rect){
    return MKMapRectGetMinY( rect);
}
NS_INLINE double LAMapRectGetMidX(LAMapRect rect){
    return MKMapRectGetMidX( rect);
}
NS_INLINE double LAMapRectGetMidY(LAMapRect rect){
    return MKMapRectGetMidY( rect);
}
NS_INLINE double LAMapRectGetMaxX(LAMapRect rect){
    return MKMapRectGetMaxX( rect);
}
NS_INLINE double LAMapRectGetMaxY(LAMapRect rect){
    return MKMapRectGetMaxY( rect);
}
NS_INLINE double LAMapRectGetWidth(LAMapRect rect){
    return MKMapRectGetWidth( rect);
}
NS_INLINE double LAMapRectGetHeight(LAMapRect rect){
    return MKMapRectGetHeight( rect);
}
NS_INLINE BOOL LAMapPointEqualToPoint(LAMapPoint point1, LAMapPoint point2){
    return MKMapPointEqualToPoint( point1,  point2);
}
NS_INLINE BOOL LAMapSizeEqualToSize(LAMapSize size1, LAMapSize size2){
    return MKMapSizeEqualToSize( size1,  size2);
}
NS_INLINE BOOL LAMapRectEqualToRect(LAMapRect rect1, LAMapRect rect2){
    return MKMapRectEqualToRect( rect1,  rect2);
}

NS_INLINE BOOL LAMapRectIsNull(LAMapRect rect){
    return MKMapRectIsNull( rect);
}

NS_INLINE BOOL LAMapRectIsEmpty(LAMapRect rect){
    return MKMapRectIsEmpty( rect);
}

NS_INLINE NSString *LAStringFromMapPoint(LAMapPoint point){
    return MKStringFromMapPoint( point);
}

NS_INLINE NSString *LAStringFromMapSize(LAMapSize size){
    return MKStringFromMapSize( size);
}

NS_INLINE NSString *LAStringFromMapRect(LAMapRect rect){
    return MKStringFromMapRect( rect);
}
#endif

NS_INLINE LAMapRect LAMapRectUnion(LAMapRect rect1, LAMapRect rect2){
    return MKMapRectUnion( rect1,  rect2);
};
NS_INLINE LAMapRect LAMapRectIntersection(LAMapRect rect1, LAMapRect rect2){
    return MKMapRectIntersection( rect1,  rect2);
};
NS_INLINE LAMapRect LAMapRectInset(LAMapRect rect, double dx, double dy){
    return MKMapRectInset( rect,  dx,  dy);
};
NS_INLINE LAMapRect LAMapRectOffset(LAMapRect rect, double dx, double dy){
    return MKMapRectOffset( rect,  dx,  dy);
};
NS_INLINE void LAMapRectDivide(LAMapRect rect, LAMapRect *slice, LAMapRect *remainder, double amount, CGRectEdge edge){
    return MKMapRectDivide( rect,  slice,  remainder,  amount,  edge);
};

NS_INLINE BOOL LAMapRectContainsPoint(LAMapRect rect, LAMapPoint point){
    return MKMapRectContainsPoint( rect,  point);
};
NS_INLINE BOOL LAMapRectContainsRect(LAMapRect rect1, LAMapRect rect2){
    return MKMapRectContainsRect( rect1,  rect2);
};
NS_INLINE BOOL LAMapRectIntersectsRect(LAMapRect rect1, LAMapRect rect2){
    return MKMapRectIntersectsRect( rect1,  rect2);
};

NS_INLINE LACoordinateRegion LACoordinateRegionForMapRect(LAMapRect rect){
    return MKCoordinateRegionForMapRect( rect);
};

NS_INLINE BOOL LAMapRectSpans180thMeridian(LAMapRect rect){
    return MKMapRectSpans180thMeridian( rect);
};
// For map rects that span the 180th meridian, this returns the portion of the rect
// that lies outside of the world rect wrapped around to the other side of the
// world.  The portion of the rect that lies inside the world rect can be
// determined with LAMapRectIntersection(rect, LAMapRectWorld).
NS_INLINE LAMapRect LAMapRectRemainder(LAMapRect rect){
    return MKMapRectRemainder( rect);
};


@interface MKMapView(LAMap)<LAMapView>

//@interface MKMapView (LAMap)

@end

@interface LATileOverlayView : LAOverlayView

-(instancetype)initWithTileOverlay:(LATileOverlay *)overlay;
@end

