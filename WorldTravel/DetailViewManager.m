//
//  DetailViewManager.m
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 1/5/15.
//  Copyright (c) 2015 Kent Peifeng Ke. All rights reserved.
//

#import "DetailViewManager.h"

@implementation DetailViewManager{
    UIBarButtonItem * _displayModeButtonItem;
}


-(UIViewController *)mainViewController{
    return [self.splitViewController.viewControllers firstObject];
}

-(void)setDetailViewController:(UIViewController *)detailViewController{

    _detailViewController = detailViewController;
    UIViewController * mainViewController = self.mainViewController;
    UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
    
    self.splitViewController.viewControllers = @[mainViewController, navigationController];
    [self splitViewController:self.splitViewController willChangeToDisplayMode:self.splitViewController.displayMode];
    
}

-(void)setSplitViewController:(UISplitViewController *)splitViewController{
    _splitViewController = splitViewController;
    _displayModeButtonItem = splitViewController.displayModeButtonItem;
    _displayModeButtonItem.title = @"List";
}

-(void)listButtonTapped:(UIBarButtonItem *)sender{


    if (self.splitViewController.displayMode == UISplitViewControllerDisplayModePrimaryHidden) {
        
        [self.splitViewController setPreferredDisplayMode:(UISplitViewControllerDisplayModePrimaryOverlay)];
        
    }
    
}

-(void)splitViewController:(UISplitViewController *)svc willChangeToDisplayMode:(UISplitViewControllerDisplayMode)displayMode{
    NSLog(@"%d", displayMode);
    
    if (displayMode == UISplitViewControllerDisplayModePrimaryHidden) {
        
//        _detailViewController.navigationItem.leftBarButtonItem = _displayModeButtonItem;
        _detailViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"List" style:(UIBarButtonItemStylePlain) target:self action:@selector(listButtonTapped:)];
        
    }else{
        _detailViewController.navigationItem.leftBarButtonItem = nil;
        
    }
}
@end
