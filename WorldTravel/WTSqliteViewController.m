//
//  WTSqliteViewController.m
//  WorldTravel
//
//  Created by Kent on 10/21/15.
//  Copyright © 2015 Kent Peifeng Ke. All rights reserved.
//

#import "WTSqliteViewController.h"
#import <FMDB.h>
#import "WTArticleEntity.h"
#import "WTArticleViewController.h"

@interface WTSqliteViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation WTSqliteViewController{

    UITableView * _tableView;
    NSArray * _items;
    FMDatabase * _database;
    
    UISearchController * _searchController;
    BOOL _displayed;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    UISearchBar * searchBar = [[UISearchBar alloc] initWithFrame:(CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 30))];
    
    
    [self loadData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_displayed == NO) {
        _displayed = YES;
        [self restoreIndexPath];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadData{

    NSString * path = [[NSBundle mainBundle] pathForResource:@"tang-poetry" ofType:@"db"];
    _database = [FMDatabase databaseWithPath:path];
    
    if (![_database open]) {
        DDLogInfo(@"Database open failed.");
        return;
    }
    NSString * sql = @"SELECT `D_TITLE`,`D_SHI`,`D_AUTHOR` FROM `T_SHI`  LIMIT 0, 50000;";
    FMResultSet * set = [_database executeQuery:sql];
    
    NSMutableArray * entityArray = [[NSMutableArray alloc] initWithCapacity:100];
    while ([set next]) {
        WTArticleEntity * entity = [[WTArticleEntity alloc] init];
        entity.title = [set stringForColumn:@"D_TITLE"];
        entity.content = [set stringForColumn:@"D_SHI"];
        entity.author = [set stringForColumn:@"D_AUTHOR"];
        
        [entityArray addObject:entity];
    }
    
    _items = entityArray;

}

-(void)restoreIndexPath{
    
    NSInteger row = [[[NSUserDefaults standardUserDefaults] objectForKey:@"tableViewIndexPath"] integerValue];
    
    if (row < _items.count) {
        [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] atScrollPosition:(UITableViewScrollPositionTop) animated:NO];
    }
    
}
-(void)saveCurrentIndexPath{

    CGPoint point = _tableView.contentOffset;
    point.y += _tableView.contentInset.top;
    NSIndexPath * indexPath = [_tableView indexPathForRowAtPoint:point];
    if (indexPath) {
        [[NSUserDefaults standardUserDefaults] setObject:@(indexPath.row) forKey:@"tableViewIndexPath"];
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

    if (decelerate == NO) {
        [self saveCurrentIndexPath];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    NSLog(@"scrollViewDidEndDecelerating");
    [self saveCurrentIndexPath];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _items.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"cell"];
        
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    }
    
    
    WTArticleEntity * entity = _items[indexPath.row];
    cell.textLabel.text = entity.title;
    cell.detailTextLabel.text = entity.content;
    
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WTArticleEntity * entity = _items[indexPath.row];

    WTArticleViewController * articleVC = [[WTArticleViewController alloc] init];
    articleVC.articleEntity = entity;
    
    [self.navigationController pushViewController:articleVC animated:YES];
}

@end


