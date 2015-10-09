//
//  ParentViewController.m
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 14/11/7.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import "ParentViewController.h"
#import "CustomModalViewController.h"

@interface ParentViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@end

@implementation ParentViewController{

    NSDictionary * _styleItemsDict;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.navigationItem.hidesBackButton = YES;
    
    _styleItemsDict = @{@(UIModalPresentationPageSheet):@"PageSheet",
                        @(UIModalPresentationFormSheet):@"FormSheet",
                        @(UIModalPresentationCurrentContext):@"CurrentContext",
                        @(UIModalPresentationCustom):@"Custom",
                        @(UIModalPresentationOverFullScreen):@"OverFullScreen",
                        @(UIModalPresentationOverCurrentContext):@"OverCurrentContext",
                        @(UIModalPresentationPopover):@"Popover",
                        @(UIModalPresentationNone):@"None",};
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)presentViewControllerTapped:(id)sender {

    NSUInteger index = [self.pickerView selectedRowInComponent:0];
    NSNumber * key = _styleItemsDict.allKeys[index];
    UIModalPresentationStyle style = [key integerValue];
    CustomModalViewController * viewController = [[CustomModalViewController alloc] init];
    viewController.modalPresentationStyle = style;
    [self presentViewController:viewController animated:YES completion:NULL];
}


- (IBAction)addAsSubviewButtonTapped:(id)sender {
    
    CustomModalViewController * viewController = [[CustomModalViewController alloc] init];
    [self addChildViewController:viewController];
    viewController.view.frame = self.view.bounds;
    [self.view addSubview:viewController.view];
    [viewController didMoveToParentViewController:self];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{

    return 1;
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

    return _styleItemsDict.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{

    NSNumber * key = _styleItemsDict.allKeys[row];
    NSString * value = _styleItemsDict[key];
    return value;
}

@end
