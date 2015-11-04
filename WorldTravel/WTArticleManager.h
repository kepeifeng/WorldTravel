//
//  WTArticleManager.h
//  WorldTravel
//
//  Created by Kent on 11/2/15.
//  Copyright © 2015 Kent Peifeng Ke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTArticleEntity.h"
#import "WTDynastyEntity.h"
@interface WTArticleManager : NSObject
+ (instancetype)sharedManager;

-(NSArray *)allEntity;
-(NSArray *)allDynasty;
-(void)setFav:(BOOL)isFav forEntityId:(NSInteger)entityId;
-(NSArray *)allPoetryOfDynasty:(NSString *)dynasty;

-(NSArray *)searchWithKeyword:(NSString *)keyword;
@end
