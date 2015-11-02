//
//  WTArticleView.m
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 15/10/31.
//  Copyright © 2015年 Kent Peifeng Ke. All rights reserved.
//

#import "WTArticleView.h"

@implementation WTArticleView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialSetup];
    }
    return self;
}

-(void)initialSetup{

    _titleView = [[WTVerticalTextView alloc] init];
    _titleView.font = [UIFont fontWithName:@"MingLiU" size:24];
//    _titleView.backgroundColor = [UIColor redColor];
    [self addSubview:_titleView];
    
    _authorLabel = [[WTVerticalTextView alloc] init];
    _authorLabel.font = [UIFont fontWithName:@"MingLiU" size:18];
//    _authorLabel.backgroundColor = [UIColor yellowColor];
    [self addSubview:_authorLabel];
    
    _contentLabel = [[WTVerticalTextView alloc] init];
    _contentLabel.font = [UIFont fontWithName:@"MingLiU" size:18];
//    _contentLabel.backgroundColor = [UIColor blueColor];
    [self addSubview:_contentLabel];

}

-(void)didMoveToWindow{
    [super didMoveToWindow];
    
    //Need no NSStringDrawingUsesLineFragmentOrigin

    CGRect titleRect = [_titleView.attributedText boundingRectWithSize:CGSizeMake(CGRectGetHeight(self.bounds), 9999)
                                                               options:(NSStringDrawingUsesLineFragmentOrigin)
                                                               context:nil];
    _titleView.frame = CGRectMake(0, 0, CGRectGetHeight(titleRect), CGRectGetWidth(titleRect));

    CGRect authorRect = [_authorLabel.attributedText boundingRectWithSize:CGSizeMake(CGRectGetHeight(self.bounds), 9999)
                                                                  options:(NSStringDrawingUsesLineFragmentOrigin)
                                                                  context:nil];

    _authorLabel.frame = CGRectMake(CGRectGetMaxX(_titleView.frame), 0, CGRectGetHeight(authorRect), CGRectGetWidth(authorRect));

    CGRect contentRect = [_contentLabel.attributedText boundingRectWithSize:CGSizeMake(CGRectGetHeight(self.bounds), 9999)
                                                                    options:(NSStringDrawingUsesLineFragmentOrigin)
                                                                    context:nil];


    _contentLabel.frame = CGRectMake(CGRectGetMaxX(_authorLabel.frame)+20, 0, CGRectGetHeight(contentRect), CGRectGetWidth(contentRect));

    NSArray * views = @[_titleView, _authorLabel, _contentLabel];
    CGFloat width = MAX(CGRectGetMaxX(_contentLabel.frame), CGRectGetWidth(self.bounds) - self.contentInset.right);
    self.contentSize = CGSizeMake(width, CGRectGetHeight(self.bounds));
    //反向排列
    for (UIView * view in views) {
        CGRect frame = view.frame;
        frame.origin.x = width - CGRectGetMaxX(frame);
        view.frame = frame;
    }

    self.contentOffset = CGPointMake(width - CGRectGetWidth(self.bounds) + self.contentInset.right, -self.contentInset.top);

}

-(void)layoutSubviews{

    [super layoutSubviews];
    
//    NSLog(@"layoutSubviews");
  
}
@end
