//
//  TableViewController.h
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 14-6-27.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
