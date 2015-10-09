//
//  MapAreaSelectionViewController.m
//  OfficialDemo3D
//
//  Created by Kent Peifeng Ke on 12/25/14.
//  Copyright (c) 2014 songjian. All rights reserved.
//

#import "MapAreaSelectionViewController.h"


@interface MapAreaSelectionViewController ()
@property(retain,nonatomic) id<LAOverlay> mTileOverlay;

@property (nonatomic, strong) LAAnnotationView *userLocationAnnotationView;
@end

@implementation MapAreaSelectionViewController{
    UIButton * _startButton;
    __weak UISegmentedControl * _segmentedControl;
    NSMutableArray * enabledMapType;
    NSDictionary * _allMapTypeNameDict;
    __weak UIButton * _okButton;
    __weak UIButton * _cancelButton;
    __weak UIButton * _mapLayerButton;
    UIView * _mapTypeSelectView;
    
    NSArray * _mapTypeButtons;
    
}
@synthesize mTileOverlay, mapType = _mapType;
@synthesize userLocationAnnotationView = _userLocationAnnotationView;

-(LAMapType)mapType{
    
    if (_segmentedControl) {
        LAMapType selectedMapType = [[enabledMapType objectAtIndex:_segmentedControl.selectedSegmentIndex] integerValue];
        
        return selectedMapType;
    }else{
        return _mapType;
    }

}

-(void)setMapType:(LAMapType)mapType{
    _mapType = mapType;
    if (_segmentedControl) {
        _segmentedControl.selectedSegmentIndex = [enabledMapType indexOfObject:@(mapType)];
    }
    self.title = [_allMapTypeNameDict objectForKey:@(mapType)];
    for (UIButton * button in _mapTypeButtons) {
        if (button.tag == _mapType) {
            button.selected = YES;
        }else{
            button.selected = NO;
        }
    }
    
    [self updateViewForMapType];
}
#pragma mark - Action Handlers

- (void)mapTypeAction:(UISegmentedControl *)segmentedControl
{
     self.mapType = segmentedControl.selectedSegmentIndex;
    //    [self drawLine];
    [self updateViewForMapType];
}

-(void)updateViewForMapType{

    if (mTileOverlay) {
        [self.mapView removeOverlay:mTileOverlay];
    }
    mTileOverlay = nil;
    
    LAMapType selectedMapType = self.mapType;
    switch (selectedMapType) {
        case LAMapTypeStandardStreet:
            self.mapView.mapType = LAMapTypeStandardStreet;
            break;
        case LAMapTypeStandardSatellite:
            self.mapView.mapType = LAMapTypeStandardSatellite;
            break;
        case LAMapTypeNightStreet:
            self.mapView.mapType = LAMapTypeNightStreet;
            break;
        case LAMapTypeOpenStreetMap:
        {
            //            mTileOverlay = [[TileOverlay alloc] initOverlayOnMap:OpenStreetMap];
            self.mapView.mapType = LAMapTypeStandardStreet;
            
            LATileOverlay * overlay = [[LATileOverlay alloc] initWithURLTemplate:@"http://tile.openstreetmap.org/{z}/{x}/{y}.png"];
//            overlay.mapType = LAMapTypeOpenStreetMap;
            overlay.minimumZ = 0;
            overlay.maximumZ = 19;
            mTileOverlay = overlay;
//            [self.mapView addOverlay:mTileOverlay];
            [self.mapView insertOverlay:overlay atIndex:0];
        }
            break;
        case LAMapTypeOpenCycleMap:
        {
            self.mapView.mapType = LAMapTypeStandardStreet;
            LATileOverlay * overlay = [[LATileOverlay alloc] initWithURLTemplate:@"http://tile.opencyclemap.org/cycle/{z}/{x}/{y}.png"];
//            overlay.mapType = LAMapTypeOpenCycleMap;
            overlay.minimumZ = 0;
            overlay.maximumZ = 18;
            mTileOverlay = overlay;
            //            mTileOverlay = [[TileOverlay alloc] initOverlayOnMap:OpenCycleMap];
//            [self.mapView addOverlay:mTileOverlay];
            [self.mapView insertOverlay:overlay atIndex:0];
        }
            break;
        case LAMapTypeGoogleSatellite:
        {
            self.mapView.mapType = LAMapTypeStandardStreet;
            LATileOverlay * overlay = [[LATileOverlay alloc] initWithURLTemplate:@"http://mt1.google.cn/vt/lyrs=y&hl=zh-CN&gl=cn&x={x}&y={y}&z={z}"];
//            overlay.mapType = LAMapTypeGoogleSatellite;
            overlay.minimumZ = 0;
            overlay.maximumZ = 18;
            mTileOverlay = overlay;
            //            mTileOverlay = [[TileOverlay alloc] initOverlayOnMap:GoogleMap];
            //            [self.mapView addOverlay:mTileOverlay];
            [self.mapView insertOverlay:overlay atIndex:0];
        }
            break;
        default:
            break;
    }
    

}

