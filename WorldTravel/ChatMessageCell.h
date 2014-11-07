//
//  ChatMessageCell.h
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 14-5-5.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatMessageView.h"

@interface ChatMessageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatarView;
@property (strong, nonatomic) IBOutlet ChatMessageView *messageView;
@property ChatViewLayoutType layoutType;


-(void)setMessageViewSize:(CGSize)size;
@end
