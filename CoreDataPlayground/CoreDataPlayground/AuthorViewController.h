//
//  AuthorViewController.h
//  CoreDataPlayground
//
//  Created by Kent Peifeng Ke on 1/13/15.
//  Copyright (c) 2015 Kent Peifeng Ke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthorViewController : UIViewController{
    NSArray * _authors;
}
@property (readonly) NSManagedObjectContext * managedObjectContext;

-(void)refreshTableView;
@end