//-(void)drawLine
//{
//    [self.mapView removeOverlay:lines];
//    CLLocationCoordinate2D coords[5];
//    coords[0] = CLLocationCoordinate2DMake(39.972465, 116.395645);
//    coords[1] = CLLocationCoordinate2DMake(39.949459, 116.46176);
//    coords[2] = CLLocationCoordinate2DMake(39.857356, 116.449687);
//    coords[3] = CLLocationCoordinate2DMake(39.872863, 116.362875);
//    coords[4] = CLLocationCoordinate2DMake(39.911836, 116.333554);
//    lines = [LAPolyline polylineWithCoordinates:coords count:5];
//    
//    [self.mapView addOverlay:lines];
//}

#pragma mark - Initialization

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.disableAreaSelection = NO;
        self.displayMapTypeSelector = YES;
    }
    return self;
}

//- (void)initToolBar
//{
//    UIBarButtonItem *flexbleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
//                                                                                 target:self
//                                                                                 action:nil];
//
//    
//    
//    
//    UISegmentedControl *mapTypeSegmentedControl = [[UISegmentedControl alloc] initWithItems:
//                                                   enabledMapTypeName];
//    
//    _segmentedControl = mapTypeSegmentedControl;
//    mapTypeSegmentedControl.selectedSegmentIndex  = 0;
//    self.mapView.mapType  =  LAMapTypeStandard;
//    mapTypeSegmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
//    [mapTypeSegmentedControl addTarget:self action:@selector(mapTypeAction:) forControlEvents:UIControlEventValueChanged];
//    
//    UIBarButtonItem *mayTypeItem = [[UIBarButtonItem alloc] initWithCustomView:mapTypeSegmentedControl];
//    
//    self.toolbarItems = [NSArray arrayWithObjects:flexbleItem, mayTypeItem, flexbleItem, nil];
//}
-(void)setDisplayMapTypeSelector:(BOOL)displayMapTypeSelector{
    _displayMapTypeSelector = displayMapTypeSelector;
    _mapLayerButton.hidden = !displayMapTypeSelector;
    
}
#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    LAMapView * mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];

    mapView.delegate = self;
    mapView.showsUserLocation = YES;
    mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    
//    if(mapView.userLocation){
//        mapView.centerCoordinate = mapView.userLocation.coordinate;
//    }
    

    [self.view addSubview:mapView];
    self.mapView = mapView;
    
    
    _allMapTypeNameDict = @{@(LAMapTypeStandardStreet):@"街道地图",@(LAMapTypeStandardSatellite):@"卫星",@(LAMapTypeNightStreet):@"夜间地图",
                            @(LAMapTypeOpenStreetMap):@"OpenStreetMap",@(LAMapTypeOpenCycleMap):@"OpenCycleMap",@(LAMapTypeGoogleSatellite):@"Google卫星图"};
    enabledMapType = [NSMutableArray new];
    
    NSArray * allMapType = [_allMapTypeNameDict.allKeys sortedArrayUsingComparator:^NSComparisonResult(NSNumber * obj1, NSNumber * obj2) {
        return ([obj1 compare:obj2] );
    }];
    for (NSNumber * number in allMapType) {
        if ([self.excludeMapTypes containsObject:number]) {
            continue;
        }
        
        [enabledMapType addObject:number];
//        [enabledMapTypeName addObject:[allMapTypeDict objectForKey:number]];
    }
    
    if ([enabledMapType containsObject:@(_mapType)]) {
        self.mapType = _mapType;
    }else{
        self.mapType = [[enabledMapType firstObject] integerValue];
    }
    
    if (self.displayMapTypeSelector) {
    }
    

    NSInteger bottomMargin = 10;
    UIView * toolsView = [[UIView alloc] initWithFrame:(CGRectMake(CGRectGetMaxX(self.mapView.frame) - 40 - 10, CGRectGetMaxY(self.mapView.frame) - 130 - bottomMargin, 40, 130))];
    toolsView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
    
    [self.view addSubview:toolsView];
    
    UIButton * locatingButton = [[UIButton alloc] initWithFrame:(CGRectMake(0, 0, 40, 40))];
    locatingButton.backgroundColor = [UIColor whiteColor];
    [locatingButton setImage:[UIImage imageNamed:@"icon-user-location"] forState:(UIControlStateNormal)];
    [locatingButton addTarget:self action:@selector(userLocationButtonTapped:) forControlEvents:(UIControlEventTouchUpInside)];
    [toolsView addSubview:locatingButton];
    
    UIButton * zoomInButton = [[UIButton alloc] initWithFrame:(CGRectMake(0, 50, 40, 40))];
    zoomInButton.backgroundColor = [UIColor whiteColor];
