//
//  ArrowPathView.m
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 2/27/15.
//  Copyright (c) 2015 Kent Peifeng Ke. All rights reserved.
//

#import "ArrowPathView.h"

@implementation ArrowPathView{
    
    UIImageView * drawImage;
}
-(void)dealloc{
    CGImageRelease(image);
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        drawImage = [[UIImageView alloc] initWithFrame:self.frame];
        drawImage.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:drawImage];
        
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"track_arrow.png" ofType:nil];
        UIImage *img = [UIImage imageWithContentsOfFile:imagePath];
        image = CGImageRetain(img.CGImage);
        self.backgroundColor = [UIColor colorWithRed:0.001 green:0.394 blue:0.213 alpha:1.000];
    }
    return self;
}

-(void)drawRect:(CGRect)rect{

    [super drawRect:rect];
    //// Bezier Drawing
//    UIBezierPath* bezierPath = UIBezierPath.bezierPath;
//    [bezierPath moveToPoint: CGPointMake(17, 87)];
//    [bezierPath addLineToPoint: CGPointMake(20, 87)];
//    [bezierPath addLineToPoint: CGPointMake(24, 82)];
//    [bezierPath addLineToPoint: CGPointMake(24, 75)];
//    [bezierPath addLineToPoint: CGPointMake(20, 70)];
//    [bezierPath addLineToPoint: CGPointMake(20, 62)];
//    [bezierPath addLineToPoint: CGPointMake(29, 50)];
//    [bezierPath addLineToPoint: CGPointMake(40, 45)];
//    [bezierPath addLineToPoint: CGPointMake(54, 40)];
//    [bezierPath addLineToPoint: CGPointMake(80, 28)];
//    [bezierPath addLineToPoint: CGPointMake(101, 24)];
//    [bezierPath addLineToPoint: CGPointMake(129, 31)];
//    [bezierPath addLineToPoint: CGPointMake(164, 36)];
//    [bezierPath addLineToPoint: CGPointMake(186, 36)];
//    [bezierPath addLineToPoint: CGPointMake(207, 40)];
//    [bezierPath addLineToPoint: CGPointMake(210, 70)];
//    [bezierPath addLineToPoint: CGPointMake(186, 87)];
//    [bezierPath addLineToPoint: CGPointMake(125, 87)];
//    [bezierPath addLineToPoint: CGPointMake(101, 92)];
//    [bezierPath addLineToPoint: CGPointMake(72, 95)];
//    [bezierPath addLineToPoint: CGPointMake(54, 92)];
//    [bezierPath addLineToPoint: CGPointMake(43, 95)];
//    [bezierPath addLineToPoint: CGPointMake(29, 95)];
//    [UIColor.blackColor setStroke];
//    bezierPath.lineWidth = 4;
//    [bezierPath stroke];
    
    
    //// Bezier Drawing
    UIBezierPath* bezierPath = UIBezierPath.bezierPath;
    [bezierPath moveToPoint: CGPointMake(27.5, 24.5)];
    [bezierPath addLineToPoint: CGPointMake(13.5, 52.5)];
    [bezierPath addLineToPoint: CGPointMake(13.5, 56.5)];
    [bezierPath addLineToPoint: CGPointMake(17.5, 56.5)];
    [bezierPath addLineToPoint: CGPointMake(27.5, 56.5)];
    [bezierPath addLineToPoint: CGPointMake(27.5, 52.5)];
    [bezierPath addLineToPoint: CGPointMake(34.5, 43.5)];
    [bezierPath addLineToPoint: CGPointMake(42.5, 52.5)];
    [bezierPath addLineToPoint: CGPointMake(42.5, 56.5)];
    [bezierPath addLineToPoint: CGPointMake(46.5, 59.5)];
    [bezierPath addLineToPoint: CGPointMake(52.5, 59.5)];
    [bezierPath addLineToPoint: CGPointMake(55.5, 56.5)];
    [bezierPath addLineToPoint: CGPointMake(67.5, 39.5)];
    [bezierPath addLineToPoint: CGPointMake(88.5, 24.5)];
    [bezierPath addLineToPoint: CGPointMake(104.5, 27.5)];
    [bezierPath addLineToPoint: CGPointMake(104.5, 31.5)];
    [bezierPath addLineToPoint: CGPointMake(104.5, 39.5)];
    [bezierPath addLineToPoint: CGPointMake(100.5, 43.5)];
    [bezierPath addLineToPoint: CGPointMake(96.5, 47.5)];
    [bezierPath addLineToPoint: CGPointMake(88.5, 52.5)];
    [bezierPath addLineToPoint: CGPointMake(88.5, 56.5)];
    [bezierPath addLineToPoint: CGPointMake(91.5, 65.5)];
    [bezierPath addLineToPoint: CGPointMake(91.5, 70.5)];
    [bezierPath addLineToPoint: CGPointMake(91.5, 77.5)];
    [bezierPath addLineToPoint: CGPointMake(88.5, 81.5)];
    [bezierPath addLineToPoint: CGPointMake(84.5, 84.5)];
    [bezierPath addLineToPoint: CGPointMake(84.5, 87.5)];
    [bezierPath addLineToPoint: CGPointMake(88.5, 87.5)];
    [bezierPath addLineToPoint: CGPointMake(91.5, 87.5)];
    [bezierPath addLineToPoint: CGPointMake(100.5, 87.5)];
    [bezierPath addLineToPoint: CGPointMake(100.5, 81.5)];
    [bezierPath addLineToPoint: CGPointMake(100.5, 77.5)];
    [bezierPath addLineToPoint: CGPointMake(100.5, 70.5)];
    [bezierPath addLineToPoint: CGPointMake(100.5, 65.5)];
    [bezierPath addLineToPoint: CGPointMake(104.5, 59.5)];
    [bezierPath addLineToPoint: CGPointMake(114.5, 56.5)];
    [bezierPath addLineToPoint: CGPointMake(124.5, 47.5)];
    [bezierPath addLineToPoint: CGPointMake(124.5, 43.5)];
    [bezierPath addLineToPoint: CGPointMake(135.5, 36.5)];
    [bezierPath addLineToPoint: CGPointMake(140.5, 27.5)];
    [bezierPath addLineToPoint: CGPointMake(154.5, 31.5)];
    [bezierPath addLineToPoint: CGPointMake(154.5, 43.5)];
    [bezierPath addLineToPoint: CGPointMake(144.5, 47.5)];
    [bezierPath addLineToPoint: CGPointMake(132.5, 65.5)];
    [bezierPath addLineToPoint: CGPointMake(121.5, 74.5)];
    [bezierPath addLineToPoint: CGPointMake(114.5, 84.5)];
    [bezierPath addLineToPoint: CGPointMake(114.5, 87.5)];
    [bezierPath addLineToPoint: CGPointMake(114.5, 92.5)];
    [bezierPath addLineToPoint: CGPointMake(118.5, 92.5)];
    [bezierPath addLineToPoint: CGPointMake(124.5, 92.5)];
    [bezierPath addLineToPoint: CGPointMake(127.5, 87.5)];
    [bezierPath addLineToPoint: CGPointMake(132.5, 84.5)];
    [bezierPath addLineToPoint: CGPointMake(135.5, 81.5)];
    [bezierPath addLineToPoint: CGPointMake(144.5, 77.5)];
    [bezierPath addLineToPoint: CGPointMake(149.5, 74.5)];
    [bezierPath addLineToPoint: CGPointMake(154.5, 70.5)];
    [bezierPath addLineToPoint: CGPointMake(154.5, 65.5)];
    [bezierPath addLineToPoint: CGPointMake(170.5, 65.5)];
    [bezierPath addLineToPoint: CGPointMake(174.5, 56.5)];
    [bezierPath addLineToPoint: CGPointMake(178.5, 47.5)];
    [bezierPath addLineToPoint: CGPointMake(181.5, 39.5)];
    [bezierPath addLineToPoint: CGPointMake(189.5, 36.5)];
    [bezierPath addLineToPoint: CGPointMake(198.5, 39.5)];
    [bezierPath addLineToPoint: CGPointMake(189.5, 52.5)];
    [bezierPath addLineToPoint: CGPointMake(189.5, 52.5)];
    [bezierPath addLineToPoint: CGPointMake(189.5, 65.5)];
    [bezierPath addLineToPoint: CGPointMake(181.5, 70.5)];
    [bezierPath addLineToPoint: CGPointMake(181.5, 74.5)];
    [bezierPath addLineToPoint: CGPointMake(174.5, 81.5)];
    [bezierPath addLineToPoint: CGPointMake(163.5, 84.5)];
    [bezierPath addLineToPoint: CGPointMake(154.5, 87.5)];
    [bezierPath addLineToPoint: CGPointMake(166.5, 92.5)];
    [bezierPath addLineToPoint: CGPointMake(166.5, 95.5)];
    [bezierPath addLineToPoint: CGPointMake(174.5, 95.5)];
    [bezierPath addLineToPoint: CGPointMake(181.5, 92.5)];
    [bezierPath addLineToPoint: CGPointMake(189.5, 87.5)];
    [bezierPath addLineToPoint: CGPointMake(198.5, 81.5)];
    [bezierPath addLineToPoint: CGPointMake(204.5, 65.5)];
    [bezierPath addLineToPoint: CGPointMake(207.5, 52.5)];
    [bezierPath addLineToPoint: CGPointMake(218.5, 43.5)];
    [bezierPath addLineToPoint: CGPointMake(225.5, 47.5)];
    [bezierPath addLineToPoint: CGPointMake(225.5, 62.5)];
    [bezierPath addLineToPoint: CGPointMake(218.5, 70.5)];
    [bezierPath addLineToPoint: CGPointMake(212.5, 84.5)];
    [bezierPath addLineToPoint: CGPointMake(204.5, 87.5)];
    [bezierPath addLineToPoint: CGPointMake(194.5, 98.5)];
    [bezierPath addLineToPoint: CGPointMake(194.5, 103.5)];
    [bezierPath addLineToPoint: CGPointMake(185.5, 107.5)];
    [bezierPath addLineToPoint: CGPointMake(178.5, 112.5)];
    [bezierPath addLineToPoint: CGPointMake(163.5, 107.5)];
    [bezierPath addLineToPoint: CGPointMake(149.5, 107.5)];
    [bezierPath addLineToPoint: CGPointMake(144.5, 112.5)];
    [bezierPath addLineToPoint: CGPointMake(135.5, 112.5)];
    [bezierPath addLineToPoint: CGPointMake(114.5, 107.5)];
    [bezierPath addLineToPoint: CGPointMake(100.5, 112.5)];
    [bezierPath addLineToPoint: CGPointMake(88.5, 112.5)];
    [bezierPath addLineToPoint: CGPointMake(84.5, 107.5)];
    [bezierPath addLineToPoint: CGPointMake(74.5, 107.5)];
    [bezierPath addLineToPoint: CGPointMake(67.5, 107.5)];
    [bezierPath addLineToPoint: CGPointMake(63.5, 112.5)];
    [bezierPath addLineToPoint: CGPointMake(55.5, 112.5)];
    [bezierPath addLineToPoint: CGPointMake(52.5, 107.5)];
    [bezierPath addLineToPoint: CGPointMake(52.5, 98.5)];
    [bezierPath addLineToPoint: CGPointMake(46.5, 103.5)];
    [bezierPath addLineToPoint: CGPointMake(42.5, 112.5)];
    [bezierPath addLineToPoint: CGPointMake(42.5, 116.5)];
    [bezierPath addLineToPoint: CGPointMake(34.5, 112.5)];
    [bezierPath addLineToPoint: CGPointMake(37.5, 107.5)];
    [bezierPath addLineToPoint: CGPointMake(37.5, 98.5)];
    [bezierPath addLineToPoint: CGPointMake(24.5, 98.5)];
    [bezierPath addLineToPoint: CGPointMake(24.5, 107.5)];
    [bezierPath addLineToPoint: CGPointMake(17.5, 103.5)];
    [bezierPath addLineToPoint: CGPointMake(13.5, 95.5)];
    [bezierPath addLineToPoint: CGPointMake(5.5, 84.5)];
    [UIColor.blackColor setStroke];
    bezierPath.lineWidth = 3.5;
    [bezierPath stroke];


    lastPoint = CGPointZero;
    CGPathRef path = [bezierPath CGPath];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddPath(context, path);
    pointCount = 0;
    CGPathApply(path, NULL, drawArrows);
    
    
    
}

