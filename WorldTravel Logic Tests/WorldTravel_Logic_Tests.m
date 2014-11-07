//
//  WorldTravel_Logic_Tests.m
//  WorldTravel Logic Tests
//
//  Created by Kent Peifeng Ke on 14-9-4.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface WorldTravel_Logic_Tests : XCTestCase

@end

@implementation WorldTravel_Logic_Tests

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

-(void)testDateCompare{

    NSComparisonResult result;
    NSDate * date1 = nil;
    NSDate * date2 = nil;
    
    result = [self compareBetweenDate:[NSDate date] andDate:nil];
    XCTAssertTrue(result == NSOrderedDescending);
    
    result = [self compareBetweenDate:nil andDate:[NSDate date]];
    XCTAssertTrue(result == NSOrderedAscending);
    
    result = [self compareBetweenDate:[NSDate dateWithTimeIntervalSinceNow:100] andDate:[NSDate date]];
    XCTAssertTrue(result == NSOrderedDescending);
    
    result = [self compareBetweenDate:[NSDate date] andDate:[NSDate dateWithTimeIntervalSinceNow:100]];
    XCTAssertTrue(result == NSOrderedAscending);
    
    result = [self compareBetweenDate:[NSDate date] andDate:[NSDate date]];
    XCTAssertTrue(result == NSOrderedSame);

}

-(NSComparisonResult)compareBetweenDate:(NSDate *)date1 andDate:(NSDate *)date2{
    
    NSComparisonResult result;
    
    if ((date1 == nil && date2 == nil) || (date2 != nil && date1 != nil && [date1 compare:date2] == NSOrderedSame)) {
        result = NSOrderedSame;
    }else if((date1 != nil && date2 == nil) || [date1 compare:date2] == NSOrderedDescending){
        result = NSOrderedDescending;
    }else{
        result = NSOrderedAscending;
    }
    return result;
    
}

@end
