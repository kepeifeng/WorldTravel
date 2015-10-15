//
//  WTCopyQuoteActivity.m
//  WorldTravel
//
//  Created by Kent on 10/12/15.
//  Copyright © 2015 Kent Peifeng Ke. All rights reserved.
//

#import "WTCopyQuoteActivity.h"
#import "WTCopyQuoteViewController.h"
NSString * const WTCopyQuoteActivityType = @"com.coffeeandsandwich.WTCopyQuoteActivityType";
@implementation WTCopyQuoteActivity{

    NSString * _text;
}

static NSArray * WTMatchingItemsInActivityItems(NSArray * items){
    
    return [items filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nonnull evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        if ([evaluatedObject  isKindOfClass:[NSString class]]) {
            return YES;
        }
        return NO;
    }]];
    
}

+(UIActivityCategory)activityCategory{
    
    return UIActivityCategoryAction;
}

-(NSString *)activityType{
    
    return WTCopyQuoteActivityType;
}

-(NSString *)activityTitle{
    return @"Copy Quote";
}

-(UIImage *)activityImage{
    return [UIImage imageNamed:@"main_icon.png"];
}

-(BOOL)canPerformWithActivityItems:(NSArray *)activityItems{
    
    return ([WTMatchingItemsInActivityItems(activityItems) count]>0);
}

-(void)prepareWithActivityItems:(NSArray *)activityItems{
    
    _text = [WTMatchingItemsInActivityItems(activityItems) firstObject];
    
}

-(UIViewController *)activityViewController{

    WTCopyQuoteViewController * viewController = [[WTCopyQuoteViewController alloc] init];
    viewController.text = _text;
    return viewController;
}
@end
