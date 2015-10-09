//
//  ChatTextMessageView.m
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 14-5-5.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import "ChatTextMessageView.h"

@implementation ChatTextMessageView{
    UIImageView *imageView;
    UITextView *textView;
    UIEdgeInsets textEdgeInsets;
}

@synthesize message = _message;

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
//    self = [self initWithFrame:CGRectMake(0, 0, 50, 50)];
    if (self) {
        CGRect frame = self.frame;
        [self setupViewWithFrame:frame];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setupViewWithFrame:frame];
        
    }
    return self;
}

-(void)setupViewWithFrame:(CGRect)frame{

    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    
    
    
//    textEdgeInsets = UIEdgeInsetsMake(5, 12, 5, 5);
    textView = [[UITextView alloc] initWithFrame:frame];
    [textView setEditable:NO];
//    [textView setBackgroundColor:[UIColor yellowColor]];
    [textView setSelectable:NO];
    [textView setFont:[UIFont systemFontOfSize:14]];
    [textView setContentInset:UIEdgeInsetsZero];
    textView.textContainer.lineFragmentPadding = 0;
    [textView setContentOffset:CGPointZero];
    [textView setTextContainerInset:UIEdgeInsetsZero];
    
    textView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:textView];
    //Left
    [self addConstraint:[NSLayoutConstraint constraintWithItem:textView
                                                     attribute:NSLayoutAttributeLeft
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeLeft
                                                    multiplier:1
                                                      constant:0]];
    //Right
    [self addConstraint:[NSLayoutConstraint constraintWithItem:textView
                                                     attribute:NSLayoutAttributeRight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeRight
                                                    multiplier:1
                                                      constant:0]];
    //Top
    [self addConstraint:[NSLayoutConstraint constraintWithItem:textView
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1
                                                      constant:0]];
    //Bottom
    [self addConstraint:[NSLayoutConstraint constraintWithItem:textView
                                                     attribute:NSLayoutAttributeBottom
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeBottom
                                                    multiplier:1
                                                      constant:0]];
    

}




-(ChatTextMessage *)message{
    return _message;
}

-(void)setMessage:(ChatTextMessage *)message{

    _message = message;
    textView.text = message.text;
    
}

-(CGSize)intrinsicContentSize{
    NSInteger maxWidth = 200;
    UIFont *font = [UIFont systemFontOfSize:14];
    
    CGRect textBounds = [self.message.text boundingRectWithSize:CGSizeMake(maxWidth, 1500) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil] context:nil];
    
    CGSize size = textBounds.size;
    
//    size.width += textEdgeInsets.left+textEdgeInsets.right;
//    size.height += textEdgeInsets.top + textEdgeInsets.bottom;
    
    return size;
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
