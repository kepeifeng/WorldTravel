//
//  MainViewController.m
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 14/11/7.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (instancetype)init
{
    self = [super initWithRoot:[[QRootElement alloc] init]];
    if (self) {
        self.title = @"iOS Playground";
        [self setupRootElement];
    }
    return self;
}

-(void)setupRootElement{

    QRootElement * root = self.root;
    QAppearance * appearance = [root.appearance copy];
    appearance.labelFont = [UIFont fontWithName:@"Avenir-Book" size:14];
    appearance.valueFont = appearance.labelFont;
    appearance.entryFont = appearance.labelFont;
    root.appearance = appearance;
    
    QSection * section = [[QSection alloc] init];
    [root addSection:section];
    
    [section addElement:[self labelElementWithTitle:@"Round Button" viewControllerName:@"CircleButtonViewController"]];
    [section addElement:[self labelElementWithTitle:@"Chat" viewControllerName:@"ChatViewController"]];
    [section addElement:[self labelElementWithTitle:@"Table" viewControllerName:@"TableViewController"]];
    [section addElement:[self labelElementWithTitle:@"Map" viewControllerName:@"MapViewController"]];
    [section addElement:[self labelElementWithTitle:@"Rotate Image" viewControllerName:@"RotateImageViewController"]];
    [section addElement:[self labelElementWithTitle:@"Collection" viewControllerName:@"CollectionViewController"]];
    [section addElement:[self labelElementWithTitle:@"Animation" viewControllerName:@"AnimationViewController"]];
    [section addElement:[self labelElementWithTitle:@"Map II" viewControllerName:@"ViewController"]];
    
    
    [self.quickDialogTableView reloadData];

    
}

-(QLabelElement *)labelElementWithTitle:(NSString *)title viewControllerName:(NSString *)viewControllerName{
    
    QLabelElement * label = [[QLabelElement alloc] initWithTitle:title Value:nil];
    label.controllerAction = @"labelElementHandler:";
    label.key = viewControllerName;
    label.keepSelected = NO;
    label.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return label;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)labelElementHandler:(QLabelElement *)element{

    NSString * viewControllerName = element.key;
    if (viewControllerName.length == 0) {
        return;
    }
    
    Class viewControllerClass = NSClassFromString(viewControllerName);
    UIViewController * viewController = [[viewControllerClass alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
    
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
