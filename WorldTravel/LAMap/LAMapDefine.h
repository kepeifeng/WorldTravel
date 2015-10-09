//
//  LAMapDefine.h
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 1/13/15.
//  Copyright (c) 2015 Kent Peifeng Ke. All rights reserved.
//

#ifndef WorldTravel_LAMapDefine_h
#define WorldTravel_LAMapDefine_h



#import "LAConfigure.h"
#import "LAGeometry.h"
#import "LAAnnotation.h"



//typedef struct {
//    CLLocationCoordinate2D center;
////    MKCoordinateSpan span;
//} LACoordinateRegion;


typedef NS_ENUM(NSUInteger, LAMapType) {
    LAMapTypeStandardStreet,
    LAMapTypeStandardSatellite,
    LAMapTypeNightStreet,
    LAMapTypeOpenStreetMap,
    LAMapTypeOpenCycleMap,
    LAMapTypeGoogleStreet,
    LAMapTypeGoogleSatellite,
    
};

typedef NS_ENUM(NSUInteger, LAAnnotationViewDragState) {
    LAAnnotationViewDragStateNone = 0,      // View is at rest, sitting on the map.
    LAAnnotationViewDragStateStarting,      // View is beginning to drag (e.g. pin lift)
    LAAnnotationViewDragStateDragging,      // View is dragging ("lift" animations are complete)
    LAAnnotationViewDragStateCanceling,     // View was not dragged and should return to its starting position (e.g. pin drop)
    LAAnnotationViewDragStateEnding         // View was dragged, new coordinate is set and view should return to resting position (e.g. pin drop)
} NS_ENUM_AVAILABLE(10_9, 4_0);

typedef NS_ENUM(NSInteger, LAUserTrackingMode) {
    LAUserTrackingModeNone = 0, // the user's location is not followed
    LAUserTrackingModeFollow, // the map follows the user's location
    LAUserTrackingModeFollowWithHeading, // the map follows the user's location and heading
} NS_ENUM_AVAILABLE(NA, 5_0);

@interface LAMap : NSObject

@end



//#ifdef BAIDU_MAP
//#elif defined(APPLE_MAP)
//#endif


//#ifdef BAIDU_MAP
//typedef BMKCoordinateRegion LACoordinateRegion ;
//typedef BMKMapRect LAMapRect;
//typedef BMKMapPoint LAMapPoint;
//#elif defined(APPLE_MAP)
//typedef MKCoordinateRegion LACoordinateRegion;
//typedef MKMapRect LAMapRect;
//typedef MKMapPoint LAMapPoint;
//#endif




@class LAMapView;




#ifdef BAIDU_MAP

#elif defined(APPLE_MAP)

#endif





//@protocol LAMapView;




//@protocol LAAnnotationView <NSObject>
//
//- (instancetype)initWithAnnotation:(id <LAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier;
//
//@property (nonatomic, readonly) NSString *reuseIdentifier;
//
//// Classes that override must call super.
//- (void)prepareForReuse;
//
//@property (nonatomic, strong) id <LAAnnotation> annotation;
//
//#if TARGET_OS_IPHONE
//@property (nonatomic, strong) UIImage *image;
//#else
//@property (nonatomic, strong) NSImage *image;
//#endif
//
//// By default, the center of annotation view is placed over the coordinate of the annotation.
//// centerOffset is the offset in screen points from the center of the annotion view.
//@property (nonatomic) CGPoint centerOffset;
//
//// calloutOffset is the offset in screen points from the top-middle of the annotation view, where the anchor of the callout should be shown.
//@property (nonatomic) CGPoint calloutOffset;
//
//#if !TARGET_OS_IPHONE
//// leftCalloutOffset is the offset in screen points from the middle-left of the annotation view, where the anchor of the callout should be shown when oriented off the left side of the annotation view
//@property (nonatomic) CGPoint leftCalloutOffset;
//
//// rightCalloutOffset is the offset in screen points from the middle-right of the annotation view, where the anchor of the callout should be shown when oriented off the right side of the annotation view
//@property (nonatomic) CGPoint rightCalloutOffset;
//#endif
//
//// Defaults to YES. If NO, ignores touch events and subclasses may draw differently.
//@property (nonatomic, getter=isEnabled) BOOL enabled;
//
//// Defaults to NO. This gets set/cleared automatically when touch enters/exits during tracking and cleared on up.
//@property (nonatomic, getter=isHighlighted) BOOL highlighted;
//
//// Defaults to NO. Becomes YES when tapped/clicked on in the map view.
//@property (nonatomic, getter=isSelected) BOOL selected;
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated;
//
//// If YES, a standard callout bubble will be shown when the annotation is selected.
//// The annotation must have a title for the callout to be shown.
//@property (nonatomic) BOOL canShowCallout;
//
//// The left accessory view to be used in the standard callout.
//#if TARGET_OS_IPHONE
//@property (strong, nonatomic) UIView *leftCalloutAccessoryView;
//#else
//@property (strong, nonatomic) NSView *leftCalloutAccessoryView;
//#endif
//
//// The right accessory view to be used in the standard callout.
//#if TARGET_OS_IPHONE
//@property (strong, nonatomic) UIView *rightCalloutAccessoryView;
//#else
//@property (strong, nonatomic) NSView *rightCalloutAccessoryView;
//#endif
//
//// If YES and the underlying id<MKAnnotation> responds to setCoordinate:,
//// the user will be able to drag this annotation view around the map.
//@property (nonatomic, getter=isDraggable) BOOL draggable NS_AVAILABLE(10_9, 4_0);
//
//// Automatically set to LAAnnotationViewDragStateStarting, Canceling, and Ending when necessary.
//// Implementer is responsible for transitioning to Dragging and None states as appropriate.
//@property (nonatomic) LAAnnotationViewDragState dragState NS_AVAILABLE(10_9, 4_0);
//
//// Developers targeting iOS 4.2 and after must use setDragState:animated: instead of setDragState:.
//- (void)setDragState:(LAAnnotationViewDragState)newDragState animated:(BOOL)animated NS_AVAILABLE(10_9, 4_2);
//
//
//
//@end

