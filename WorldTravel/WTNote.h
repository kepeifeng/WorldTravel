//
//  WTNote.h
//  WorldTravel
//
//  Created by Kent on 11/5/15.
//  Copyright © 2015 Kent Peifeng Ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WTNote : NSObject
@property (nonatomic) NSRange range;
@property (nonatomic) NSInteger index;
@property (nonatomic) NSString * itemName;//如: 锱铢
@property (nonatomic) NSString * title;//如: 锱铢(zizhu)
@property (nonatomic) NSString * detail;
@end
