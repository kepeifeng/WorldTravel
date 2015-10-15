//
//  ChatViewController.m
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 14-5-5.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatTextMessage.h"
#import "ChatMessageCell.h"
@interface ChatViewController ()

@end

@implementation ChatViewController{
    NSMutableArray *messages;
    UIEdgeInsets tableViewContentInset;
}

@synthesize tableView = _tableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    messages = [NSMutableArray new];

    [self registerForKeyboardNotifications];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self loadTestData];
}

-(void)loadTestData{
    
    ChatTextMessage *textMessage;
    textMessage = [[ChatTextMessage alloc]init];
    textMessage.fromUser = @"小明";
    textMessage.text = @"没去上课吗？";
    [messages addObject:textMessage];
    
    textMessage = [[ChatTextMessage alloc]init];
    textMessage.fromUser = @"小明";
    textMessage.text = @"OK？";
    [messages addObject:textMessage];
    
    
    textMessage = [[ChatTextMessage alloc]init];
    textMessage.fromUser = @"小明";
    textMessage.text = @"点名帮我举手";
    [messages addObject:textMessage];
    
    textMessage = [[ChatTextMessage alloc]init];
    textMessage.fromUser = @"小明";
    textMessage.text = @"汉皇重色思倾国，御宇多年求不得。杨家有女初长成，养在深闺人未识。天生丽质难自弃，一朝选在君王侧。回眸一笑百媚生，六宫粉黛无颜色。";
    [messages addObject:textMessage];
    
    
    textMessage = [[ChatTextMessage alloc]init];
    textMessage.fromUser = @"ME";
    textMessage.text = @"没去上课吗？";
    [messages addObject:textMessage];
    
    textMessage = [[ChatTextMessage alloc]init];
    textMessage.fromUser = @"ME";
    textMessage.text = @"Hello";
    [messages addObject:textMessage];
    
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.toolbarHidden = YES;
}

#pragma mark - Text Field

// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWasShown:)
//                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
}


- (void)keyboardWillShow:(NSNotification*)aNotification{
    
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    tableViewContentInset = self.tableView.contentInset;
    UIEdgeInsets contentInsets = tableViewContentInset;
    contentInsets.bottom = kbSize.height;
    self.tableView.contentInset = contentInsets;
    self.tableView.scrollIndicatorInsets = contentInsets;
    
    self.inputViewBottomLayoutConstraint.constant = kbSize.height;
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{

    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
//    CGRect aRect = self.view.frame;
//    aRect.size.height -= kbSize.height;
//    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
//        [self.tableView scrollRectToVisible:activeField.frame animated:YES];
//    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    self.tableView.contentInset = tableViewContentInset;
    self.tableView.scrollIndicatorInsets = tableViewContentInset;
    self.inputViewBottomLayoutConstraint.constant = 0;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatMessage *message = [messages objectAtIndex:indexPath.row];
    ChatMessageCell *cell;
    if([message isKindOfClass:[ChatTextMessage class]]){
        ChatTextMessage *textMessage = (ChatTextMessage *)message;
        static NSString *CellIdentifier = @"ChatMessageCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ChatMessageCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        cell.avatarView.image = [UIImage imageNamed:@"man"];
        cell.messageView.message = textMessage;
        CGSize messageViewSize = cell.messageView.intrinsicContentSize;
        [cell setMessageViewSize:messageViewSize];
        if([message.fromUser isEqualToString:@"ME"]){
            cell.layoutType = ChatViewLayoutTypeRight;
        }else{
            cell.layoutType = ChatViewLayoutTypeLeft;
        }
//        cell.messageHeightConstraint.constant = messageViewSize.height;
//        cell.messageWidthConstraint.constant = messageViewSize.width;
//        [cell.messageView setFrame:CGRectMake(0, 0, messageViewSize.width, messageViewSize.height)];
        
    }
    
    
    
    // Configure the cell...
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    ChatMessage *message = [messages objectAtIndex:indexPath.row];
    CGFloat height = 0;
    if([message isKindOfClass:[ChatTextMessage class]]){
        NSInteger maxWidth = 200;
        UIFont *font = [UIFont systemFontOfSize:14];
        
        CGRect textBounds = [[(ChatTextMessage *)message text] boundingRectWithSize:CGSizeMake(maxWidth, 1500) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil] context:nil];
        
        CGSize size = textBounds.size;
        height = size.height + 10 + 10 + 10;
    }
    
    return height;
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

- (IBAction)sendButtonTapped:(id)sender {
    
    ChatTextMessage *textMessage;
    textMessage = [[ChatTextMessage alloc]init];
    textMessage.fromUser = @"ME";
    textMessage.text = [self.textMessageField.text copy];
    [messages addObject:textMessage];
    
    [self.tableView reloadData];
    
    [self.textMessageField resignFirstResponder];
};
@end
