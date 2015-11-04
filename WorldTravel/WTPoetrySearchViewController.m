//
//  WTPoetrySearchViewController.m
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 15/11/3.
//  Copyright © 2015年 Kent Peifeng Ke. All rights reserved.
//

#import "WTPoetrySearchViewController.h"
#import "WTArticleManager.h"
#import "WTArticleViewController.h"

@interface WTPoetrySearchViewController ()<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@end

@implementation WTPoetrySearchViewController{

    UITableView * _tableView;
    NSArray * _items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UISearchBar * searchBar = [[UISearchBar alloc] initWithFrame:(CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 44))];
    searchBar.delegate = self;
//    [self.view addSubview:searchBar];
    self.navigationItem.titleView = searchBar;
    
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    //    articleVC.articleEntity = entity;
    articleVC.entityArray = _items;
    articleVC.defaultIndex = indexPath.row;
    
    [self.navigationController pushViewController:articleVC animated:YES];
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{

    [searchBar resignFirstResponder];
    
    _items = [[WTArticleManager sharedManager] searchWithKeyword:searchBar.text];
    [_tableView reloadData];
}
@end
