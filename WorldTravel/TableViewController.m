//
//  TableViewController.m
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 14-6-27.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"

@interface TableViewController ()

@end

@implementation TableViewController{
    NSIndexPath * _currentIndexPath;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table View Delegate & Data Souce

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else if(section == 1){
        return 2;
    }else{
        return 15;
    }
    
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell = [[[NSBundle mainBundle]loadNibNamed:@"TableViewCell" owner:nil options:nil] firstObject];
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [button setTitle:@"Go" forState:(UIControlStateNormal)];
        button.titleLabel.textColor = [UIColor blueColor];
        cell.accessoryView = button;
        
    }
    
    cell.textLabel.text =[NSString stringWithFormat:@"Section %d, Row %d", indexPath.section, indexPath.row];
    
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return (indexPath.row+1)*20;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.y > 100) {
        CGPoint point = scrollView.contentOffset;
        point.y += 50;
        NSIndexPath * indexPath = [_tableView indexPathForRowAtPoint:point];
        if ([indexPath compare:_currentIndexPath] != NSOrderedSame) {
            NSLog(@"%@",indexPath);
            _currentIndexPath = indexPath;
        }
    }
}

@end
