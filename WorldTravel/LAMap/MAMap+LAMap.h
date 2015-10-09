//
//  LAMapView+LAMapAdopt.h
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 1/13/15.
//  Copyright (c) 2015 Kent Peifeng Ke. All rights reserved.
//


#import "LAMapDefine.h"
#import <MAMapKit/MAMapKit.h>
#import "LAGeometry.h"


#define LAMapSizeWorld MAMapSizeWorld
// The rect that contains every map point in the world.
#define LAMapRectWorld MAMapRectWorld

//NS_INLINE CLLocationCoordinate2D LAMapCoordinateToGpsCoordinate(CLLocationCoordinate2D coordinate){
////    return MACoordinateForMapPoint(mapPoint);
//};
//
//NS_INLINE CLLocationCoordinate2D LAGpsCoordinateToMapCoordinate(CLLocationCoordinate2D coordinate){
////    return MACoordinateForMapPoint(mapPoint);
//};

NS_INLINE LACoordinateSpan LACoordinateSpanMake(CLLocationDegrees latitudeDelta, CLLocationDegrees longitudeDelta)
{
    return MACoordinateSpanMake(latitudeDelta, longitudeDelta);
}

NS_INLINE LACoordinateRegion LACoordinateRegionMake(CLLocationCoordinate2D centerCoordinate, LACoordinateSpan span)
{
    return MACoordinateRegionMake(centerCoordinate, span);
}

NS_INLINE LACoordinateRegion LACoordinateRegionMakeWithDistance(CLLocationCoordinate2D centerCoordinate, CLLocationDistance latitudinalMeters, CLLocationDistance longitudinalMeters){
    return MACoordinateRegionMakeWithDistance(centerCoordinate, latitudinalMeters, longitudinalMeters);
}


// Conversion between unprojected and projected coordinates
NS_INLINE LAMapPoint LAMapPointForCoordinate(CLLocationCoordinate2D coordinate){
    return MAMapPointForCoordinate(coordinate);
};


NS_INLINE CLLocationCoordinate2D LACoordinateForMapPoint(LAMapPoint mapPoint){
    return MACoordinateForMapPoint(mapPoint);
};

// Conversion between distances and projected coordinates
NS_INLINE CLLocationDistance LAMetersPerMapPointAtLatitude(CLLocationDegrees latitude){
    return MAMetersPerMapPointAtLatitude(latitude);
};
NS_INLINE double LAMapPointsPerMeterAtLatitude(CLLocationDegrees latitude){
    return MAMapPointsPerMeterAtLatitude(latitude);
};

NS_INLINE CLLocationDistance LAMetersBetweenMapPoints(LAMapPoint a, LAMapPoint b){
    return MAMetersBetweenMapPoints(a, b);
};

#define LAMapRectNull MAMapRectNull

#if (__IPHONE_4_0 <= __IPHONE_OS_VERSION_MAX_ALLOWED || __MAC_10_9 <= __MAC_OS_X_VERSION_MAX_ALLOWED)

// Geometric operations on LAMapPoint/Size/Rect.  See CGGeometry.h for
// information on the CGFloat versions of these functions.
NS_INLINE LAMapPoint LAMapPointMake(double x, double y) {
    return MAMapPointMake(x,y);
}
NS_INLINE LAMapSize LAMapSizeMake(double width, double height){
    return MAMapSizeMake(width, height);
}
NS_INLINE LAMapRect LAMapRectMake(double x, double y, double width, double height){
    return MAMapRectMake( x,  y,  width,  height);
}
NS_INLINE double LAMapRectGetMinX(LAMapRect rect){
    return MAMapRectGetMinX(rect);
}
NS_INLINE double LAMapRectGetMinY(LAMapRect rect){
    return MAMapRectGetMinY( rect);
}
NS_INLINE double LAMapRectGetMidX(LAMapRect rect){
    return MAMapRectGetMidX( rect);
}
NS_INLINE double LAMapRectGetMidY(LAMapRect rect){
    return MAMapRectGetMidY( rect);
}
NS_INLINE double LAMapRectGetMaxX(LAMapRect rect){
    return MAMapRectGetMaxX( rect);
}
NS_INLINE double LAMapRectGetMaxY(LAMapRect rect){
    return MAMapRectGetMaxY( rect);
}
NS_INLINE double LAMapRectGetWidth(LAMapRect rect){
    return MAMapRectGetWidth( rect);
}
NS_INLINE double LAMapRectGetHeight(LAMapRect rect){
    return MAMapRectGetHeight( rect);
}
NS_INLINE BOOL LAMapPointEqualToPoint(LAMapPoint point1, LAMapPoint point2){
    return point1.x == point2.x && point1.y == point2.y;
}
NS_INLINE BOOL LAMapSizeEqualToSize(LAMapSize size1, LAMapSize size2){
    return size1.width == size2.width && size1.height == size2.height;
}
NS_INLINE BOOL LAMapRectEqualToRect(LAMapRect rect1, LAMapRect rect2){
    return
    LAMapPointEqualToPoint(rect1.origin, rect2.origin) &&
    LAMapSizeEqualToSize(rect1.size, rect2.size);

}