//    [zoomInButton setTitle:@"+" forState:(UIControlStateNormal)];
//    zoomInButton.titleLabel.font = [UIFont boldSystemFontOfSize:40];
//    [zoomInButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [zoomInButton setImage:[UIImage imageNamed:@"icon_plus"] forState:(UIControlStateNormal)];
    [zoomInButton addTarget:self action:@selector(zoomInButtonTapped:) forControlEvents:(UIControlEventTouchUpInside)];
    [toolsView addSubview:zoomInButton];
    
    UIButton * zoomOutButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 90, 40, 40)];
    zoomOutButton.backgroundColor = [UIColor whiteColor];
//    [zoomOutButton setTitle:@"-" forState:(UIControlStateNormal)];
//    zoomOutButton.titleLabel.font = [UIFont boldSystemFontOfSize:40];
//    [zoomOutButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    
    [zoomOutButton setImage:[UIImage imageNamed:@"icon_minus"] forState:(UIControlStateNormal)];
    [zoomOutButton addTarget:self action:@selector(zoomOutButtonTapped:) forControlEvents:(UIControlEventTouchUpInside)];
    [toolsView addSubview:zoomOutButton];
    
    UIButton * mapLayerButton = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetHeight(self.view.frame) - 40 - bottomMargin, 40, 40)];
    [mapLayerButton setBackgroundColor:[UIColor whiteColor]];
    [mapLayerButton setImage:[UIImage imageNamed:@"icon_map_type"] forState:(UIControlStateNormal)];
    [mapLayerButton addTarget:self action:@selector(mapLayerButtonTapped:) forControlEvents:(UIControlEventTouchUpInside)];
    mapLayerButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    
    mapLayerButton.hidden = !self.displayMapTypeSelector;
    [self.view addSubview:mapLayerButton];
    
    _mapLayerButton = mapLayerButton;
    
    
    
    //    UIBarButtonItem * locateButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
    //                                                                                       target:self action:@selector(locateButtonItemTapped:)];
    //    self.navigationItem.rightBarButtonItem = locateButtonItem;
    
    UIBarButtonItem * moreButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"More" style:(UIBarButtonItemStylePlain) target:self action:@selector(moreButtonTapped:)];
    self.navigationItem.rightBarButtonItem = moreButtonItem;
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(22.548629, 113.935465);
    LAMapPoint point = LAMapPointForCoordinate(coordinate);
    LAMapRect mapRect = LAMapRectMake(point.x, point.y, 5000, 5000);
    
    self.mapRegion = LACoordinateRegionForMapRect(mapRect);;

    CLLocation *coordinates1 =  [[CLLocation alloc] initWithLatitude:_mapRegion.center.latitude - _mapRegion.span.latitudeDelta/2
                                                           longitude:_mapRegion.center.longitude - _mapRegion.span.longitudeDelta/2];
    
    CLLocation *coordinates2 =  [[CLLocation alloc] initWithLatitude:_mapRegion.center.latitude - _mapRegion.span.latitudeDelta/2
                                                           longitude:_mapRegion.center.longitude + _mapRegion.span.longitudeDelta/2];
    
    CLLocation *coordinates3 =  [[CLLocation alloc] initWithLatitude:_mapRegion.center.latitude + _mapRegion.span.latitudeDelta/2
                                                           longitude:_mapRegion.center.longitude + _mapRegion.span.longitudeDelta/2];
    
    CLLocation *coordinates4 =  [[CLLocation alloc] initWithLatitude:_mapRegion.center.latitude + _mapRegion.span.latitudeDelta/2
                                                           longitude:_mapRegion.center.longitude - _mapRegion.span.longitudeDelta/2];
    

    
    
    NSMutableArray *locationCoordinates = [[NSMutableArray alloc] initWithObjects:coordinates1,coordinates2,coordinates3,coordinates4,coordinates1, nil];
    
    int numberOfCoordinates = [locationCoordinates count];
    
    CLLocationCoordinate2D coordinates[numberOfCoordinates];
    
    
    for (NSInteger i = 0; i < [locationCoordinates count]; i++) {
        
        CLLocation *location = [locationCoordinates objectAtIndex:i];
        CLLocationCoordinate2D coordinate = location.coordinate;
        
        coordinates[i] = coordinate;
    }


    
    LAPolygon * polygon = [LAPolygon polygonWithCoordinates:coordinates count:numberOfCoordinates];
    [self.mapView addOverlay:polygon];

    self.coordinates = locationCoordinates;
    
    if (self.coordinates) {
        int numberOfCoordinates = [self.coordinates count];
        
        CLLocationCoordinate2D coordinates[numberOfCoordinates];
        
        
        for (NSInteger i = 0; i < [self.coordinates count]; i++) {
            
            CLLocation *location = [self.coordinates objectAtIndex:i];
            CLLocationCoordinate2D coordinate = location.coordinate;
            
            coordinates[i] = coordinate;
            
//            LAPointAnnotation * annotation = [[MKPointAnnotation alloc] init];
            
            LAPointAnnotation * annotation = [[LAPointAnnotation alloc] init];
            annotation.coordinate = coordinate;
            [self.mapView addAnnotation:annotation];
        }
        
        LAPolyline * line = [LAPolyline polylineWithCoordinates:coordinates count:numberOfCoordinates];
        [self.mapView addOverlay:line];

    }
    [self updateViewForMapType];
}

