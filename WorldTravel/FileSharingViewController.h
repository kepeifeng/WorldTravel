//
//  FileSharingViewController.h
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 1/4/15.
//  Copyright (c) 2015 Kent Peifeng Ke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FileSharingViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
