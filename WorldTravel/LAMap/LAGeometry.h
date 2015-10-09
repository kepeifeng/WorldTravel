//
//  LAGeometry.h
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 1/14/15.
//  Copyright (c) 2015 Kent Peifeng Ke. All rights reserved.
//

#ifndef WorldTravel_LAGeometry_h
#define WorldTravel_LAGeometry_h
#import "LAConfigure.h"

#ifdef BAIDU_MAP
typedef BMKCoordinateSpan LACoordinateSpan;
typedef BMKCoordinateBounds LACoordinateBounds;
typedef BMKCoordinateRegion LACoordinateRegion;
typedef BMKGeoPoint LAGeoPoint;
typedef BMKMapPoint LAMapPoint;
typedef BMKMapSize LAMapSize;
typedef BMKMapRect LAMapRect;
typedef BMKZoomScale LAZoomScale;
#elif defined(APPLE_MAP)
typedef MKCoordinateSpan LACoordinateSpan;
//typedef MKCoordinateBounds LACoordinateBounds;
typedef MKCoordinateRegion LACoordinateRegion;
//typedef MKGeoPoint LAGeoPoint;
typedef MKMapPoint LAMapPoint;
typedef MKMapSize LAMapSize;
typedef MKMapRect LAMapRect;
typedef MKZoomScale LAZoomScale;
#elif defined(GAODE_MAP)
typedef MACoordinateSpan LACoordinateSpan;
typedef MACoordinateBounds LACoordinateBounds;
typedef MACoordinateRegion LACoordinateRegion;
//typedef MAGeoPoint LAGeoPoint;
typedef MAMapPoint LAMapPoint;
typedef MAMapSize LAMapSize;
typedef MAMapRect LAMapRect;
//typedef MAZoomScale LAZoomScale;
#endif


#endif
