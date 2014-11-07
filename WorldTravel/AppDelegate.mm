//
//  AppDelegate.m
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 14-5-5.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import "AppDelegate.h"
#import "MapViewController.h"
#import <CocoaLumberjack/CocoaLumberjack.h>
#import "ViewController.h"
#import "MainViewController.h"


static const int ddLogLevel = LOG_LEVEL_VERBOSE;

static long long idCounter;
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    _mapManager = [[BMKMapManager alloc] init];
    BOOL ret = [_mapManager start:@"7KDoyNKBHeQjuk5MzRG4puZQ" generalDelegate:nil];
    if(!ret){
        NSLog(@"Baidu Map Manager Start Failed");
    }

    
//    MapViewController * mapViewController = [[MapViewController alloc] init];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[MainViewController alloc] init]];

    [self showAlertInOneMinute];
    

    
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    // And then enable colors
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];

    NSLog(@"%lld", idCounter++);
    NSLog(@"%lld", idCounter++);
    NSLog(@"%lld", idCounter++);
    NSLog(@"%lld", idCounter++);
    
    DDLogError(@"This is an error.");
    DDLogWarn(@"This is a warning.");
    DDLogInfo(@"This is just a message.");
    DDLogVerbose(@"This is a verbose message.");
    
    return YES;
}



-(void)doSomethingToTheArray:(NSMutableArray *)array{
    [array removeLastObject];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)showAlertInOneMinute{

    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    NSDate * date = [NSDate dateWithTimeIntervalSinceNow:30];
    UILocalNotification * localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = date;
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.alertBody = @"Hello!";
    localNotification.alertAction = @"Slide to Check";
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    NSLog(@"Scheduled Local Notification");

}

@end
