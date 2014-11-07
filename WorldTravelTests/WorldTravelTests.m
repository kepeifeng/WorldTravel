//
//  WorldTravelTests.m
//  WorldTravelTests
//
//  Created by Kent Peifeng Ke on 14-5-5.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TableViewController.h"
#import "AppDelegate.h"
#import "SomeClass+CategoryA.h"
#import "SomeClass+CategoryB.h"
#import "RotateImageViewController.h"
#import "CircleButtonViewController.h"
#import "CollectionViewController.h"

@interface WorldTravelTests : XCTestCase

@end

@implementation WorldTravelTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}
-(void)presentViewControllerInNavigationController:(UIViewController *)viewController{
    
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:viewController];
    navigationController.navigationBar.translucent = NO;
    
    [kAppDelegate.window.rootViewController presentViewController:navigationController animated:YES completion:NULL];
    
    [[NSRunLoop mainRunLoop] run];
}

-(void)testTableView{
    TableViewController * tableViewController = [[TableViewController alloc] init];
    [self presentViewControllerInNavigationController:tableViewController];
}

-(void)testCategory{
    SomeClass * someClass = [SomeClass new];
    [someClass printA];
    [someClass printB];
}

-(void)testRotateImageViewController{

    RotateImageViewController * viewController = [[RotateImageViewController alloc] init];
    [self presentViewControllerInNavigationController:viewController];

}



-(void)testCircleButtonViewController{
    
    CircleButtonViewController * viewController = [[CircleButtonViewController alloc] init];
    [self presentViewControllerInNavigationController:viewController];
    
}

-(void)testCollectionView{
    CollectionViewController * viewController = [[CollectionViewController alloc] init];
    [self presentViewControllerInNavigationController:viewController];
    
}

-(void)testProperty{
    SomeClass * someClass = [SomeClass new];
    someClass.description = @"Hi";
    NSLog(@"%@",someClass.description);
}

-(void)testAttributeString{

    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"长江后浪推前浪前浪死在沙滩上"];
    
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = [UIImage imageNamed:@"man"];
    
    NSAttributedString *attrStringWithImage = [NSAttributedString attributedStringWithAttachment:textAttachment];
    
    [attributedString appendAttributedString:attrStringWithImage];
    [attributedString appendAttributedString:[[NSAttributedString alloc]initWithString:@"长江后浪推前浪前浪死在沙滩上"]];
    
    UILabel * label = [[UILabel alloc]init];
    
    [attributedString addAttributes:@{NSFontAttributeName:label.font} range:NSMakeRange(0, attributedString.length)];
    CGRect rect = [attributedString boundingRectWithSize:CGSizeMake(80, 1000) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
}

@end
