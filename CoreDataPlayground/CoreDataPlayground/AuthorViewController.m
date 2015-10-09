//
//  AuthorViewController.m
//  CoreDataPlayground
//
//  Created by Kent Peifeng Ke on 1/13/15.
//  Copyright (c) 2015 Kent Peifeng Ke. All rights reserved.
//

#import "AuthorViewController.h"
#import <CoreData/CoreData.h>
#import "DBBook.h"
#import "AppDelegate.h"

@interface AuthorViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) UITableView * tableView;
@end

@implementation AuthorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITableView * tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    self.tableView = tableView;

    [self refreshTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)refreshTableView{
    
    
    NSManagedObjectContext * context = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Author" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError * error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    NSMutableArray * authors = [NSMutableArray new];
    for (NSManagedObject *info in fetchedObjects) {
        
//        DBBook* book = [[DBBook alloc] init];
//        book.bookid = [[info valueForKey:@"bookid"] integerValue];
//        book.name = [info valueForKey:@"name"];
        
//        NSManagedObject *details = [info valueForKey:@"author"];
        DBAuthor * author = [[DBAuthor alloc] init];
        author.authorId = [[info valueForKey:@"authorid"] integerValue];
        author.name = [info valueForKey:@"name"];
        
        [authors addObject:author];
    }
    _authors = authors;
    [self.tableView reloadData];
}

-(NSManagedObjectContext *)managedObjectContext{
    return [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _authors.count;
}
-(DBAuthor *)authorAtIndexPath:(NSIndexPath *)indexPath{
    
    return (DBAuthor *)[_authors objectAtIndex:indexPath.row];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"cell"];
        
    }
    DBAuthor * author = [self authorAtIndexPath:indexPath];
    
    cell.textLabel.text = author.name;
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
