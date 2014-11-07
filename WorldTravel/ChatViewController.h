//
//  ChatViewController.h
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 14-5-5.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import <UIKit/UIKit.h>





@interface ChatViewController : UIViewController<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UITextField *textMessageField;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UIView *inputView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputViewBottomLayoutConstraint;


- (IBAction)sendButtonTapped:(id)sender;

@end