-(void)setDisableAreaSelection:(BOOL)disableAreaSelection{
    _disableAreaSelection = disableAreaSelection;

}
-(void)userLocationButtonTapped:(UIButton *)sender{
    self.mapView.centerCoordinate = self.mapView.userLocation.coordinate;
    
}

-(void)zoomInButtonTapped:(UIButton *)sender{
    [self.mapView setZoomLevel:self.mapView.zoomLevel + 1  animated:YES];
}

-(void)zoomOutButtonTapped:(UIButton *)sender{
    
    [self.mapView setZoomLevel:self.mapView.zoomLevel - 1  animated:YES];
}

-(void)mapLayerButtonTapped:(UIButton *)sender{


    if(_mapTypeSelectView.superview){
        [self closeMapTypeSelectView];
    }else{
        [self showMapTypeSelectView];
    }
    
}
-(void)setMapRegion:(LACoordinateRegion)mapRegion{
    _mapRegion = mapRegion;
    [self.mapView setRegion:mapRegion animated:YES];
}

-(void)closeMapTypeSelectView{
    
    if (_mapTypeSelectView.superview) {
        
        
        _mapTypeSelectView.transform = CGAffineTransformIdentity;
        //        _mapTypeSelectView.frame = sender.frame;
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            CGAffineTransform transform = CGAffineTransformMakeScale(0.5, 0.5);
            transform = CGAffineTransformTranslate(transform, -40, 40);
            _mapTypeSelectView.transform = transform;
            _mapTypeSelectView.alpha = 0;
        } completion:^(BOOL finished) {
            [_mapTypeSelectView removeFromSuperview];
        }];
        
        [_mapLayerButton setImage:[UIImage imageNamed:@"icon_map_type"] forState:(UIControlStateNormal)];
    }

}

