//
//  MainViewController.m
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 14/11/7.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import "MainViewController.h"
#import "DetailViewManager.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (instancetype)init
{
    self = [super initWithRoot:[[QRootElement alloc] init]];
    if (self) {
        [self setupRootElement];
    }
    return self;
}

-(void)setupRootElement{

    QRootElement * root = self.root;
    root.title = @"iOS Playground";
    root.grouped = YES;
    QAppearance * appearance = [root.appearance copy];
    appearance.labelFont = [UIFont fontWithName:@"Avenir-Book" size:14];
    appearance.valueFont = appearance.labelFont;
    appearance.entryFont = appearance.labelFont;
    root.appearance = appearance;
    
    
    QSection * motionSection = [[QSection alloc] init];
    
    [root addSection:motionSection];
    [motionSection addElement:[self labelElementWithTitle:@"Accelerometer" viewControllerName:@"AccelerometerViewController"]];
    [motionSection addElement:[self labelElementWithTitle:@"GyroViewController" viewControllerName:@"AccelerometerViewController"]];
    
    QSection * section = [[QSection alloc] init];
    [root addSection:section];
    

//    [section addElement:[self labelElementWithTitle:@"Arrow Path" viewControllerName:@"ArrowPathViewController"]];
    [section addElement:[self labelElementWithTitle:@"Round Button" viewControllerName:@"CircleButtonViewController"]];
    [section addElement:[self labelElementWithTitle:@"Chat" viewControllerName:@"ChatViewController"]];
    [section addElement:[self labelElementWithTitle:@"Table" viewControllerName:@"TableViewController"]];
//    [section addElement:[self labelElementWithTitle:@"Map" viewControllerName:@"MapViewController"]];
    [section addElement:[self labelElementWithTitle:@"Rotate Image" viewControllerName:@"RotateImageViewController"]];
    [section addElement:[self labelElementWithTitle:@"Collection" viewControllerName:@"CollectionViewController"]];
    [section addElement:[self labelElementWithTitle:@"Animation" viewControllerName:@"AnimationViewController"]];
//    [section addElement:[self labelElementWithTitle:@"Map II" viewControllerName:@"ViewController"]];
    [section addElement:[self labelElementWithTitle:@"Custom Modal View Controller" viewControllerName:@"ParentViewController"]];
    [section addElement:[self labelElementWithTitle:@"Empty Back Button" viewControllerName:@"EmptyButtonViewController"]];
    [section addElement:[self labelElementWithTitle:@"Navigation View Controller" viewControllerName:@"NavigationBarViewController"]];
    [section addElement:[self labelElementWithTitle:@"Alert Controller" viewControllerName:@"AlertViewController"]];
    [section addElement:[self labelElementWithTitle:@"Observer Controller" viewControllerName:@"ObserverViewController"]];
    [section addElement:[self labelElementWithTitle:@"File Sharing" viewControllerName:@"FileSharingViewController"]];
    [section addElement:[self labelElementWithTitle:@"Grid Finder" viewControllerName:@"GridFinderViewController"]];
    [section addElement:[self labelElementWithTitle:@"Switch Map" viewControllerName:@"SwitchMapViewController"]];
    [section addElement:[self labelElementWithTitle:@"Gradient Button" viewControllerName:@"GradientButtonViewController"]];
    [section addElement:[self labelElementWithTitle:@"Image Picker View Controller" viewControllerName:@"ImagePickerViewController"]];
    

    
    [self.quickDialogTableView reloadData];

    
}

-(QLabelElement *)labelElementWithTitle:(NSString *)title viewControllerName:(NSString *)viewControllerName color:(UIColor *)color image:(UIImage *)image{
    QLabelElement * label = [[QLabelElement alloc] initWithTitle:title Value:nil];
    
    label.controllerAction = @"labelElementHandler:";
    label.key = viewControllerName;
    label.image = image;
    if (color) {
        QAppearance * apprearance = [[self.root appearance] copy];
        apprearance.labelColorEnabled = color;
        label.appearance = apprearance;
    }
    label.keepSelected = NO;
    label.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return label;

}
-(QLabelElement *)labelElementWithTitle:(NSString *)title viewControllerName:(NSString *)viewControllerName{
    
    return [self labelElementWithTitle:title viewControllerName:viewControllerName color:nil image:nil];
    
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
    
    if (viewController.title.length == 0) {
        viewController.title = element.title;
    }
    
    if (self.splitViewController) {
        DetailViewManager * detailViewMangager = (DetailViewManager *)self.splitViewController.delegate;
        detailViewMangager.detailViewController = viewController;
    }else{
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
    
    }
    

    
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
