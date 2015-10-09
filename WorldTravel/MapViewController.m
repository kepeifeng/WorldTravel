//
//  MapViewController.m
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 14-6-26.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import "MapViewController.h"
#import "MessageAnnotationView.h"
#import "MyActionPaopaoView.h"


@interface MapViewController ()<LAMapViewDelegate>

@end

@implementation MapViewController{
    NSInteger markCount;
    NSMutableArray * annotations;
    NSTimer *_timer;
    id<LAAnnotation>  _currentAnnotation;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    _timer = [NSTimer scheduledTimerWithTimeInterval:5 invocation:[[NSInvocation invocationWithMethodSignature:<#(NSMethodSignature *)#>] repeats:<#(BOOL)#>]
    _timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(switchAnnotation) userInfo:nil repeats:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    self.mapView.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated{
    self.mapView.delegate = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)switchAnnotation{
    if (annotations.count == 0) {
        return;
    }
    id<LAAnnotation> _oldAnnotation = _currentAnnotation;
    if (!_currentAnnotation) {
        _currentAnnotation = [annotations firstObject];
    }
    else{
        NSUInteger index = [annotations indexOfObject:_currentAnnotation];
        index++;
        if (index == annotations.count) {
            index = 0;
        }
        _currentAnnotation = [annotations objectAtIndex:index];
    }
    
    [self.mapView selectAnnotation:_currentAnnotation animated:YES];
}


-(void)startAnimationFormAnnotation:(id<LAAnnotation>)startAnnotation toAnnotation:(id<LAAnnotation>)endAnnotation{

}

//-(void)shouldHide

#pragma mark - Map View Delegate

-(void)mapView:(LAMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate{
    
    LAPointAnnotation *annotation = [[LAPointAnnotation alloc]init];
    annotation.coordinate = coordinate;
    annotation.title = [NSString stringWithFormat:@"%d",markCount];
    if (!annotations) {
        annotations = [NSMutableArray new];
    }
    [annotations addObject:annotation];
    [self.mapView addAnnotation:annotation];
    
}

-(LAAnnotationView *)mapView:(LAMapView *)mapView viewForAnnotation:(id<LAAnnotation>)annotation{

    static NSString * MessageAnnotationViewIdentifier = @"MessageAnnotationViewIdentifier";
    MessageAnnotationView * annotationView = (MessageAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:MessageAnnotationViewIdentifier];
    if (!annotationView) {
        annotationView = [[MessageAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:MessageAnnotationViewIdentifier];
        annotationView.backgroundColor = [UIColor whiteColor];
    }
    CGRect viewFrame = CGRectZero;
    viewFrame.size = CGSizeMake(20, 20);

    annotationView.frame = viewFrame;
    UIView * actionView = [[UIView alloc] init];
    viewFrame.size.width = 80 + 10 * arc4random_uniform(10);
    viewFrame.size.height = 60 + 10 * arc4random_uniform(10);
    actionView.frame = viewFrame;
    actionView.backgroundColor = [UIColor grayColor];
    annotationView.calloutView = nil;
    MyActionPaopaoView * actionPaopaoView = [[MyActionPaopaoView alloc] init];
    annotationView.calloutView = actionPaopaoView;
//    annotationView.centerOffset = CGPointMake(0, -CGRectGetHeight(viewFrame)/2);
    
    return annotationView;
}

-(void)mapView:(LAMapView *)mapView annotationViewForBubble:(LAAnnotationView *)view{

//    CGRect viewFrame = CGRectZero;
//    viewFrame.size.width = 80 + 10 * arc4random_uniform(10);
//    viewFrame.size.height = 60 + 10 * arc4random_uniform(10);
//    UIView * actionView = [[UIView alloc] init];
//    actionView.frame = viewFrame;
//    actionView.backgroundColor = [UIColor grayColor];
}

//-(void)mapView:(LAMapView *)mapView didAddAnnotationViews:(NSArray *)views{
//    
//    for (LAAnnotationView * annotationView in views) {
//        
//        [annotationView setSelected:YES animated:YES];
////        [mapView selectAnnotation:annotationView.annotation animated:NO];
//        
////        if (![annotationView isKindOfClass:[MessageAnnotationView class]]) {
////            continue;
////        }
////        
//        
//        
//    }
//}

@end