-(void)showMapTypeSelectView{
    if (!_mapTypeSelectView) {
        
        
        NSDictionary * mapButtonImages = @{@(LAMapTypeStandardStreet) : @"icon_maptype_standard_street",
                                      @(LAMapTypeStandardSatellite) : @"icon_maptype_standard_satellite",
                                      @(LAMapTypeNightStreet) : @"icon_maptype_night_street",
                                      @(LAMapTypeOpenStreetMap) : @"icon_maptype_osm",
                                      @(LAMapTypeOpenCycleMap) : @"icon_maptype_ocm",
                                      @(LAMapTypeGoogleSatellite) : @"icon_maptype_google"};
        
        
        CGSize buttonSize = CGSizeMake(90, 60);
        CGFloat margin = 5;
        CGFloat labelHeight = 15;
        
        CGFloat viewHeight =  (buttonSize.height + labelHeight + margin)*(((enabledMapType.count-1)/3)+1) + margin;
        CGFloat viewWidth = 0;
        if (enabledMapType.count >=3 ) {
            viewWidth =buttonSize.width * 3 + margin * 4;
        }else{
            viewWidth = (buttonSize.width + margin) * enabledMapType.count + margin;
        }
        
        _mapTypeSelectView = [[UIView alloc] initWithFrame:(CGRectMake(CGRectGetMinX(_mapLayerButton.frame), CGRectGetMinY(_mapLayerButton.frame) - viewHeight,
                                                                       viewWidth,viewHeight))];
        _mapTypeSelectView.backgroundColor = [UIColor whiteColor];
        UIButton * mapTypeButton;
        UILabel * mapTypeLabel;
        
        
        CGRect buttonRect = CGRectMake(margin, margin, buttonSize.width, buttonSize.height);
        NSMutableArray * buttonsArray = [NSMutableArray new];
        
        for (NSNumber * number in enabledMapType) {
            mapTypeButton = [[UIButton alloc] initWithFrame:buttonRect];
            NSString * imageName = [mapButtonImages objectForKey:number];
            
            [mapTypeButton setImage:[UIImage imageNamed:imageName] forState:(UIControlStateNormal)];
            [mapTypeButton setImage:[UIImage imageNamed:[imageName stringByAppendingString:@"_selected"]] forState:(UIControlStateSelected)];
            [mapTypeButton addTarget:self action:@selector(mapTypeButtonTapped:) forControlEvents:(UIControlEventTouchUpInside)];
            mapTypeButton.tag = [number integerValue];
            [_mapTypeSelectView addSubview:mapTypeButton];

            [buttonsArray addObject:mapTypeButton];
            mapTypeLabel = [[UILabel alloc] initWithFrame:(CGRectMake(CGRectGetMinX(mapTypeButton.frame), CGRectGetMaxY(mapTypeButton.frame),
                                                                      CGRectGetWidth(mapTypeButton.frame), labelHeight))];
            mapTypeLabel.font = [UIFont systemFontOfSize:9];
            mapTypeLabel.textColor = [UIColor lightGrayColor];
            mapTypeLabel.textAlignment = NSTextAlignmentCenter;
            mapTypeLabel.text = [_allMapTypeNameDict objectForKey:number];
            [_mapTypeSelectView addSubview:mapTypeLabel];
            
            
            buttonRect.origin.x += margin + buttonRect.size.width;
            if (buttonRect.origin.x > CGRectGetWidth(_mapTypeSelectView.frame)- margin - buttonRect.size.width) {
                buttonRect.origin.x = margin;
                buttonRect.origin.y += margin + buttonRect.size.height + labelHeight;
            }
        }
        
//        
//        mapTypeButton = [[UIButton alloc] initWithFrame:(CGRectMake(margin, margin, buttonSize.width, buttonSize.height))];
//        [mapTypeButton setImage:[UIImage imageNamed:@"icon_maptype_google"] forState:(UIControlStateNormal)];
//        [mapTypeButton setImage:[UIImage imageNamed:@"icon_maptype_google_selected"] forState:(UIControlStateSelected)];
//        [mapTypeButton addTarget:self action:@selector(mapTypeButtonTapped:) forControlEvents:(UIControlEventTouchUpInside)];
//        mapTypeButton.tag = LAMapTypeGoogleSatellite;
//        [_mapTypeSelectView addSubview:mapTypeButton];
//        
//        [buttonsArray addObject:mapTypeButton];
//        mapTypeLabel = [[UILabel alloc] initWithFrame:(CGRectMake(CGRectGetMinX(mapTypeButton.frame), CGRectGetMaxY(mapTypeButton.frame),
//                                                                  CGRectGetWidth(mapTypeButton.frame), labelHeight))];
//        mapTypeLabel.font = [UIFont systemFontOfSize:9];
//        mapTypeLabel.textColor = [UIColor lightGrayColor];
//        mapTypeLabel.textAlignment = NSTextAlignmentCenter;
//        mapTypeLabel.text = @"Google卫星图";
//        [_mapTypeSelectView addSubview:mapTypeLabel];
//        
//        
//        mapTypeButton = [[UIButton alloc] initWithFrame:(CGRectMake(buttonSize.width + margin *2, margin, buttonSize.width, buttonSize.height))];
//        [mapTypeButton setImage:[UIImage imageNamed:@"icon_maptype_osm"] forState:(UIControlStateNormal)];
//        [mapTypeButton setImage:[UIImage imageNamed:@"icon_maptype_osm_selected"] forState:(UIControlStateSelected)];
//        [mapTypeButton addTarget:self action:@selector(mapTypeButtonTapped:) forControlEvents:(UIControlEventTouchUpInside)];
//        mapTypeButton.tag = LAMapTypeOpenStreetMap;
//        [_mapTypeSelectView addSubview:mapTypeButton];
//        [buttonsArray addObject:mapTypeButton];
//        mapTypeLabel = [[UILabel alloc] initWithFrame:(CGRectMake(CGRectGetMinX(mapTypeButton.frame), CGRectGetMaxY(mapTypeButton.frame), CGRectGetWidth(mapTypeButton.frame), labelHeight))];
//        mapTypeLabel.font = [UIFont systemFontOfSize:9];
//        mapTypeLabel.textColor = [UIColor lightGrayColor];
//        mapTypeLabel.text = @"OpenStreetMap";
//        mapTypeLabel.textAlignment = NSTextAlignmentCenter;
//        [_mapTypeSelectView addSubview:mapTypeLabel];
//        
//        
//        mapTypeButton = [[UIButton alloc] initWithFrame:(CGRectMake(buttonSize.width*2 + margin *3, margin, buttonSize.width, buttonSize.height))];
//        [mapTypeButton setImage:[UIImage imageNamed:@"icon_maptype_ocm"] forState:(UIControlStateNormal)];
//        [mapTypeButton setImage:[UIImage imageNamed:@"icon_maptype_ocm_selected"] forState:(UIControlStateSelected)];
//        [mapTypeButton addTarget:self action:@selector(mapTypeButtonTapped:) forControlEvents:(UIControlEventTouchUpInside)];
//        mapTypeButton.tag = LAMapTypeOpenCycleMap;
//        [_mapTypeSelectView addSubview:mapTypeButton];
//        [buttonsArray addObject:mapTypeButton];
//        mapTypeLabel = [[UILabel alloc] initWithFrame:(CGRectMake(CGRectGetMinX(mapTypeButton.frame), CGRectGetMaxY(mapTypeButton.frame), CGRectGetWidth(mapTypeButton.frame), labelHeight))];
//        mapTypeLabel.font = [UIFont systemFontOfSize:9];
//        mapTypeLabel.textColor = [UIColor lightGrayColor];
//        mapTypeLabel.text = @"OpenCycleMap";
//        mapTypeLabel.textAlignment = NSTextAlignmentCenter;
//        [_mapTypeSelectView addSubview:mapTypeLabel];
        
        _mapTypeButtons = buttonsArray;
        for (UIButton * button in _mapTypeButtons) {
            if (button.tag == _mapType) {
                button.selected = YES;
            }else{
                button.selected = NO;
            }
        }
    }
    
    [_mapLayerButton setImage:[UIImage imageNamed:@"icon_cross"] forState:(UIControlStateNormal)];
    
    [self.view addSubview:_mapTypeSelectView];
    CGAffineTransform transform = CGAffineTransformMakeScale(0.5, 0.5);
    transform = CGAffineTransformTranslate(transform, -40, 40);
    _mapTypeSelectView.transform = transform;
    _mapTypeSelectView.alpha = 0;
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _mapTypeSelectView.transform = CGAffineTransformIdentity;
        _mapTypeSelectView.alpha = 1;
    } completion:nil];
}