NS_INLINE BOOL LAMapRectIsNull(LAMapRect rect){
    return MAMapRectIsNull( rect);
}

NS_INLINE BOOL LAMapRectIsEmpty(LAMapRect rect){
    return MAMapRectIsEmpty( rect);
}

NS_INLINE NSString *LAStringFromMapPoint(LAMapPoint point){
    return [NSString stringWithFormat:@"{%.1f, %.1f}", point.x, point.y];
}

NS_INLINE NSString *LAStringFromMapSize(LAMapSize size){
    return [NSString stringWithFormat:@"{%.1f, %.1f}", size.width, size.height];

}

NS_INLINE NSString *LAStringFromMapRect(LAMapRect rect){
return [NSString stringWithFormat:@"{%@, %@}", LAStringFromMapPoint(rect.origin), LAStringFromMapSize(rect.size)];
}
#endif

NS_INLINE LAMapRect LAMapRectUnion(LAMapRect rect1, LAMapRect rect2){
    return MAMapRectUnion( rect1,  rect2);
};
//NS_INLINE LAMapRect LAMapRectIntersection(LAMapRect rect1, LAMapRect rect2){
//    return MAMapRectIntersection( rect1,  rect2);
//};
//NS_INLINE LAMapRect LAMapRectInset(LAMapRect rect, double dx, double dy){
//    return MAMapRectInset( rect,  dx,  dy);
//};
//NS_INLINE LAMapRect LAMapRectOffset(LAMapRect rect, double dx, double dy){
//    return MAMapRectOffset( rect,  dx,  dy);
//};
//NS_INLINE void LAMapRectDivide(LAMapRect rect, LAMapRect *slice, LAMapRect *remainder, double amount, CGRectEdge edge){
//    return MAMapRectDivide( rect,  slice,  remainder,  amount,  edge);
//};

NS_INLINE BOOL LAMapRectContainsPoint(LAMapRect rect, LAMapPoint point){
    return MAMapRectContainsPoint( rect,  point);
};
NS_INLINE BOOL LAMapRectContainsRect(LAMapRect rect1, LAMapRect rect2){
    return MAMapRectContainsRect( rect1,  rect2);
};
NS_INLINE BOOL LAMapRectIntersectsRect(LAMapRect rect1, LAMapRect rect2){
    return MAMapRectIntersectsRect( rect1,  rect2);
};

NS_INLINE LACoordinateRegion LACoordinateRegionForMapRect(LAMapRect rect){
    return MACoordinateRegionForMapRect( rect);
};

//NS_INLINE BOOL LAMapRectSpans180thMeridian(LAMapRect rect){
//    return MAMapRectSpans180thMeridian( rect);
//};
//// For map rects that span the 180th meridian, this returns the portion of the rect
//// that lies outside of the world rect wrapped around to the other side of the
//// world.  The portion of the rect that lies inside the world rect can be
//// determined with LAMapRectIntersection(rect, LAMapRectWorld).
//NS_INLINE LAMapRect LAMapRectRemainder(LAMapRect rect){
//    return MAMapRectRemainder( rect);
//};



@interface MAMapView(LAMap)<LAMapViewProtocol>

//@interface MAMapView (LAMap)

@end

#define LATileOverlayView MATileOverlayView
//@interface LATileOverlayView : LAOverlayView
//
//-(instancetype)initWithTileOverlay:(LATileOverlay *)overlay;
//@end

@interface MAOverlayPathView (LAMap)
@property CGLineJoin lineJoin;
/// LineCap，默认为kCGLineCapRound
@property CGLineCap lineCap;
@end

@interface LAAnnotationView (LAMap)<LAAnnotationViewProtocol>

@end