#pragma mark - LAMapViewDelegate

#ifdef BAIDU_MAP
@protocol LAMapViewDelegate <NSObject, BMKMapViewDelegate>
#elif defined(APPLE_MAP)
//typedef MKMapView LAMapView;
@protocol LAMapViewDelegate <NSObject, MKMapViewDelegate>
#elif defined(GAODE_MAP)
@protocol LAMapViewDelegate <NSObject, MAMapViewDelegate>

#endif


@optional

- (void)mapView:(LAMapView *)mapView regionWillChangeAnimated:(BOOL)animated;
- (void)mapView:(LAMapView *)mapView regionDidChangeAnimated:(BOOL)animated;

- (void)mapViewWillStartLoadingMap:(LAMapView *)mapView;
- (void)mapViewDidFinishLoadingMap:(LAMapView *)mapView;
- (void)mapViewDidFailLoadingMap:(LAMapView *)mapView withError:(NSError *)error;

- (void)mapViewWillStartRenderingMap:(LAMapView *)mapView NS_AVAILABLE(10_9, 7_0);
- (void)mapViewDidFinishRenderingMap:(LAMapView *)mapView fullyRendered:(BOOL)fullyRendered NS_AVAILABLE(10_9, 7_0);

// mapView:viewForAnnotation: provides the view for each annotation.
// This method may be called for all or some of the added annotations.
// For MapKit provided annotations (eg. MKUserLocation) return nil to use the MapKit provided annotation view.
- (LAAnnotationView *)mapView:(LAMapView *)mapView viewForAnnotation:(id <LAAnnotation>)annotation;

// mapView:didAddAnnotationViews: is called after the annotation views have been added and positioned in the map.
// The delegate can implement this method to animate the adding of the annotations views.
// Use the current positions of the annotation views as the destinations of the animation.
- (void)mapView:(LAMapView *)mapView didAddAnnotationViews:(NSArray *)views;

