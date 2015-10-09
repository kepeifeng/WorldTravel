//
//  SharedLabel.m
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 1/19/15.
//  Copyright (c) 2015 Kent Peifeng Ke. All rights reserved.
//

#import "SharedLabel.h"
#import "UIImage+Utility.h"
static UILabel * _gSharedLabel;
//@interface UILabel (SharedLabel)
//@property (nonatomic, strong) LabelStatus * labelStatus;
//
//@end
//@implementation UILabel (SharedLabel)

//-(LabelStatus *)labelStatus{
//    LabelStatus * labelStatus = [LabelStatus new];
////    labelStatus.frame = self.frame;
//    labelStatus.backgroundColor = self.backgroundColor;
//    labelStatus.text = self.text;
//    return labelStatus;
//}
//
//-(void)setLabelStatus:(LabelStatus *)labelStatus{
//    
////    self.frame = labelStatus.frame;
//    self.backgroundColor = labelStatus.backgroundColor;
//    self.text = labelStatus.text;
//}
//
//@end
@interface SharedLabel ()
@property (nonatomic, readonly) BOOL isActivedSharedView;

@end
@implementation SharedLabel{
//    LabelStatus * _labelStatus;
    UIImage * _viewCapture;

}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialSetup];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = NO;
        [self initialSetup];
        
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    
    [super drawRect:rect];
    if (_viewCapture) {
        [_viewCapture drawInRect:rect];
    }
}


-(void)initialSetup{
    if (!_gSharedLabel) {
        _gSharedLabel = [[UILabel alloc] init];
        _gSharedLabel.textAlignment = NSTextAlignmentCenter;
        _gSharedLabel.font = [UIFont systemFontOfSize:64];
        _gSharedLabel.textColor = [UIColor whiteColor];
        _gSharedLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
}

-(BOOL)isActivedSharedView{
    if (_gSharedLabel.superview == self) {
        return YES;
    }
    return NO;
}
-(void)setText:(NSString *)text{
    _text = text;
    if (self.isActivedSharedView) {
        _gSharedLabel.text = self.text;
    }
}

-(void)setBackgroundColor:(UIColor *)backgroundColor{
    _backgroundColor = backgroundColor;
    if (self.isActivedSharedView) {
        _gSharedLabel.backgroundColor = backgroundColor;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)viewDidAppear
{
    //pop status
    
    _gSharedLabel.backgroundColor = self.backgroundColor;
    _gSharedLabel.text = self.text;

    [_gSharedLabel setFrame:self.bounds];
    [self addSubview:_gSharedLabel];
}

-(void)viewDidDisappear
{
    if (self.isActivedSharedView == NO) {
        return;
    }
	//push
    self.backgroundColor = _gSharedLabel.backgroundColor;
    self.text = _gSharedLabel.text;
    _viewCapture = [UIImage imageWithView:self];
    [self setNeedsDisplay];
}




//+(UILabel *)sharedLabel{
//    
//    if (!_gSharedLabel) {
//        _gSharedLabel = [[UILabel alloc] init];
//        _gSharedLabel.textAlignment = NSTextAlignmentCenter;
//        _gSharedLabel.font = [UIFont systemFontOfSize:64];
//    }
//    return _gSharedLabel;
//    
//}


//-(void)saveStatusForKey:(id)key{
//    [[SharedLabelManager defaultManager] saveLabelStatus:self forKey:key];
//}
//
//-(void)restoreStatusForKey:(id)key{
//    [[SharedLabelManager defaultManager] restoreLabelStatus:self forKey:key];
//}



@end



//
//@implementation LabelStatus
//
//+(instancetype)defaultStatus{
//    return nil;
//}
//@end
//
//
//
//@implementation SharedLabelManager{
//
//    NSMapTable * _labelStatusMap;
//}
//
//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        _labelStatusMap = [NSMapTable new];
//    }
//    return self;
//}
//
//-(void)saveLabelStatus:(SharedLabel *)label forKey:(id)key{
//    LabelStatus * status = [_labelStatusMap objectForKey:key];
//    if (!status) {
//        status = [LabelStatus new];
//        [_labelStatusMap setObject:status forKey:key];
//    }
//    status.text = label.text;
//    status.backgroundColor = label.backgroundColor;
//    NSLog(@"SAVE %@ - %@", status, status.text);
//}
//
//-(void)restoreLabelStatus:(SharedLabel *)label forKey:(id)key{
//    LabelStatus * status = [_labelStatusMap objectForKey:key];
//    if (!status) {
//        return;
//    }
//    
//    label.text = status.text;
//    label.backgroundColor = status.backgroundColor;
//    
//    NSLog(@"RESTORE %@ - %@", status, status.text);
//    
//}
//
//+(instancetype)defaultManager{
//    static SharedLabelManager * _gSharedLabelManager;
//    if (!_gSharedLabelManager) {
//        _gSharedLabelManager = [[SharedLabelManager alloc] init];
//    }
//    return _gSharedLabelManager;
//}
//
//@end