//
//  DetailViewManager.h
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 1/5/15.
//  Copyright (c) 2015 Kent Peifeng Ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailViewManager : NSObject<UISplitViewControllerDelegate>
@property (nonatomic) UISplitViewController * splitViewController;
@property (nonatomic, readonly) UIViewController * mainViewController;
@property (nonatomic) UIViewController * detailViewController;
@end
