//
//  SomeClass+CategoryB.m
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 14-7-21.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import "SomeClass+CategoryB.h"

@implementation SomeClass (CategoryB)
-(void)printB{
    [self print];
}

-(void)print{

    NSLog(@"Category B");
}
@end
