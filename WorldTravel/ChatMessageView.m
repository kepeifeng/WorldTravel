//
//  ChatMessageView.m
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 14-5-6.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import "ChatMessageView.h"
#import "ChatTextMessage.h"
#import "ChatTextMessageView.h"

@implementation ChatMessageView{
    UIEdgeInsets contentEdgeInsets;
    UIImageView *imageView;
    UIEdgeInsets leftResizableImageInsets,rightResizableImageInsets;

    
}

@synthesize message = _message;
@synthesize contentView = _contentView;
@synthesize layoutType = _layoutType;

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        CGRect frame = self.frame;
        [self setupSubviewWithFrame:frame];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setupSubviewWithFrame:frame];
    }
    return self;
}

-(void)setupSubviewWithFrame:(CGRect)frame{
    
    imageView = [[UIImageView alloc] initWithFrame:frame];
    leftResizableImageInsets = UIEdgeInsetsMake(12, 18, 12, 12);
    rightResizableImageInsets = UIEdgeInsetsMake(12, 12, 12, 18);
    
    contentEdgeInsets = UIEdgeInsetsMake(5, 12, 5, 5);
    
    imageView.image = [[UIImage imageNamed:@"bg_chat_text_left"] resizableImageWithCapInsets:leftResizableImageInsets];
    
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:imageView];
    
    //设置
    [[self class] addEdgeConstraint:NSLayoutAttributeLeft superview:self subview:imageView];
    [[self class] addEdgeConstraint:NSLayoutAttributeRight superview:self subview:imageView];
    [[self class] addEdgeConstraint:NSLayoutAttributeTop superview:self subview:imageView];
    [[self class] addEdgeConstraint:NSLayoutAttributeBottom superview:self subview:imageView];
    
    
}

+ (void)addEdgeConstraint:(NSLayoutAttribute)edge superview:(UIView *)superview subview:(UIView *)subview {
    [superview addConstraint:[NSLayoutConstraint constraintWithItem:subview
                                                          attribute:edge
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:superview
                                                          attribute:edge
                                                         multiplier:1
                                                           constant:0]];
}

#pragma mark - Properties

-(ChatMessage *)message{
    return _message;
}

-(void)setMessage:(ChatMessage *)chatMessage{
    _message = chatMessage;
    
    if([chatMessage isKindOfClass:[ChatTextMessage class]]){
        [self addTextMessageViewFor:(ChatTextMessage *)chatMessage];
    }
    
}

-(ChatViewLayoutType)layoutType{
    return _layoutType;
}

-(void)setLayoutType:(ChatViewLayoutType)layoutType{
    _layoutType = layoutType;
    switch (layoutType) {
        case ChatViewLayoutTypeLeft:
            imageView.image = [[UIImage imageNamed:@"bg_chat_text_left"] resizableImageWithCapInsets:leftResizableImageInsets];
            contentEdgeInsets = UIEdgeInsetsMake(5, 12, 5, 5);

            break;
        case ChatViewLayoutTypeRight:
            imageView.image = [[UIImage imageNamed:@"bg_chat_text_right"] resizableImageWithCapInsets:rightResizableImageInsets];
            contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 12);
            
        default:
            break;
    }
    
    [self removeConstraints:self.constraints];
    
    //Left
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_contentView
                                                     attribute:NSLayoutAttributeLeft
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeLeft
                                                    multiplier:1
                                                      constant:contentEdgeInsets.left]];
    //Right
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_contentView
                                                     attribute:NSLayoutAttributeRight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeRight
                                                    multiplier:1
                                                      constant:-contentEdgeInsets.right]];
    //Top
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_contentView
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1
                                                      constant:contentEdgeInsets.top]];
    //Bottom
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_contentView
                                                     attribute:NSLayoutAttributeBottom
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeBottom
                                                    multiplier:1
                                                      constant:-contentEdgeInsets.bottom]];
    
    //设置
    [[self class] addEdgeConstraint:NSLayoutAttributeLeft superview:self subview:imageView];
    [[self class] addEdgeConstraint:NSLayoutAttributeRight superview:self subview:imageView];
    [[self class] addEdgeConstraint:NSLayoutAttributeTop superview:self subview:imageView];
    [[self class] addEdgeConstraint:NSLayoutAttributeBottom superview:self subview:imageView];
}

-(void)addTextMessageViewFor:(ChatTextMessage *)chatMessage{

    ChatTextMessageView *chatTextMessageView = [[ChatTextMessageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    chatTextMessageView.message = chatMessage;
    
    [self setContentView:chatTextMessageView];
    
    
}
-(UIView *)contentView{
    return _contentView;
}
-(void)setContentView:(UIView *)contentView{
    if(_contentView && _contentView.superview == self){
        [self.contentView removeFromSuperview];
    }
    
    _contentView = contentView;
    [self addSubview:contentView];
    
    
    //Left
    [self addConstraint:[NSLayoutConstraint constraintWithItem:contentView
                                                     attribute:NSLayoutAttributeLeft
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeLeft
                                                    multiplier:1
                                                      constant:contentEdgeInsets.left]];
    //Right
    [self addConstraint:[NSLayoutConstraint constraintWithItem:contentView
                                                     attribute:NSLayoutAttributeRight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeRight
                                                    multiplier:1
                                                      constant:-contentEdgeInsets.right]];
    //Top
    [self addConstraint:[NSLayoutConstraint constraintWithItem:contentView
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1
                                                      constant:contentEdgeInsets.top]];
    //Bottom
    [self addConstraint:[NSLayoutConstraint constraintWithItem:contentView
                                                     attribute:NSLayoutAttributeBottom
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeBottom
                                                    multiplier:1
                                                      constant:-contentEdgeInsets.bottom]];
    
    
}



#pragma mark - View

-(CGSize)intrinsicContentSize{
    CGSize size = [self.contentView intrinsicContentSize];
    size.height += contentEdgeInsets.top + contentEdgeInsets.bottom;
    size.width += contentEdgeInsets.left + contentEdgeInsets.right;
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
