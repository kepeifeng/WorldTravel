//
//  ChatMessageView.h
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 14-5-6.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatMessage.h"

typedef NS_ENUM(NSUInteger, ChatViewLayoutType){
    ChatViewLayoutTypeLeft,
    ChatViewLayoutTypeRight
    
};

@interface ChatMessageView : UIView

@property (readonly) UIView * contentView;

@property ChatMessage *message;

@property ChatViewLayoutType layoutType;

@end
