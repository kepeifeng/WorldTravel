//
//  ChatMessageCell.m
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 14-5-5.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import "ChatMessageCell.h"

@implementation ChatMessageCell
@synthesize layoutType = _layoutType;

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self setupView];
    }
    return self;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setupView];
    }
    return self;
}

-(void)setupView{
 
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setMessageViewSize:(CGSize)size{
    for (NSLayoutConstraint *constraint in self.messageView.constraints) {
        if(constraint.firstAttribute == NSLayoutAttributeWidth){
            constraint.constant = size.width;
        }else if (constraint.firstAttribute == NSLayoutAttributeHeight){
            constraint.constant = size.height;
        }
    }
}

#pragma mark - Properties

-(ChatViewLayoutType)layoutType{
    return _layoutType;
}

-(void)setLayoutType:(ChatViewLayoutType)layoutType{
    _layoutType = layoutType;
    self.messageView.layoutType = layoutType;
    //TODO:调整位置
    
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.messageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.contentView removeConstraints:self.contentView.constraints];
    switch (layoutType) {
        case ChatViewLayoutTypeLeft:
            //Image Layout
            [self addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarView
                                                             attribute:NSLayoutAttributeLeft
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.contentView
                                                             attribute:NSLayoutAttributeLeft
                                                            multiplier:1
                                                              constant:10]];
            
            [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
            
            //Chat Message View Layout
            [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.messageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.avatarView attribute:NSLayoutAttributeTrailing multiplier:1 constant:10]];
            [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.messageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:10]];
            
             
            break;
            
        case ChatViewLayoutTypeRight:
            
            //Image Layout
            [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:-10]];
            [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
            
            //Chat Message View Layout
            [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.messageView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.avatarView attribute:NSLayoutAttributeLeading multiplier:1 constant:-10]];
            
            [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.messageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:10]];
            
        default:
            break;
    }
}

@end
