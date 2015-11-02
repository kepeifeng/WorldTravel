//
//  WTArticleManager.m
//  WorldTravel
//
//  Created by Kent on 11/2/15.
//  Copyright © 2015 Kent Peifeng Ke. All rights reserved.
//

#import "WTArticleManager.h"
#import <FMDB.h>
#import "NSFileManager+Utility.h"
@implementation WTArticleManager{
    
    FMDatabase * _database;
}


+ (instancetype)sharedManager
{
    static dispatch_once_t onceQueue;
    static WTArticleManager *gArticleManager = nil;
    
    dispatch_once(&onceQueue, ^{ gArticleManager = [[self alloc] init]; });
    return gArticleManager;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSString * dbCopyPath = [[[NSFileManager defaultManager] supportFolderPath] stringByAppendingPathComponent:@"tang-poetry.db"];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:dbCopyPath] == NO) {
            
            NSString * path = [[NSBundle mainBundle] pathForResource:@"tang-poetry" ofType:@"db"];
            NSError * error;
            [[NSFileManager defaultManager] copyItemAtPath:path toPath:dbCopyPath error:&error];
            if (error) {
                NSLog(@"Copy Database failed: %@", error);
            }
            
        }
        
        _database = [FMDatabase databaseWithPath:dbCopyPath];

        
        if (![_database openWithFlags:SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE]) {
            DDLogInfo(@"Database open failed.");
            return nil;
        }
        
//        [self clear];
    }
    return self;
}
-(NSArray *)allEntity{
    
    NSString * sql = @"SELECT * FROM `T_SHI`  LIMIT 0, 50000;";
    FMResultSet * set = [_database executeQuery:sql];
    
    NSMutableArray * entityArray = [[NSMutableArray alloc] initWithCapacity:100];
    while ([set next]) {
        WTArticleEntity * entity = [[WTArticleEntity alloc] init];
        entity.entityId = [set intForColumn:@"D_ID"];
        entity.title = [set stringForColumn:@"D_TITLE"];
        entity.content = [set stringForColumn:@"D_SHI"];
        entity.author = [set stringForColumn:@"D_AUTHOR"];
        entity.fav = [set intForColumn:@"D_FAV"];
        entity.summary = [set stringForColumn:@"D_INTROSHI"];
        [entityArray addObject:entity];
    }
    
    return entityArray;
    
}

-(void)clear{
    NSString * sql = @"update t_shi set d_introshi = replace(d_introshi,'','')";
    [_database executeUpdate:sql];
}

-(void)setFav:(BOOL)isFav forEntityId:(NSInteger)entityId{

    NSString * sql = [NSString stringWithFormat:@"UPDATE `T_SHI` SET `D_FAV`=%d WHERE `D_ID`='%d';", isFav, entityId];
    [_database executeUpdate:sql];
}



@end
