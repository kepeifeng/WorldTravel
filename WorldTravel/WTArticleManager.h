//
//  WTArticleManager.h
//  WorldTravel
//
//  Created by Kent on 11/2/15.
//  Copyright © 2015 Kent Peifeng Ke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTArticleEntity.h"
@interface WTArticleManager : NSObject
+ (instancetype)sharedManager;

-(NSArray *)allEntity;
-(void)setFav:(BOOL)isFav forEntityId:(NSInteger)entityId;
@end
