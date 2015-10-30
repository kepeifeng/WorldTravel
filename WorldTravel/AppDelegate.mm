//
//  AppDelegate.m
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 14-5-5.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import "AppDelegate.h"
#import "MapViewController.h"

#import "DDASLLogger.h"
#import "DDTTYLogger.h"
#import "DDFileLogger.h"

#import "ViewController.h"
#import "MainViewController.h"
#import "AKNavigationBar.h"
#import "DetailViewManager.h"
#import "WelcomeViewController.h"
#import "SimpleViewController.h"

#import "UINavigationBar+CustomHeight.h"
#import "EmptyButtonViewController.h"
#import "SwitchMapViewController.h"
#import "NSString+Utility.h"
#import "DDFileLogger.h"
#import "NSFileManager+Utility.h"



const static NSString *APIKey = @"0f056f7a0f082ce49b19b7cbf760f3c0";

static long long idCounter;
@implementation AppDelegate
{
    DetailViewManager * _detailViewManager;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"Document Folder:%@",[[NSFileManager defaultManager] documentFolderPath]);
    NSLog(@"ApplicationSupport Folder:%@",[[NSFileManager defaultManager] supportFolderPath]);
    
    NSLog(@"Registering for push notifications...");
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
#ifdef BAIDU_MAP
    _mapManager = [[BMKMapManager alloc] init];
    BOOL ret = [_mapManager start:@"7KDoyNKBHeQjuk5MzRG4puZQ" generalDelegate:nil];
    if(!ret){
        NSLog(@"Baidu Map Manager Start Failed");
    }
#elif defined(GAODE_MAP)
    if ([APIKey length] == 0)
    {
#define kMALogTitle @"提示"
#define kMALogContent @"apiKey为空，请检查key是否正确设置"
        
        NSString *log = [NSString stringWithFormat:@"[MAMapKit] %@", kMALogContent];
        NSLog(@"%@", log);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kMALogTitle message:kMALogContent delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [alert show];
        });
    }
    
    [MAMapServices sharedServices].apiKey = (NSString *)APIKey;
#endif
    
//    
//    if ([UINavigationBar instancesRespondToSelector:@selector(setBackIndicatorImage:)])
//    {
        // iOS 7
//        UIEdgeInsets insets = UIEdgeInsetsMake(0, 5, 5, 5);
//        [[UINavigationBar appearance] setBackIndicatorImage:[[[UIImage imageNamed:@"navigation_left_btn"] imageWithAlignmentRectInsets:insets] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//        [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[[[UIImage imageNamed:@"navigation_left_btn"] imageWithAlignmentRectInsets:insets] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ];
//        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(5, 0) forBarMetrics:UIBarMetricsDefault]; // Takes out title
        
//    }
    
//    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleBlackOpaque)];
//    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    

//    UINavigationController * navigationController = [[AKNavigationController alloc] initWithNavigationBarClass:[AKNavigationBar class] toolbarClass:nil];
    
//    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.815 green:0.919 blue:0.895 alpha:1.000]];
    

    self.window.tintColor = [UIColor colorWithRed:0.986 green:0.134 blue:0.236 alpha:1.000];
    UINavigationController * navigationController = [[UINavigationController alloc] init];
//    navigationController.navigationBar.translucent = NO;
//    navigationController.delegate = self;
    UIViewController * viewController = [[MainViewController alloc] init];
    [navigationController setViewControllers:@[viewController]];
    navigationController.tabBarItem.title = @"iOS Playground";
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        _detailViewManager = [[DetailViewManager alloc] init];
        WelcomeViewController * welcomeViewController = [[WelcomeViewController alloc] init];
        UISplitViewController * splitViewController = [[UISplitViewController alloc] init];
        splitViewController.delegate = _detailViewManager;
        splitViewController.viewControllers = @[navigationController];
        _detailViewManager.splitViewController = splitViewController;
        
        [_detailViewManager setDetailViewController:welcomeViewController];
        self.window.rootViewController = splitViewController;
        
        
    }else{

//        UITabBarController *tabController = [[UITabBarController alloc] init];
//        SwitchMapViewController * welcomeViewController = [[SwitchMapViewController alloc] init];
//        welcomeViewController.tabBarItem.title = @"SwitchMap";
//        
//        EmptyButtonViewController * emptyBackButtonVC = [[EmptyButtonViewController alloc] init];
//        emptyBackButtonVC.tabBarItem.title = @"EBVC";
//        
//        tabController.viewControllers = @[welcomeViewController,emptyBackButtonVC, navigationController];
//        self.window.rootViewController =tabController;
        self.window.rootViewController = navigationController;
    }


    [self showAlertInOneMinute];

    
    
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    DDFileLogger * fileLogger = [[DDFileLogger alloc] init];
//    fileLogger.rollingFrequency = 1; // 24 hour rolling
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
//    [fileLogger rollLogFileNow];
    [DDLog addLogger:fileLogger];
    
