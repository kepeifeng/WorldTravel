//
//  LAMapView.m
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 1/20/15.
//  Copyright (c) 2015 Kent Peifeng Ke. All rights reserved.
//

#import "LAMapView.h"

static MAMapView * _gSharedMap;

@interface LAMapView()

@property (nonatomic, readonly) BOOL isActivedSharedView;

@end


@implementation LAMapView{
    //    LabelStatus * _labelStatus;
    UIImage * _viewCapture;
    NSMutableArray * _annotations;
    NSMutableArray * _overlays;
    
}

@synthesize delegate = _delegate;
@synthesize centerCoordinate = _centerCoordinate;
@synthesize zoomLevel = _zoomLevel, minZoomLevel = _minZoomLevel, maxZoomLevel = _maxZoomLevel, rotation = _rotation, overlooking = _overlooking;
@synthesize region = _region, mapType = _mapType, visibleMapRect = _visibleMapRect, showsUserLocation = _showsUserLocation;
@synthesize zoomEnabled = _zoomEnabled, scrollEnabled = _scrollEnabled, rotateEnabled = _rotateEnabled;
-(BOOL)isActivedSharedView{
    if (_gSharedMap.superview == self) {
        return YES;
    }
    return NO;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialSetup];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = NO;
        [self initialSetup];
        
    }
    return self;
}

-(void)initialSetup{
    if (!_gSharedMap) {
        _gSharedMap = [[MAMapView alloc] init];
        _gSharedMap.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self fetchMapSetting];

        
    }
}

-(void)drawRect:(CGRect)rect{
    
    [super drawRect:rect];
    if (_viewCapture) {
        [_viewCapture drawInRect:rect];
    }
}

#pragma mark - Properties

-(void)setShowsUserLocation:(BOOL)showsUserLocation{
    _showsUserLocation = showsUserLocation;
    if (self.isActivedSharedView) {
        [_gSharedMap setShowsUserLocation:showsUserLocation];
    }
}

-(void)setVisibleMapRect:(LAMapRect)visibleMapRect{
    _visibleMapRect = visibleMapRect;
    if (self.isActivedSharedView) {
        [_gSharedMap setVisibleMapRect:visibleMapRect];
    }
}

-(void)setMapType:(LAMapType)mapType{
    _mapType = mapType;
    if (self.isActivedSharedView) {
        [_gSharedMap setMapType:mapType];
    }
}

-(void)setRegion:(LACoordinateRegion)region{
    _region = region;
    if (self.isActivedSharedView) {
        [_gSharedMap setRegion:region];
    }
}

-(void)setRegion:(LACoordinateRegion)region animated:(BOOL)animated{
    _region = region;
    if (self.isActivedSharedView) {
        [_gSharedMap setRegion:region animated:animated];
    }
}
-(void)setZoomLevel:(float)zoomLevel animated:(BOOL)animated{
    _zoomLevel = zoomLevel;
    if (self.isActivedSharedView) {
        [_gSharedMap setZoomLevel:zoomLevel animated:animated];
    }
}
-(void)setZoomLevel:(float)zoomLevel{
    _zoomLevel = zoomLevel;
    if (self.isActivedSharedView) {
        [_gSharedMap setZoomLevel:zoomLevel];
    }
}

-(void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate{

    _centerCoordinate = centerCoordinate;
    if (self.isActivedSharedView) {
        [_gSharedMap setCenterCoordinate:centerCoordinate];
    }
}


-(void)addAnnotation:(id<MAAnnotation>)annotation{
    if (!_annotations) {
        _annotations = [NSMutableArray new];
    }
    [_annotations addObject:annotation];
    if (self.isActivedSharedView) {
        [_gSharedMap addAnnotation:annotation];
    }
    
}

-(void)addAnnotations:(NSArray *)annotations{

    if (!_annotations) {
        _annotations = [NSMutableArray new];
    }
    [_annotations addObjectsFromArray:annotations];
    
    if (self.isActivedSharedView) {
        [_gSharedMap addAnnotations:annotations];
    }
}

-(void)addOverlay:(id<MAOverlay>)overlay{
    if (!_overlays) {
        _overlays = [NSMutableArray new];
    }
    [_overlays addObject:overlay];
    if (self.isActivedSharedView) {
        [_gSharedMap addOverlay:overlay];
    }
    
}

-(void)addOverlays:(NSArray *)overlays{
    if (!_overlays) {
        _overlays = [NSMutableArray new];
    }
    [_overlays addObjectsFromArray:overlays];
    if (self.isActivedSharedView) {
        [_gSharedMap addOverlays:overlays];
    }
}

-(void)viewDidAppear
{
    //pop status
    

    _gSharedMap.delegate = _delegate;
    
    [_gSharedMap removeAnnotations:_gSharedMap.annotations];
    [_gSharedMap addAnnotations:_annotations];
    [_gSharedMap removeOverlays: _gSharedMap.overlays];
    [_gSharedMap addOverlays:_overlays];
    [_gSharedMap setRegion:_region];
    [_gSharedMap setShowsUserLocation:_showsUserLocation];
    [_gSharedMap setScrollEnabled:_scrollEnabled];
//    [_gSharedMap setVisibleMapRect:_visibleMapRect];
    [_gSharedMap setMapType: _mapType];
    [_gSharedMap setRotateEnabled:_rotateEnabled];
    [_gSharedMap setRotationDegree:_rotation];
    [_gSharedMap setZoomEnabled:_zoomEnabled];
    [_gSharedMap setZoomLevel:_zoomLevel];

//    [_gSharedMap setZoomLevel:_zoomLevel];
//    [_gSharedMap setCenterCoordinate:_centerCoordinate];
    
    [_gSharedMap setFrame:self.bounds];
    [self addSubview:_gSharedMap];
}

-(void)fetchMapSetting{
    _centerCoordinate = _gSharedMap.centerCoordinate;
    _annotations = [NSMutableArray arrayWithArray:_gSharedMap.annotations];
    _overlays = [NSMutableArray arrayWithArray:_gSharedMap.overlays];
    
    _region = _gSharedMap.region;
    _showsUserLocation = _gSharedMap.showsUserLocation;
    _scrollEnabled = _gSharedMap.scrollEnabled;
    _visibleMapRect = _gSharedMap.visibleMapRect;
    _mapType = _gSharedMap.mapType;
    
    _rotateEnabled = _gSharedMap.rotateEnabled;
    _rotation = _gSharedMap.rotationDegree;
    
    _zoomEnabled = _gSharedMap.zoomEnabled;
    _zoomLevel = _gSharedMap.zoomLevel;
    _maxZoomLevel = _gSharedMap.maxZoomLevel;
    _minZoomLevel = _gSharedMap.minZoomLevel;
}
-(void)viewWillDisappear
{
    if (self.isActivedSharedView == NO) {
        return;
    }
    //push
    
    [self fetchMapSetting];
    
//    _viewCapture = [[self class] imageWithView:self];
    _viewCapture = [_gSharedMap takeSnapshotInRect:_gSharedMap.bounds];
    [self setNeedsDisplay];
}

+ (UIImage *) imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}



@end
