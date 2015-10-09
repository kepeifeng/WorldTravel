//
//  SimpleViewController.h
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 1/10/15.
//  Copyright (c) 2015 Kent Peifeng Ke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleViewController : UIViewController

@property (nonatomic) UIColor * backgroundColor;
@property (nonatomic) NSString * text;
@property (weak, nonatomic) IBOutlet UILabel *label;
@end