/*
    DDLogError(@"This is an error.");
    DDLogWarn(@"This is a warning.");
    DDLogInfo(@"This is just a message.");
    DDLogVerbose(@"This is a verbose message.");

    

*/
        DDLogInfo(@"Application Did Finished Launch with Options:\n%@", launchOptions);
    /*NSDictionary * params = @{@"a":@"aaa",@"b":@"bbbb",@"c":@[@"c1",@"c2",@"c3"]};
    NSURL * url = [self getRequestToSubUrl:@"phone" parameters:params];
    NSLog(@"%@", url);*/



    
    return YES;
}

//- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    [self.window addSubview:viewController.view];
//    [self.window makeKeyAndVisible];
//    
//
//    return YES;
//}

- (void)remoteControlReceivedWithEvent:(UIEvent *)event
{
    NSDictionary * typeName = @{@(0):@"UIEventSubtypeNone",
                                @(1):@"UIEventSubtypeMotionShake",
                                @(100):@"UIEventSubtypeRemoteControlPlay",
                                @(101):@"UIEventSubtypeRemoteControlPause",
                                @(102):@"UIEventSubtypeRemoteControlStop",
                                @(103):@"UIEventSubtypeRemoteControlTogglePlayPause",
                                @(104):@"UIEventSubtypeRemoteControlNextTrack",
                                @(105):@"UIEventSubtypeRemoteControlPreviousTrack",
                                @(106):@"UIEventSubtypeRemoteControlBeginSeekingBackward",
                                @(107):@"UIEventSubtypeRemoteControlEndSeekingBackward",
                                @(108):@"UIEventSubtypeRemoteControlBeginSeekingForward",
                                @(109):@"UIEventSubtypeRemoteControlEndSeekingForward"};
    
    NSLog(@"%@", typeName[@(event.subtype)]);
//    switch (event.subtype) {
//        case UIEventSubtypeRemoteControlPlay:
//            [self postNotificationWithName:remoteControlPlayButtonTapped];
//            break;
//        case UIEventSubtypeRemoteControlPause:
//            [self postNotificationWithName:remoteControlPauseButtonTapped];
//            break;
//        case UIEventSubtypeRemoteControlStop:
//            [self postNotificationWithName:remoteControlStopButtonTapped];
//            break;
//        case UIEventSubtypeRemoteControlNextTrack:
//            [self postNotificationWithName:remoteControlForwardButtonTapped];
//            break;
//        case UIEventSubtypeRemoteControlPreviousTrack:
//            [self postNotificationWithName:remoteControlBackwardButtonTapped];
//            break;
//        default:
//            [self postNotificationWithName:remoteControlOtherButtonTapped];
//            break;
//    }
}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *str = [NSString stringWithFormat:@"Device Token=%@",deviceToken];
    NSLog(@"%@", str);
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    NSString *str = [NSString stringWithFormat: @"Error: %@", err];
    NSLog(@"%@",str);
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    
    DDLogInfo(@"openURL:%@\noption:%@", url,options);
    
    return YES;
}

//-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
//    
//}
//
//-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
//    
//}
-(NSURL *)getRequestToSubUrl:(NSString *)subUrl parameters:(NSDictionary *)parameterDictionary
{
    //p_userId:用户id
    //p_productType: 产品类型
    //p_terminalType: 终端类型
    //p_appVersion: 软件版本号
    NSMutableDictionary * newDictionary = [NSMutableDictionary dictionaryWithDictionary:parameterDictionary];
//    [newDictionary setObject:@([[AccountManager loggedInUserInfo] uid]) forKey:@"p_userId"];
//    [newDictionary setObject:@(1) forKey:@"p_productType"];
//    [newDictionary setObject:@(3) forKey:@"p_terminalType"];
//    [newDictionary setObject:APP_CURRENT_VERSION forKey:@"p_appVersion"];
    
    parameterDictionary = newDictionary;
    NSString * HTTP_HOST = @"www.somedomain.com";
    NSString *finalUrl;
    if(parameterDictionary)
    {
        
        NSMutableString * urlStr=[NSMutableString stringWithFormat:@"%@/%@?",HTTP_HOST,subUrl];
        if(parameterDictionary)
        {
            [parameterDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                if ([obj isKindOfClass:[NSArray class]]) {
                    //把数组分解为GET请求参数
                    [urlStr appendFormat:@"%@=%@&",key, [(NSArray *)obj componentsJoinedByString:[NSString stringWithFormat:@"&%@=",key]]];
                    
                }else{
                    
                    [urlStr appendFormat:@"%@=%@&",key,obj];
                    
                }
            }];
        }
        finalUrl = [urlStr substringToIndex:urlStr.length-1];
    }
    
    return [NSURL URLWithString:[finalUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
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

#pragma mark - Navigation Controller Delegate
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{

}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if ( [navigationController.navigationBar respondsToSelector:@selector(setBarTintColor:)] )
    {
        // iOS 7
        navigationController.navigationBar.barTintColor = viewController.navigationItem.navigationBarBackgroundColor;
    }
    else
    {
        // iOS 6
        navigationController.navigationBar.tintColor = viewController.navigationItem.navigationBarBackgroundColor;
        // stops the gradient on iOS 6 UINavigationBar
        //            [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    }
}

@end
