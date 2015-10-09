//
//  ImagePickerViewController.m
//  WorldTravel
//
//  Created by Kent on 10/8/15.
//  Copyright © 2015 Kent Peifeng Ke. All rights reserved.
//

#import "ImagePickerViewController.h"

@interface ImagePickerViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation ImagePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(buttonTapped:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonTapped:(id)sender {
    
    UIImagePickerController * imagePickerVC = [[UIImagePickerController alloc] init];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    [self presentViewController:imagePickerVC animated:YES completion:NULL];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    UIImage * originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage * editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
    self.originalImageView.image = originalImage;
    self.editedImageView.image = editedImage;
    NSLog(@"%@", info);
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
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