int pointCount = 0;
float lastMarkDistance = 0;
float totalDistance = 0;
CGPoint lastPoint;

CGImageRef image;

void drawArrows(void *info, const CGPathElement *element){
    
    CGFloat kMarkSpace = 32.0;
    CGFloat kMarkSize = 8;

    pointCount++;
    CGPoint currentPoint = element->points[0];
    if (pointCount == 1) {
        lastPoint = currentPoint;
        return;
    }

    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
//    double deltaX = lastPoint.x - currentPoint.x;
//    double deltaY = lastPoint.y - currentPoint.y;

    double deltaX = lastPoint.x - currentPoint.x;
    double deltaY = lastPoint.y - currentPoint.y;
    
    double powX = pow(deltaX,2);
    double powY = pow(deltaY,2);
    
    double distance = sqrt(powX + powY);
    
    float lastPointDistance = totalDistance;
    totalDistance += distance;
    
    
    if (totalDistance-lastMarkDistance >= kMarkSpace){
        
        
        
        float angle = atan2(deltaX, deltaY);
//        angle *= (M_PI / 180);
        
        
        CGImageRef imgRef = image;
        CGFloat angleInRadians = -angle;
//        CGFloat angleInRadians = angle * (M_PI / 180);
        //        CGFloat angleInRadians = 0.5;
        CGFloat width = CGImageGetWidth(imgRef);
        CGFloat height = CGImageGetHeight(imgRef);
        
        CGRect imgRect = CGRectMake(0, 0, width, height);
        CGAffineTransform transform = CGAffineTransformMakeRotation(angleInRadians);
        CGRect rotatedRect = CGRectApplyAffineTransform(imgRect, transform);
        
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGContextRef bmContext = CGBitmapContextCreate(NULL,
                                                       rotatedRect.size.width,
                                                       rotatedRect.size.height,
                                                       8,
                                                       0,
                                                       colorSpace,
                                                       kCGImageAlphaPremultipliedFirst);
        CGContextSetAllowsAntialiasing(bmContext, FALSE);
        CGContextSetInterpolationQuality(bmContext, kCGInterpolationNone);
        CGColorSpaceRelease(colorSpace);
        CGContextTranslateCTM(bmContext,
                              +(rotatedRect.size.width/2),
                              +(rotatedRect.size.height/2));
        CGContextRotateCTM(bmContext, angleInRadians);
        CGContextTranslateCTM(bmContext,
                              -(rotatedRect.size.width/2),
                              -(rotatedRect.size.height/2));
        CGContextDrawImage(bmContext, CGRectMake(0, 0,
                                                 rotatedRect.size.width,
                                                 rotatedRect.size.height),
                           imgRef);
        
        CGImageRef rotatedImage = CGBitmapContextCreateImage(bmContext);
        CFRelease(bmContext);
        
//        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"track_arrow.png" ofType:nil];
//        UIImage *img = [UIImage imageWithContentsOfFile:imagePath];
//        CGImageRef image = CGImageRetain(img.CGImage);
        
        CGPoint markPoint;
        float startDistance = kMarkSpace - ((int)lastPointDistance % (int)kMarkSpace);
        
        float pointDistance = startDistance;
        while (pointDistance < distance) {
            float radius = (pointDistance/distance);
            markPoint.x = lastPoint.x - deltaX * radius;
            markPoint.y = lastPoint.y - deltaY * radius;
//            CGContextDrawImage(context, CGRectMake(markPoint.x - kMarkSize/2, markPoint.y-kMarkSize/2, kMarkSize, kMarkSize),rotatedImage);
            CGContextSetFillColorWithColor(context, [[UIColor redColor] CGColor]);
            
            NSString * numberString = [NSString stringWithFormat:@"%d", pointCount];
            
            
            [numberString drawAtPoint:markPoint withFont:[UIFont systemFontOfSize:14]];
            
            pointDistance += kMarkSpace;
        }

        lastMarkDistance = lastPointDistance+pointDistance-kMarkSpace;
        
        
    }
    
    CGPoint pointArg = element->points[0];
    NSLog(@"Type: %u || Point: %@", element->type, NSStringFromCGPoint(pointArg));
    
    
    lastPoint = currentPoint;
    
}

