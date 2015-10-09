//
//  SharedLabel.h
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 1/19/15.
//  Copyright (c) 2015 Kent Peifeng Ke. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LabelStatus;
@interface SharedLabel : UIView



@property (nonatomic, copy) NSString * text;
@property (nonatomic, copy) UIColor * backgroundColor;

//-(void)saveStatusForKey:(id)key;
//-(void)restoreStatusForKey:(id)key;
//
//-(void)removeKey:(id)key;

-(void)viewDidAppear;
-(void)viewDidDisappear;


@end

//@interface LabelStatus : NSObject<NSCopying>
//
//@property (nonatomic, strong) NSString * text;
//@property (nonatomic, strong) UIColor * backgroundColor;
////@property (nonatomic) CGRect frame;
//
//+(instancetype)defaultStatus;
//@end

//@interface SharedLabelManager : NSObject
//+(instancetype)defaultManager;
//-(void)saveLabelStatus:(SharedLabel *)label forKey:(id)key;
//-(void)restoreLabelStatus:(SharedLabel *)label forKey:(id)key;
//@end