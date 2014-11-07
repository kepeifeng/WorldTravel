//
//  MessageAnnotationView.m
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 14-6-26.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import "MessageAnnotationView.h"
#import <pop/POP.h>
#define kDropCompressAmount 0.1

@implementation MessageAnnotationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/



- (void)didMoveToSuperview {
    if (!self.superview) {
        [self.layer removeAllAnimations];
        return;
    }
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation
                                      animationWithKeyPath:@"transform"];
    
    CATransform3D scale1 = CATransform3DMakeScale(0.5, 0.5, 1);
    CATransform3D scale2 = CATransform3DMakeScale(1.2, 1.2, 1);
    CATransform3D scale3 = CATransform3DMakeScale(0.9, 0.9, 1);
    CATransform3D scale4 = CATransform3DMakeScale(1.0, 1.0, 1);
    
    NSArray *frameValues = [NSArray arrayWithObjects:
                            [NSValue valueWithCATransform3D:scale1],
                            [NSValue valueWithCATransform3D:scale2],
                            [NSValue valueWithCATransform3D:scale3],
                            [NSValue valueWithCATransform3D:scale4],
                            nil];
    [animation setValues:frameValues];
    
    NSArray *frameTimes = [NSArray arrayWithObjects:
                           [NSNumber numberWithFloat:0.0],
                           [NSNumber numberWithFloat:0.5],
                           [NSNumber numberWithFloat:0.9],
                           [NSNumber numberWithFloat:1.0],
                           nil];
    [animation setKeyTimes:frameTimes];
    
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.duration = .2;
    
    [self.layer addAnimation:animation forKey:@"popup"];
    
//    float xOriginDivider = 20.;
//    float pos = 0;
//    
//    UIView *mySuperview = self.superview;
//    while (mySuperview && ![mySuperview isKindOfClass:[BMKMapView class]])
//        mySuperview = mySuperview.superview;
//    if ([mySuperview isKindOfClass:[BMKMapView class]])
//        //given the position in the array
//        // pos = [((MKMapView *) mySuperview).annotations indexOfObject:self.annotation];
//        // left to right sequence;
//        pos = [((BMKMapView *) mySuperview) convertCoordinate:self.annotation.coordinate toPointToView:mySuperview].x / xOriginDivider;
//    
//    float yOffsetMultiplier = 20.;
//    float timeOffsetMultiplier = 0.05;
//    
//    
    
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
//    animation.duration = 0.4 + timeOffsetMultiplier * pos;
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
//    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, -400 - yOffsetMultiplier * pos, 0)];
//    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
//    
//    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform"];
//    animation2.duration = 0.10;
//    animation2.beginTime = animation.duration;
//    animation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
//    animation2.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DMakeTranslation(0, self.layer.frame.size.height*kDropCompressAmount, 0), 1.0, 1.0-kDropCompressAmount, 1.0)];
//    animation2.fillMode = kCAFillModeForwards;
//    
//    CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"transform"];
//    animation3.duration = 0.15;
//    animation3.beginTime = animation.duration+animation2.duration;
//    animation3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
//    animation3.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
//    animation3.fillMode = kCAFillModeForwards;
//    
//    CAAnimationGroup *group = [CAAnimationGroup animation];
//    group.animations = [NSArray arrayWithObjects:animation, animation2, animation3, nil];
//    group.duration = animation.duration+animation2.duration+animation3.duration;
//    group.fillMode = kCAFillModeForwards;
    
//    [self.layer addAnimation:group forKey:nil];
}
-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
}
-(void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
}

@end
