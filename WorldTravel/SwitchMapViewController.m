//
//  SwitchMapViewController.m
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 1/13/15.
//  Copyright (c) 2015 Kent Peifeng Ke. All rights reserved.
//

#import "SwitchMapViewController.h"
#import "LAMap.h"

#import "LAMapView.h"
@interface SwitchMapViewController ()<LAMapViewDelegate>

@property (nonatomic, weak) LAMapView * mapView;
@end

@implementation SwitchMapViewController{
//    LAMapView * _mapView;
}
@synthesize mapView = _mapView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    UISegmentedControl * mapSwitch = [[UISegmentedControl alloc] initWithItems:@[@"Baidu Map",@"Apple Map"]];
//    [mapSwitch addTarget:self action:@selector(mapSwitchValueChanged:) forControlEvents:(UIControlEventValueChanged)];
//    self.navigationItem.titleView = mapSwitch;

    LAMapView * mapView = [[LAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView = mapView;
    [self.view addSubview:mapView];
    
    _mapView.delegate = self;
    
    LAPointAnnotation * annotation = [[LAPointAnnotation alloc] init];
    annotation.coordinate = CLLocationCoordinate2DMake(22.548629, 113.935465);
    annotation.title = @"Hello";
    [_mapView addAnnotation:annotation];
    
    [_mapView setCenterCoordinate:annotation.coordinate];
    [self setupOverlays];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:(UIBarButtonItemStylePlain) target:self action:@selector(goNext:)];
    
}

-(void)setupOverlays{
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(22.548629, 113.935465);
    LAMapPoint point = LAMapPointForCoordinate(coordinate);
    LAMapRect mapRect = LAMapRectMake(point.x, point.y, 5000, 5000);
    
    LACoordinateRegion _mapRegion = LACoordinateRegionForMapRect(mapRect);;
    
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
    

    
    if (locationCoordinates) {
        int numberOfCoordinates = [locationCoordinates count];
        
        CLLocationCoordinate2D coordinates[numberOfCoordinates];
        
        
        for (NSInteger i = 0; i < [locationCoordinates count]; i++) {
            
            CLLocation *location = [locationCoordinates objectAtIndex:i];
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

    _mapView.region = _mapRegion;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_mapView viewDidAppear];
}
//-(void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//    
//}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)goNext:(id)sender{
    
    SwitchMapViewController * vc = [[SwitchMapViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - MapView

-(LAAnnotationView *)mapView:(LAMapView *)mapView viewForAnnotation:(id<LAAnnotation>)annotation{

    LAAnnotationView * annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"point"];
    if(!annotationView){
        annotationView = [[LAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"point"];
    }
    
    annotationView.annotation = annotation;
    return annotationView;
}


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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