#if TARGET_OS_IPHONE
// mapView:annotationView:calloutAccessoryControlTapped: is called when the user taps on left & right callout accessory UIControls.
- (void)mapView:(LAMapView *)mapView annotationView:(LAAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control;
#endif

- (void)mapView:(LAMapView *)mapView didSelectAnnotationView:(LAAnnotationView *)view NS_AVAILABLE(10_9, 4_0);
- (void)mapView:(LAMapView *)mapView didDeselectAnnotationView:(LAAnnotationView *)view NS_AVAILABLE(10_9, 4_0);

- (void)mapViewWillStartLocatingUser:(LAMapView *)mapView NS_AVAILABLE(10_9, 4_0);
- (void)mapViewDidStopLocatingUser:(LAMapView *)mapView NS_AVAILABLE(10_9, 4_0);
- (void)mapView:(LAMapView *)mapView didUpdateUserLocation:(LAUserLocation *)userLocation NS_AVAILABLE(10_9, 4_0);
- (void)mapView:(LAMapView *)mapView didFailToLocateUserWithError:(NSError *)error NS_AVAILABLE(10_9, 4_0);

- (void)mapView:(LAMapView *)mapView annotationView:(LAAnnotationView *)view didChangeDragState:(LAAnnotationViewDragState)newState
   fromOldState:(LAAnnotationViewDragState)oldState NS_AVAILABLE(10_9, 4_0);

#if TARGET_OS_IPHONE
- (void)mapView:(LAMapView *)mapView didChangeUserTrackingMode:(LAUserTrackingMode)mode animated:(BOOL)animated NS_AVAILABLE(NA, 5_0);
#endif

//- (LAOverlayRenderer *)mapView:(LAMapView *)mapView rendererForOverlay:(id <LAOverlay>)overlay NS_AVAILABLE(10_9, 7_0);
- (void)mapView:(LAMapView *)mapView didAddOverlayRenderers:(NSArray *)renderers NS_AVAILABLE(10_9, 7_0);

#if TARGET_OS_IPHONE
// Prefer -mapView:rendererForOverlay:
- (LAOverlayView *)mapView:(LAMapView *)mapView viewForOverlay:(id <LAOverlay>)overlay NS_DEPRECATED_IOS(4_0, 7_0);
// Called after the provided overlay views have been added and positioned in the map.
// Prefer -mapView:didAddOverlayRenderers:
- (void)mapView:(LAMapView *)mapView didAddOverlayViews:(NSArray *)overlayViews NS_DEPRECATED_IOS(4_0, 7_0);
#endif

@end

#pragma mark - LAMapView



/*@protocol LAMapView <NSObject>


@property (nonatomic, retain) id<LAMapViewDelegate> delegate;

//TODO: FIX MAPTYPE
//@property (nonatomic) MKMapType mapType;

// Region is the coordinate and span of the map.
// Region may be modified to fit the aspect ratio of the view using regionThatFits:.
@property (nonatomic) LACoordinateRegion region;
- (void)setRegion:(LACoordinateRegion)region animated:(BOOL)animated;

// centerCoordinate allows the coordinate of the region to be changed without changing the zoom level.
@property (nonatomic) CLLocationCoordinate2D centerCoordinate;
- (void)setCenterCoordinate:(CLLocationCoordinate2D)coordinate animated:(BOOL)animated;

// Returns a region of the aspect ratio of the map view that contains the given region, with the same center point.
- (LACoordinateRegion)regionThatFits:(LACoordinateRegion)region;

// Access the visible region of the map in projected coordinates.
@property (nonatomic) LAMapRect visibleMapRect;
- (void)setVisibleMapRect:(LAMapRect)mapRect animated:(BOOL)animate;

// Returns an LAMapRect modified to fit the aspect ratio of the map.
- (LAMapRect)mapRectThatFits:(LAMapRect)mapRect;

// Edge padding is the minumum padding on each side around the specified LAMapRect.
#if TARGET_OS_IPHONE
- (void)setVisibleMapRect:(LAMapRect)mapRect edgePadding:(UIEdgeInsets)insets animated:(BOOL)animate;
- (LAMapRect)mapRectThatFits:(LAMapRect)mapRect edgePadding:(UIEdgeInsets)insets;
#else
- (void)setVisibleMapRect:(LAMapRect)mapRect edgePadding:(NSEdgeInsets)insets animated:(BOOL)animate;
- (LAMapRect)mapRectThatFits:(LAMapRect)mapRect edgePadding:(NSEdgeInsets)insets;
#endif

//@property (nonatomic, copy) MKMapCamera *camera NS_AVAILABLE(10_9, 7_0);
//- (void)setCamera:(MKMapCamera *)camera animated:(BOOL)animated NS_AVAILABLE(10_9, 7_0);

#if TARGET_OS_IPHONE
- (CGPoint)convertCoordinate:(CLLocationCoordinate2D)coordinate toPointToView:(UIView *)view;
- (CLLocationCoordinate2D)convertPoint:(CGPoint)point toCoordinateFromView:(UIView *)view;
- (CGRect)convertRegion:(LACoordinateRegion)region toRectToView:(UIView *)view;
- (LACoordinateRegion)convertRect:(CGRect)rect toRegionFromView:(UIView *)view;
#else
- (CGPoint)convertCoordinate:(CLLocationCoordinate2D)coordinate toPointToView:(NSView *)view;
- (CLLocationCoordinate2D)convertPoint:(CGPoint)point toCoordinateFromView:(NSView *)view;
- (CGRect)convertRegion:(LACoordinateRegion)region toRectToView:(NSView *)view;
- (LACoordinateRegion)convertRect:(CGRect)rect toRegionFromView:(NSView *)view;
#endif

// Control the types of user interaction available
// Zoom and scroll are enabled by default.
@property (nonatomic, getter=isZoomEnabled) BOOL zoomEnabled;
@property (nonatomic, getter=isScrollEnabled) BOOL scrollEnabled;
// Rotate and pitch are enabled by default on Mac OS X and on iOS 7.0 and later.
@property (nonatomic, getter=isRotateEnabled) BOOL rotateEnabled NS_AVAILABLE(10_9, 7_0);
@property (nonatomic, getter=isPitchEnabled) BOOL pitchEnabled NS_AVAILABLE(10_9, 7_0);

#if !TARGET_OS_IPHONE
@property (nonatomic) BOOL showsCompass NS_AVAILABLE(10_9, NA);
@property (nonatomic) BOOL showsZoomControls NS_AVAILABLE(10_9, NA);
@property (nonatomic) BOOL showsScale NS_AVAILABLE(10_10, NA);
#endif

@property (nonatomic) BOOL showsPointsOfInterest NS_AVAILABLE(10_9, 7_0); // Affects MKMapTypeStandard and MKMapTypeHybrid
@property (nonatomic) BOOL showsBuildings NS_AVAILABLE(10_9, 7_0); // Affects MKMapTypeStandard

// Set to YES to add the user location annotation to the map and start updating its location
@property (nonatomic) BOOL showsUserLocation;

// The annotation representing the user's location
@property (nonatomic, readonly) LAUserLocation *userLocation;

#if TARGET_OS_IPHONE
@property (nonatomic) LAUserTrackingMode userTrackingMode NS_AVAILABLE(NA, 5_0);
- (void)setUserTrackingMode:(LAUserTrackingMode)mode animated:(BOOL)animated NS_AVAILABLE(NA, 5_0);
#endif

// Returns YES if the user's location is displayed within the currently visible map region.
@property (nonatomic, readonly, getter=isUserLocationVisible) BOOL userLocationVisible;


- (void)addAnnotation:(id <LAAnnotation>)annotation;
- (void)addAnnotations:(NSArray *)annotations;

- (void)removeAnnotation:(id <LAAnnotation>)annotation;
- (void)removeAnnotations:(NSArray *)annotations;

@property (nonatomic, readonly) NSArray *annotations;
- (NSSet *)annotationsInMapRect:(LAMapRect)mapRect NS_AVAILABLE(10_9, 4_2);

// Currently displayed view for an annotation; returns nil if the view for the annotation isn't being displayed.
- (LAAnnotationView *)viewForAnnotation:(id <LAAnnotation>)annotation;

// Used by the delegate to acquire an already allocated annotation view, in lieu of allocating a new one.
- (LAAnnotationView *)dequeueReusableAnnotationViewWithIdentifier:(NSString *)identifier;

// Select or deselect a given annotation.  Asks the delegate for the corresponding annotation view if necessary.
- (void)selectAnnotation:(id <LAAnnotation>)annotation animated:(BOOL)animated;
- (void)deselectAnnotation:(id <LAAnnotation>)annotation animated:(BOOL)animated;
@property (nonatomic, copy) NSArray *selectedAnnotations;

// annotationVisibleRect is the visible rect where the annotations views are currently displayed.
// The delegate can use annotationVisibleRect when animating the adding of the annotations views in mapView:didAddAnnotationViews:
@property (nonatomic, readonly) CGRect annotationVisibleRect;

// Position the map such that the provided array of annotations are all visible to the fullest extent possible.
- (void)showAnnotations:(NSArray *)annotations animated:(BOOL)animated NS_AVAILABLE(10_9, 7_0);


@end*/

@protocol LAMapViewProtocol <NSObject>

@property (nonatomic) LAMapType mapType;
/**
 *  Delegate
 */
@property (nonatomic, weak) id<LAMapViewDelegate> delegate;

//TODO: FIX MAPTYPE
//@property (nonatomic) MKMapType mapType;

// Region is the coordinate and span of the map.
// Region may be modified to fit the aspect ratio of the view using regionThatFits:.
@property (nonatomic) LACoordinateRegion region;
- (void)setRegion:(LACoordinateRegion)region animated:(BOOL)animated;

// centerCoordinate allows the coordinate of the region to be changed without changing the zoom level.
@property (nonatomic) CLLocationCoordinate2D centerCoordinate;
- (void)setCenterCoordinate:(CLLocationCoordinate2D)coordinate animated:(BOOL)animated;

// Returns a region of the aspect ratio of the map view that contains the given region, with the same center point.
- (LACoordinateRegion)regionThatFits:(LACoordinateRegion)region;

// Access the visible region of the map in projected coordinates.
@property (nonatomic) LAMapRect visibleMapRect;
- (void)setVisibleMapRect:(LAMapRect)mapRect animated:(BOOL)animate;

// Returns an LAMapRect modified to fit the aspect ratio of the map.
- (LAMapRect)mapRectThatFits:(LAMapRect)mapRect;

// Edge padding is the minumum padding on each side around the specified LAMapRect.
#if TARGET_OS_IPHONE
- (void)setVisibleMapRect:(LAMapRect)mapRect edgePadding:(UIEdgeInsets)insets animated:(BOOL)animate;
- (LAMapRect)mapRectThatFits:(LAMapRect)mapRect edgePadding:(UIEdgeInsets)insets;
#else
- (void)setVisibleMapRect:(LAMapRect)mapRect edgePadding:(NSEdgeInsets)insets animated:(BOOL)animate;
- (LAMapRect)mapRectThatFits:(LAMapRect)mapRect edgePadding:(NSEdgeInsets)insets;
#endif

//@property (nonatomic, copy) MKMapCamera *camera NS_AVAILABLE(10_9, 7_0);
//- (void)setCamera:(MKMapCamera *)camera animated:(BOOL)animated NS_AVAILABLE(10_9, 7_0);

#if TARGET_OS_IPHONE
- (CGPoint)convertCoordinate:(CLLocationCoordinate2D)coordinate toPointToView:(UIView *)view;
- (CLLocationCoordinate2D)convertPoint:(CGPoint)point toCoordinateFromView:(UIView *)view;
- (CGRect)convertRegion:(LACoordinateRegion)region toRectToView:(UIView *)view;
- (LACoordinateRegion)convertRect:(CGRect)rect toRegionFromView:(UIView *)view;
#else
- (CGPoint)convertCoordinate:(CLLocationCoordinate2D)coordinate toPointToView:(NSView *)view;
- (CLLocationCoordinate2D)convertPoint:(CGPoint)point toCoordinateFromView:(NSView *)view;
- (CGRect)convertRegion:(LACoordinateRegion)region toRectToView:(NSView *)view;
- (LACoordinateRegion)convertRect:(CGRect)rect toRegionFromView:(NSView *)view;
#endif

// Control the types of user interaction available
// Zoom and scroll are enabled by default.
@property (nonatomic, getter=isZoomEnabled) BOOL zoomEnabled;
@property (nonatomic, getter=isScrollEnabled) BOOL scrollEnabled;
// Rotate and pitch are enabled by default on Mac OS X and on iOS 7.0 and later.
@property (nonatomic, getter=isRotateEnabled) BOOL rotateEnabled NS_AVAILABLE(10_9, 7_0);
@property (nonatomic, getter=isPitchEnabled) BOOL pitchEnabled NS_AVAILABLE(10_9, 7_0);

#if !TARGET_OS_IPHONE
@property (nonatomic) BOOL showsCompass NS_AVAILABLE(10_9, NA);
@property (nonatomic) BOOL showsZoomControls NS_AVAILABLE(10_9, NA);
@property (nonatomic) BOOL showsScale NS_AVAILABLE(10_10, NA);
#endif

@property (nonatomic) BOOL showsPointsOfInterest NS_AVAILABLE(10_9, 7_0); // Affects MKMapTypeStandard and MKMapTypeHybrid
@property (nonatomic) BOOL showsBuildings NS_AVAILABLE(10_9, 7_0); // Affects MKMapTypeStandard

// Set to YES to add the user location annotation to the map and start updating its location
@property (nonatomic) BOOL showsUserLocation;

// The annotation representing the user's location
@property (nonatomic, readonly) LAUserLocation *userLocation;

#if TARGET_OS_IPHONE
@property (nonatomic) LAUserTrackingMode userTrackingMode NS_AVAILABLE(NA, 5_0);
- (void)setUserTrackingMode:(LAUserTrackingMode)mode animated:(BOOL)animated NS_AVAILABLE(NA, 5_0);
#endif

// Returns YES if the user's location is displayed within the currently visible map region.
@property (nonatomic, readonly, getter=isUserLocationVisible) BOOL userLocationVisible;


- (void)addAnnotation:(id <LAAnnotation>)annotation;
- (void)addAnnotations:(NSArray *)annotations;

- (void)removeAnnotation:(id <LAAnnotation>)annotation;
- (void)removeAnnotations:(NSArray *)annotations;

@property (nonatomic, readonly) NSArray *annotations;
- (NSSet *)annotationsInMapRect:(LAMapRect)mapRect NS_AVAILABLE(10_9, 4_2);

// Currently displayed view for an annotation; returns nil if the view for the annotation isn't being displayed.
- (LAAnnotationView *)viewForAnnotation:(id <LAAnnotation>)annotation;

// Used by the delegate to acquire an already allocated annotation view, in lieu of allocating a new one.
- (LAAnnotationView *)dequeueReusableAnnotationViewWithIdentifier:(NSString *)identifier;

// Select or deselect a given annotation.  Asks the delegate for the corresponding annotation view if necessary.
- (void)selectAnnotation:(id <LAAnnotation>)annotation animated:(BOOL)animated;
- (void)deselectAnnotation:(id <LAAnnotation>)annotation animated:(BOOL)animated;
@property (nonatomic, copy) NSArray *selectedAnnotations;

// annotationVisibleRect is the visible rect where the annotations views are currently displayed.
// The delegate can use annotationVisibleRect when animating the adding of the annotations views in mapView:didAddAnnotationViews:
@property (nonatomic, readonly) CGRect annotationVisibleRect;

// Position the map such that the provided array of annotations are all visible to the fullest extent possible.
- (void)showAnnotations:(NSArray *)annotations animated:(BOOL)animated NS_AVAILABLE(10_9, 7_0);

//=======================================================
/// 地图比例尺级别，在手机上当前可使用的级别为3-19级
@property (nonatomic) float zoomLevel;
/// 地图的自定义最小比例尺级别
@property (nonatomic) float minZoomLevel;
/// 地图的自定义最大比例尺级别
@property (nonatomic) float maxZoomLevel;

/// 地图旋转角度，在手机上当前可使用的范围为－180～180度
@property (nonatomic) int rotation;

/// 地图俯视角度，在手机上当前可使用的范围为－45～0度
@property (nonatomic) int overlooking;

-(void)setZoomLevel:(float)zoomLevel animated:(BOOL)animated;


- (void)removeOverlay:(id <LAOverlay>)overlay NS_AVAILABLE(10_9, 4_0);
- (void)removeOverlays:(NSArray *)overlays NS_AVAILABLE(10_9, 4_0);


- (void)insertOverlay:(id <LAOverlay>)overlay aboveOverlay:(id <LAOverlay>)sibling NS_AVAILABLE(10_9, 4_0);
- (void)insertOverlay:(id <LAOverlay>)overlay belowOverlay:(id <LAOverlay>)sibling NS_AVAILABLE(10_9, 4_0);

- (void)exchangeOverlay:(id <LAOverlay>)overlay1 withOverlay:(id <LAOverlay>)overlay2 NS_AVAILABLE(10_9, 7_0);

@property (nonatomic, readonly) NSArray *overlays NS_AVAILABLE(10_9, 4_0);


#if TARGET_OS_IPHONE
// Currently displayed view for overlay; returns nil if the view has not been created yet.
// Prefer using LAOverlayRenderer and -rendererForOverlay.
- (LAOverlayView *)viewForOverlay:(id <LAOverlay>)overlay NS_DEPRECATED_IOS(4_0, 7_0);
#endif

// These methods operate implicitly on overlays in LAOverlayLevelAboveLabels and may be deprecated in a future release in favor of the methods that specify the level.
- (void)addOverlay:(id <LAOverlay>)overlay NS_AVAILABLE(10_9, 4_0);
- (void)addOverlays:(NSArray *)overlays NS_AVAILABLE(10_9, 4_0);

- (void)insertOverlay:(id <LAOverlay>)overlay atIndex:(NSUInteger)index NS_AVAILABLE(10_9, 4_0);
- (void)exchangeOverlayAtIndex:(NSUInteger)index1 withOverlayAtIndex:(NSUInteger)index2 NS_AVAILABLE(10_9, 4_0);


@end





#endif
