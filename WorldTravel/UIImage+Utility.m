//
//  UIImage+Utility.m
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 1/31/15.
//  Copyright (c) 2015 Kent Peifeng Ke. All rights reserved.
//

#import "UIImage+Utility.h"

@implementation UIImage (Utility)
+ (UIImage *) imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}
@end
