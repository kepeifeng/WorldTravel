//
//  AppDelegate.m
//  TabAndNav
//
//  Created by Kent Peifeng Ke on 1/22/15.
//  Copyright (c) 2015 Kent Peifeng Ke. All rights reserved.
//

#import "AppDelegate.h"
#import "SimpleViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window.rootViewController = [self navWithinTab];
    return YES;
}


-(UIViewController *)tabWithinNav{
    
    SimpleViewController *viewController1 = [[SimpleViewController alloc] init];
    viewController1.text = @"1";
    viewController1.tabBarItem.title = viewController1.text;
    
    
    SimpleViewController *viewController2 = [[SimpleViewController alloc] init];
    viewController2.text = @"2";
    viewController2.tabBarItem.title = viewController2.text;
    SimpleViewController *viewController3 = [[SimpleViewController alloc] init];
    viewController3.text = @"3";
    viewController3.tabBarItem.title = viewController3.text;
    SimpleViewController *viewController4 = [[SimpleViewController alloc] init];
    viewController4.text = @"4";
    viewController4.tabBarItem.title = viewController4.text;
    
    
    UITabBarController * tabViewController = [[UITabBarController alloc] init];
    tabViewController.viewControllers = @[viewController1, viewController2, viewController3, viewController4];
    
    UINavigationController * navController = [[UINavigationController alloc] initWithRootViewController:tabViewController];
    //    navController.interactivePopGestureRecognizer.delegate = self;
    
    return navController;
    
}

-(UIViewController *)navWithinTab{
    
    SimpleViewController *viewController1 = [[SimpleViewController alloc] init];
    viewController1.text = @"1";
    viewController1.tabBarItem.title = viewController1.text;
    
    
    SimpleViewController *viewController2 = [[SimpleViewController alloc] init];
    viewController2.text = @"2";
    viewController2.tabBarItem.title = viewController2.text;
    SimpleViewController *viewController3 = [[SimpleViewController alloc] init];
    viewController3.text = @"3";
    viewController3.tabBarItem.title = viewController3.text;
    SimpleViewController *viewController4 = [[SimpleViewController alloc] init];
    viewController4.text = @"4";
    viewController4.tabBarItem.title = viewController4.text;
    
    
    UITabBarController * tabViewController = [[UITabBarController alloc] init];
    tabViewController.viewControllers = @[[[UINavigationController alloc] initWithRootViewController:viewController1],
                                          [[UINavigationController alloc] initWithRootViewController:viewController2],
                                          [[UINavigationController alloc] initWithRootViewController:viewController3],
                                          [[UINavigationController alloc] initWithRootViewController:viewController4]];
    
    
    
    return tabViewController;
    
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end
