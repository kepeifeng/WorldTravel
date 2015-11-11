//
//  WTVerticalTextView.h
//  WorldTravel
//
//  Created by Kent on 10/30/15.
//  Copyright © 2015 Kent Peifeng Ke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTVerticalTextView : UIView{
    NSAttributedString * _attributedText;
}
@property (nonatomic, strong) NSString * text;
@property (nonatomic, strong) NSAttributedString * attributedText;
@property (nonatomic, copy) UIFont * font;
@property (nonatomic, assign) CGFloat minimumLineHeight;


-(void)updateAttributedString;

@end