/*-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [touches anyObject];
    lastPoint = [touch locationInView:self];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    
    double deltaX = lastPoint.x - currentPoint.x;
    double deltaY = lastPoint.y - currentPoint.y;
    
    double powX = pow(deltaX,2);
    double powY = pow(deltaY,2);
    
    double distance = sqrt(powX + powY);
    if (distance >= 64){
        
        lastPoint = currentPoint;
        
        UIGraphicsBeginImageContext(self.frame.size);
        [drawImage.image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        CGContextSaveGState(UIGraphicsGetCurrentContext());
        
        float angle = atan2(deltaX, deltaY);
        angle *= (M_PI / 180);
        
        
        CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(currentPoint.x, currentPoint.y, 64, 64),[self CGImageRotatedByAngle:image angle:angle * -1]);
        CGContextRestoreGState(UIGraphicsGetCurrentContext());
        drawImage.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        distance = 0;
        
    }
    
}*/


- (CGImageRef)CGImageRotatedByAngle:(CGImageRef)imgRef angle:(CGFloat)angle
{
    CGFloat angleInRadians = angle * (M_PI / 180);
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGRect imgRect = CGRectMake(0, 0, width, height);
    CGAffineTransform transform = CGAffineTransformMakeRotation(angleInRadians);
    CGRect rotatedRect = CGRectApplyAffineTransform(imgRect, transform);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef bmContext = CGBitmapContextCreate(NULL,
                                                   rotatedRect.size.width,
                                                   rotatedRect.size.height,
                                                   8,
                                                   0,
                                                   colorSpace,
                                                   kCGImageAlphaPremultipliedFirst);
    CGContextSetAllowsAntialiasing(bmContext, FALSE);
    CGContextSetInterpolationQuality(bmContext, kCGInterpolationNone);
    CGColorSpaceRelease(colorSpace);
    CGContextTranslateCTM(bmContext,
                          +(rotatedRect.size.width/2),
                          +(rotatedRect.size.height/2));
    CGContextRotateCTM(bmContext, angleInRadians);
    CGContextTranslateCTM(bmContext,
                          -(rotatedRect.size.width/2),
                          -(rotatedRect.size.height/2));
    CGContextDrawImage(bmContext, CGRectMake(0, 0,
                                             rotatedRect.size.width,
                                             rotatedRect.size.height),
                       imgRef);
    
    CGImageRef rotatedImage = CGBitmapContextCreateImage(bmContext);
    CFRelease(bmContext);

    
    return rotatedImage;
}
@end