-(void)mapTypeButtonTapped:(UIButton *)sender{
    self.mapType = sender.tag;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    self.mapView.mapType = LAMapTypeStandardStreet;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.mapView.delegate = self;
//    if (self.displayMapTypeSelector) {
//        self.navigationController.toolbar.barStyle      = UIBarStyleDefault;
//        self.navigationController.toolbar.translucent   = YES;
//        [self.navigationController setToolbarHidden:NO animated:animated];
//    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.mapView.delegate = nil;
}

-(void)moreButtonTapped:(UIBarButtonItem *)sender{
    
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"输入经纬度",@"选择兴趣点", nil];
    [actionSheet showInView:self.view];
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        
    }else if(buttonIndex == 1){
        //选择兴趣点
        
    }
    
}

-(void)locateButtonItemTapped:(id)sender{
    
    [self.mapView setCenterCoordinate:(CLLocationCoordinate2DMake(22.524144, 113.943141))];
    
}

#pragma mark - LAMapViewDelegate

-(LAOverlayView *)mapView:(LAMapView *)mapView viewForOverlay:(id<LAOverlay>)overlay{
    
    if ([overlay isKindOfClass:[LAPolyline class]]) {
        LAPolylineView *line = [[LAPolylineView alloc] initWithOverlay:overlay];
        line.strokeColor = [UIColor colorWithRed:9.0/255.0 green:94.0/255.0 blue:201.0/255.0 alpha:1.0];
        line.lineWidth = 3.5f;
        return line;
        
    }else if([overlay isKindOfClass:[LATileOverlay class]]){
        LATileOverlayView * view = [[LATileOverlayView alloc] initWithTileOverlay:overlay];
        return view;
    }else if ([overlay isKindOfClass:[LACircle class]]){
        LACircleView * view = [[LACircleView alloc] initWithCircle:(LACircle *)overlay];
        return view;
    }
    else if ([overlay isKindOfClass:[LAPolygon class]]){
        
        LAPolygonView * polygonView = [[LAPolygonView alloc] initWithPolygon:(LAPolygon *)overlay];
        polygonView.strokeColor = [UIColor redColor];
        polygonView.fillColor = [UIColor colorWithRed:1.000 green:0.000 blue:0.000 alpha:0.100];
        polygonView.lineWidth = 2;
        
        return polygonView;
    }else if ([overlay isKindOfClass:[LAPolyline class]])
    {
        LAPolylineView *polylineView = [[LAPolylineView alloc] initWithPolyline:overlay];
    
        polylineView.lineWidth    = 2.f;
        polylineView.strokeColor  = [UIColor colorWithRed:0.242 green:0.428 blue:1.000 alpha:1.000];
        polylineView.lineJoin = kCGLineJoinRound;
        polylineView.lineCap  = kCGLineCapRound;
        
        
        return polylineView;
    }
    
    
    return nil;
}

- (LAAnnotationView *)mapView:(LAMapView *)mapView viewForAnnotation:(id<LAAnnotation>)annotation
{
    /* 自定义userLocation对应的annotationView. */
    if ([annotation isKindOfClass:[LAUserLocation class]])
    {
        static NSString *userLocationStyleReuseIndetifier = @"userLocationStyleReuseIndetifier";
        LAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:userLocationStyleReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[LAPinAnnotationView alloc] initWithAnnotation:annotation
                                                             reuseIdentifier:userLocationStyleReuseIndetifier];
        }
        
        annotationView.image = [UIImage imageNamed:@"userPosition"];
        
        self.userLocationAnnotationView = annotationView;
        
        return annotationView;
    }
    
    return nil;
}

- (void)mapView:(LAMapView *)mapView didUpdateUserLocation:(LAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if (!updatingLocation && self.userLocationAnnotationView != nil)
    {
        [UIView animateWithDuration:0.1 animations:^{
            
            double degree = userLocation.heading.trueHeading - self.mapView.rotation;
            self.userLocationAnnotationView.transform = CGAffineTransformMakeRotation(degree * M_PI / 180.f );
            
        }];
    }
}

@end
