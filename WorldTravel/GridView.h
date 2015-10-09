//
//  GridView.h
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 1/5/15.
//  Copyright (c) 2015 Kent Peifeng Ke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GridView : UIView

-(instancetype)initWithFrame:(CGRect)frame rows:(NSInteger)rows columns:(NSInteger)columns;
@property (nonatomic, readonly) NSInteger rows;
@property (nonatomic, readonly) NSInteger columns;
@end
