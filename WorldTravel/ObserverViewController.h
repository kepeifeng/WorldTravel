//
//  ObserverViewController.h
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 12/30/14.
//  Copyright (c) 2014 Kent Peifeng Ke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownloadTask : NSObject
@property (nonatomic) float progress;
@property (nonatomic, readonly) float result;
@end

@interface ObserverViewController : UIViewController


@end
