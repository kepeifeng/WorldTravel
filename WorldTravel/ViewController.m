//
//  ViewController.m
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 14-5-5.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import "ViewController.h"
#import "ChatViewController.h"
#import "LAMapView.h"

@interface ViewController ()<CLLocationManagerDelegate>
@property (nonatomic , strong) CLLocationManager *locationManager;
@end

@implementation ViewController{
    NSInteger markCount;
    NSMutableArray *pointArray;
    LAPolyline *pathLine;
    LAPolylineView *pathView;
    CLLocationManager * lm;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    pointArray = [NSMutableArray new];
    lm = [[CLLocationManager alloc] init];
    lm.delegate = self;
    lm.desiredAccuracy = kCLLocationAccuracyBest;
    lm.pausesLocationUpdatesAutomatically = YES;
    lm.activityType = CLActivityTypeFitness;
    // Set a movement threshold for new events.
    lm.distanceFilter = 3;//kCLDistanceFilterNone; // meters
    self.locationManager = lm;
    if ([lm respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [lm requestAlwaysAuthorization];
    }
    
    CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
    if (authorizationStatus != kCLAuthorizationStatusAuthorizedAlways && authorizationStatus != kCLAuthorizationStatusAuthorizedWhenInUse ) {
        return;
    }
    [lm startUpdatingLocation];
    
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated
{
//	[_mapView viewWillAppear];
	_mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    
    self.navigationController.toolbarHidden = NO;
    


}

-(void)viewWillDisappear:(BOOL)animated
{
//    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    self.navigationController.toolbarHidden = YES;
}

- (IBAction)fineMeButtonTapped:(id)sender {
    
    if(self.mapView.showsUserLocation){
        self.mapView.showsUserLocation = NO;
    }else{
        self.mapView.showsUserLocation = NO;
        self.mapView.userTrackingMode = LAUserTrackingModeNone;
        self.mapView.showsUserLocation = YES;
    }
    
    
}



//-(void)mapView:(LAMapView *)mapView onClickedMapPoi:(LAMapPoi *)mapPoi{
//
//}

-(void)mapView:(LAMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate{
    NSLog(@"Tapped");
    LAPointAnnotation *annotation = [[LAPointAnnotation alloc]init];
    annotation.coordinate = coordinate;
    annotation.title = [NSString stringWithFormat:@"%d",markCount];
    [self.mapView addAnnotation:annotation];
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    
    [pointArray addObject:location];
    
    CLLocationCoordinate2D coordinates[pointArray.count];
    for (NSInteger index = 0; index < pointArray.count; index++) {
        CLLocation *location = [pointArray objectAtIndex:index];
        CLLocationCoordinate2D coordinate = location.coordinate;
        
        coordinates[index] = coordinate;
    }


    LAPolyline *polyLine = [LAPolyline polylineWithCoordinates:coordinates count:[pointArray count]];
    if(pathLine){
    
        [self.mapView removeOverlay:pathLine];
    }
    [self.mapView addOverlay:polyLine];
    pathLine = polyLine;
    


}

-(LAAnnotationView *)mapView:(LAMapView *)mapView viewForAnnotation:(id<LAAnnotation>)annotation{

    static NSString * LAAnnotationViewIdentifier = @"AnnotationViewIdentifier";
    static UIImage *image;
    LAAnnotationView *annotationView = [self.mapView dequeueReusableAnnotationViewWithIdentifier:LAAnnotationViewIdentifier];
    if(!annotationView){
        annotationView = [[LAAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:LAAnnotationViewIdentifier];
        if(!image){
        
            image = [UIImage imageNamed:@"mark"];

        }
        CGSize imageSize = image.size;
        annotationView.annotation = annotation;
        annotationView.image = image;
        annotationView.centerOffset = CGPointMake(0, -annotationView.frame.size.height/2);
    }
    else{
        annotationView.annotation = annotation;
    }
    
    return annotationView;
}



-(LAOverlayView *)mapView:(LAMapView *)mapView viewForOverlay:(id<LAOverlay>)overlay{
    

    
    LAPolylineView *polylineView = [[LAPolylineView alloc]initWithOverlay:overlay];
    polylineView.strokeColor = [UIColor blueColor];
    polylineView.lineWidth = 2.0;
    
    return polylineView;

}

-(void)mapView:(LAMapView *)mapView didUpdateUserLocation:(LAUserLocation *)userLocation{
    
//    LAPointAnnotation *annotation = [[LAPointAnnotation alloc]init];
//    annotation.coordinate = userLocation.coordinate;
//    [self.mapView addAnnotation:annotation];
    
    LACoordinateRegion region = LACoordinateRegionMakeWithDistance(userLocation.coordinate, 2000, 2000);
    [self.mapView setRegion:region animated:YES];

}


#pragma mark- delegate

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    
    if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [lm startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    //  NSLog(@"----------%s",__PRETTY_FUNCTION__);
    // If it's a relatively recent event, turn off updates to save power.
    CLLocation* location = [locations lastObject];
    NSLog(@"%f,%f",location.coordinate.longitude, location.coordinate.latitude);
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
      NSLog(@"XXXXXXXXX %s",__PRETTY_FUNCTION__);
    
}


@end
