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
        
        NSString * dbFilename = @"tang-poetry-1.db";
        
        NSString * dbCopyPath = [[[NSFileManager defaultManager] supportFolderPath] stringByAppendingPathComponent:dbFilename];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:dbCopyPath] == NO) {
            
            NSString * path = [[NSBundle mainBundle] pathForResource:dbFilename ofType:nil];
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
        
        [self clear];
    }
    return self;
}
-(NSArray *)allEntity{
    
    NSString * sql = @"SELECT * FROM `T_SHI`  LIMIT 0, 50000;";
    FMResultSet * set = [_database executeQuery:sql];
    
    return [self entitiesFromResultSet:set];
    
}

-(NSArray *)entitiesFromResultSet:(FMResultSet *)set{

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

-(NSArray *)allDynasty{

    NSString * sql = @"SELECT * FROM T_DYNASTY;";
    FMResultSet * result = [_database executeQuery:sql];
    NSMutableArray * entityArray = [[NSMutableArray alloc] init];
    
    while ([result next]) {
        WTDynastyEntity * dynasty = [[WTDynastyEntity alloc] init];
        dynasty.title = [result stringForColumn:@"d_dynasty"];
        dynasty.entityId = [result intForColumn:@"d_num"];
        dynasty.desc = [result stringForColumn:@"d_intro"];
        
        [entityArray addObject:dynasty];
    }
    
    return entityArray;
}

-(NSArray *)allPoetryOfDynasty:(NSString *)dynasty{
    //D_SHI, t_shi.D_AUTHOR, t_author.d_dynasty
    NSString * sql = [NSString stringWithFormat:@"select * from (t_shi join t_author on t_shi.d_author = t_author.d_author) where t_author.d_dynasty = '%@'", dynasty];
    FMResultSet * set = [_database executeQuery:sql];
    return [self entitiesFromResultSet:set];
    
}

-(NSArray *)searchWithKeyword:(NSString *)keyword{

    NSString * sql = [NSString stringWithFormat:@"select * from t_shi where d_author like '%%%@%%' or d_shi like '%%%@%%'", keyword, keyword];
    FMResultSet * set = [_database executeQuery:sql];
    return [self entitiesFromResultSet:set];

}

-(void)clear{
    NSArray  *allEntity = [self allEntity];
    
    NSInteger titleCount = 0;
    NSInteger bodyCount = 0;
    
    for (WTArticleEntity * entity in allEntity) {
        NSError * error;
        NSRegularExpression * exp = [NSRegularExpression regularExpressionWithPattern:@"[\\(（][^\\)）]+[\\)）]" options:(0) error:&error];
        NSMutableString * newTitle = [entity.title mutableCopy];
        titleCount += [exp replaceMatchesInString:newTitle options:0 range:(NSMakeRange(0, entity.title.length)) withTemplate:@""];
        entity.title = newTitle;
        
        
        NSRegularExpression * bodyExp = [NSRegularExpression regularExpressionWithPattern:@"【.+\\s+" options:0 error:&error];
        NSMutableString * newBody = [entity.content mutableCopy];
        bodyCount += [bodyExp replaceMatchesInString:newBody options:0 range:(NSMakeRange(0, newBody.length)) withTemplate:@""];
        entity.content = newBody;
    }
    
    NSLog(@"Title Count: %d, Body Count: %d", titleCount ,bodyCount);
}

-(void)setFav:(BOOL)isFav forEntityId:(NSInteger)entityId{

    NSString * sql = [NSString stringWithFormat:@"UPDATE `T_SHI` SET `D_FAV`=%d WHERE `D_ID`='%d';", isFav, entityId];
    [_database executeUpdate:sql];
}



@end
