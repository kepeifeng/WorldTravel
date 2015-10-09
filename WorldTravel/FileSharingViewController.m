//
//  FileSharingViewController.m
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 1/4/15.
//  Copyright (c) 2015 Kent Peifeng Ke. All rights reserved.
//

#import "FileSharingViewController.h"

@interface FileSharingViewController ()

@end

@implementation FileSharingViewController{
    NSArray * files;
    NSString * folderPath;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    folderPath = [[NSBundle mainBundle] pathForResource:@"large" ofType:nil];
    files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:folderPath error:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return files.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    }
    
    
//    cell.imageView.image = [[UIImage alloc] initWithContentsOfFile:[folderPath stringByAppendingPathComponent:[files objectAtIndex:indexPath.row]]];
    cell.textLabel.text = [files objectAtIndex:indexPath.row];
    return cell;
}

-(NSString *)documentFolderPath
{
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [searchPaths lastObject];
    return documentPath;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * filePath = [folderPath stringByAppendingPathComponent:[files objectAtIndex:indexPath.row]];

    NSLog(@"saved");
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
