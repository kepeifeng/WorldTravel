//
//  SomeClass+CategoryA.m
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 14-7-21.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import "SomeClass+CategoryA.h"

@implementation SomeClass (CategoryA)
-(void)printA{
    [self print];
}

-(void)print{
    NSLog(@"Category A");
}
@end
