//
//  LAMapView.h
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 1/20/15.
//  Copyright (c) 2015 Kent Peifeng Ke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LAMapDefine.h"
#import "LAMapView.h"

@interface LAMapView : UIView<LAMapViewProtocol>


-(void)viewDidAppear;
-(void)viewWillDisappear;

@end
