//
//  DBBook.h
//  CoreDataPlayground
//
//  Created by Kent Peifeng Ke on 1/13/15.
//  Copyright (c) 2015 Kent Peifeng Ke. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DBAuthor : NSObject
@property NSInteger authorId;
@property NSString * name;

@end
@interface DBBook : NSObject

@property NSInteger bookid;
@property NSString * name;
@property DBAuthor * author;
@end
