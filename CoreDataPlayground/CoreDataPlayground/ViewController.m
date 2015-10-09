//
//  ViewController.m
//  CoreDataPlayground
//
//  Created by Kent Peifeng Ke on 1/13/15.
//  Copyright (c) 2015 Kent Peifeng Ke. All rights reserved.
//

#import "ViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "DBBook.h"
@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) UITableView * tableView;
@end

@implementation ViewController{

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UITableView * tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    self.tableView = tableView;

    [self searchKeyword:@"imac"];
//    [self refreshTableView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(addButtonTapped:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)searchKeyword:(NSString *)keyword{
    NSManagedObjectContext *moc = [self managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Book" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    // Set example predicate and sort orderings...

    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"(name contains[cd] %@)", keyword];
    [request setPredicate:predicate];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"name" ascending:YES];
    [request setSortDescriptors:@[sortDescriptor]];
    
    NSError *error;
    NSArray *array = [moc executeFetchRequest:request error:&error];
    NSMutableArray * books = [NSMutableArray new];
    for (NSManagedObject *info in array) {
        
        DBBook* book = [[DBBook alloc] init];
        book.bookid = [[info valueForKey:@"bookid"] integerValue];
        book.name = [info valueForKey:@"name"];
        
        NSManagedObject *details = [info valueForKey:@"author"];
        DBAuthor * author = [[DBAuthor alloc] init];
        author.authorId = [[details valueForKey:@"authorid"] integerValue];
        author.name = [details valueForKey:@"name"];
        book.author = author;
        
        [books addObject:book];
    }
    _books = books;
    [self.tableView reloadData];

}
-(void)refreshTableView{
    

    NSManagedObjectContext * context = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Book" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError * error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    NSMutableArray * books = [NSMutableArray new];
    for (NSManagedObject *info in fetchedObjects) {
        
        DBBook* book = [[DBBook alloc] init];
        book.bookid = [[info valueForKey:@"bookid"] integerValue];
        book.name = [info valueForKey:@"name"];
        
        NSManagedObject *details = [info valueForKey:@"author"];
        DBAuthor * author = [[DBAuthor alloc] init];
        author.authorId = [[details valueForKey:@"authorid"] integerValue];
        author.name = [details valueForKey:@"name"];
        book.author = author;
        
        [books addObject:book];
    }
    _books = books;
    [self.tableView reloadData];
}
-(void)addButtonTapped:(id)sender{

    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"New Book" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Book Name";
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Author Name";
    }];
    
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
        
    }];
    
    UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"Ok" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        NSString * bookName = [(UITextField *)[alertController.textFields objectAtIndex:0] text];
        NSString * authorName = [(UITextField *)[alertController.textFields objectAtIndex:1] text];
        [self createNewBookWithBookName:bookName andAuthorName:authorName];
        [self refreshTableView];
    }];;
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
//    [alertController addAction:];
    
    
}

-(NSManagedObject *)authorObjectWithName:(NSString *)name{

    NSManagedObjectContext * context = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Author" inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"name LIKE[cd] %@", name];
    [fetchRequest setPredicate:predicate];
    
    NSError * error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    return [fetchedObjects firstObject];
}

-(void)createNewBookWithBookName:(NSString *)bookName andAuthorName:(NSString *)authorName{

    NSManagedObjectContext * context = [self managedObjectContext];
    NSManagedObject * book = [NSEntityDescription insertNewObjectForEntityForName:@"Book" inManagedObjectContext:context];
    [book setValue:@(10) forKey:@"bookid"];
    [book setValue:bookName forKey:@"name"];
    
    //    NSManagedObject *failedBankInfo = [NSEntityDescription
    //                                       insertNewObjectForEntityForName:@"FailedBankInfo"
    //                                       inManagedObjectContext:context];
    //    [failedBankInfo setValue:@"Test Bank" forKey:@"name"];
    //    [failedBankInfo setValue:@"Testville" forKey:@"city"];
    //    [failedBankInfo setValue:@"Testland" forKey:@"state"];
    
    NSManagedObject * author = [self authorObjectWithName:authorName];
    if (!author) {
        author = [NSEntityDescription insertNewObjectForEntityForName:@"Author" inManagedObjectContext:context];
        [author setValue:@(1) forKey:@"authorid"];
        [author setValue:authorName forKey:@"name"];
    }
    
    
    //    NSManagedObject *failedBankDetails = [NSEntityDescription
    //                                          insertNewObjectForEntityForName:@"FailedBankDetails"
    //                                          inManagedObjectContext:context];
    //    [failedBankDetails setValue:[NSDate date] forKey:@"closeDate"];
    //    [failedBankDetails setValue:[NSDate date] forKey:@"updateDate"];
    //    [failedBankDetails setValue:[NSNumber numberWithInt:12345] forKey:@"zip"];
    //    [failedBankDetails setValue:failedBankInfo forKey:@"info"];
    
    [book setValue:author forKey:@"author"];
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }

}

-(NSManagedObjectContext *)managedObjectContext{
//    [(AppDelegate *)]
    return [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _books.count;
}
-(DBBook *)bookAtIndexPath:(NSIndexPath *)indexPath{

    return (DBBook *)[_books objectAtIndex:indexPath.row];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"cell"];
        
    }
    DBBook * book = [self bookAtIndexPath:indexPath];
    
    cell.textLabel.text = book.name;
    cell.detailTextLabel.text = book.author.name;
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DBBook * book = [self bookAtIndexPath:indexPath];
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"Edit Book" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        
        textField.text = book.name;
        
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.text = book.author.name;
    }];
    
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
        
    }];
    
    UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"Save" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        
    }];
    
    
    UIAlertAction * deleteAction = [UIAlertAction actionWithTitle:@"Delete" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction *action) {
        
    }];;
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [alertController addAction:deleteAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


@end
