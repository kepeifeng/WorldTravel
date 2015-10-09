//
//  GridView.m
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 1/5/15.
//  Copyright (c) 2015 Kent Peifeng Ke. All rights reserved.
//

#import "GridView.h"
#include "mach/mach_time.h"

__weak id thisClass;
@implementation GridView{
    NSArray * _grids;
    
    CGPoint _startPoint;
    CGPoint _endPoint;
    CGFloat gridWidth;
    CGFloat gridHeight;

}

-(void)dealloc{
    NSLog(@"dealloc GridView");
    if (thisClass == self) {
        thisClass = nil;
    }
}

//-(instancetype)init{
//    self = [super init];
//    if (self) {
//    }
//    return self;
//}

-(instancetype)initWithFrame:(CGRect)frame rows:(NSInteger)rows columns:(NSInteger)columns{

    self = [super initWithFrame:frame];
    if (self) {
        
        thisClass = self;
        
        self.backgroundColor = [UIColor whiteColor];
        _rows = rows;
        _columns = columns;
        
        NSMutableArray * grids = [[NSMutableArray alloc] initWithCapacity:_rows * _columns];
        _grids = grids;
        gridWidth = (NSInteger) CGRectGetWidth(self.frame)/columns;
        gridHeight = (NSInteger) CGRectGetHeight(self.frame)/rows;
        CGPoint position = CGPointZero;
        for (NSInteger row =0 ; row < _rows; row++) {
            position.x = 0;
            NSMutableArray * rowArray = [[NSMutableArray alloc] initWithCapacity:_columns];
            for (NSInteger column = 0; column < _columns; column++) {
                
                UILabel * grid = [[UILabel alloc] initWithFrame:(CGRectMake(position.x, position.y, gridWidth, gridHeight))];
                [grid setFont:[UIFont systemFontOfSize:9]];
                grid.textAlignment = NSTextAlignmentCenter;
                grid.text = [NSString stringWithFormat:@"%d,%d", column,row];
                grid.textColor = [UIColor colorWithWhite:0.830 alpha:1.000];
                [grid setUserInteractionEnabled:NO];
                grid.layer.borderWidth = 0.5;
                grid.layer.borderColor  = [[UIColor lightGrayColor] CGColor];
                
                [self addSubview:grid];
                position.x += gridWidth;
                [rowArray addObject:grid];
            }
            position.y += gridHeight;
            [grids addObject:rowArray];
        }
        
        _startPoint = CGPointZero;
        _endPoint = CGPointZero;
        UIPanGestureRecognizer * longPress = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(longPressHandler:)];
        longPress.cancelsTouchesInView = NO;
        [self addGestureRecognizer:longPress];
        
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (_startPoint.x || _startPoint.y) {
        
        
        [[UIColor redColor] setStroke];
        UIBezierPath * path = [UIBezierPath bezierPath];
        [path moveToPoint:_startPoint];
        [path addLineToPoint:_endPoint];
        path.lineWidth = 2.0;
        
        [path stroke];
    }
}
-(void)clear{

    for (NSArray * rowArray in _grids) {
        for (UIView * grid in rowArray) {
            grid.backgroundColor = [UIColor clearColor];
        }
    }
}
-(void)highlightGridAtX:(NSInteger)x Y:(NSInteger)y{

    CGFloat EXPAND = 1;
    
    CGPoint point = CGPointMake(MAX(0, x - EXPAND), MAX(0, y - EXPAND));
    CGRect rect = CGRectMake(point.x, point.y, MIN(EXPAND * 2+1, _rows - point.x), MIN(EXPAND*2+1, _columns - point.y));
    for (NSInteger row = CGRectGetMinY(rect); row < CGRectGetMaxY(rect); row++) {
        NSArray * rowArray = [_grids objectAtIndex:row];
        for (NSInteger column = CGRectGetMinX(rect); column<CGRectGetMaxX(rect); column++) {
            UIView * grid = [rowArray objectAtIndex:column];
            if (row == y && column == x) {
                [grid setBackgroundColor:[UIColor colorWithRed:1.000 green:1.000 blue:0.000 alpha:0.200]];
                
            }else{
                [grid setBackgroundColor:[UIColor colorWithRed:1.000 green:1.000 blue:0.000 alpha:0.400]];
            
            }
        }
    }


}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGPoint position = CGPointZero;
    for (NSInteger row =0 ; row < _rows; row++) {
        position.x = 0;
        NSMutableArray * rowArray = [_grids objectAtIndex:row];
        for (NSInteger column = 0; column < _columns; column++) {
            
            UILabel * grid = [rowArray objectAtIndex:column];
            grid.frame = CGRectMake(position.x, position.y, gridWidth, gridHeight);
            position.x += gridWidth;
        }
        position.y += gridHeight;
    }

}

//-(NSArray *)expandedGridsOfX:(NSInteger)x y:(NSInteger)y range:(NSInteger)range{
//
//    
//}

-(void)longPressHandler:(UIPanGestureRecognizer *)longPress{
    
    CGPoint point = [longPress locationInView:self];
    if (longPress.state == UIGestureRecognizerStateBegan) {
        _startPoint = point;
        _endPoint = point;
        [self clear];
        [self setNeedsDisplay];
    }else if (longPress.state == UIGestureRecognizerStateChanged){
        _endPoint = point;
    }else if (longPress.state == UIGestureRecognizerStateEnded){
        [self updateGrids];
        [self setNeedsDisplay];
    }
    
    [self setNeedsDisplayInRect:(CGRectMake(_startPoint.x, _startPoint.y, _endPoint.x - _startPoint.x, _endPoint.y - _startPoint.y))];
    

}

-(void)updateGrids{

    CGPoint startCoord = CGPointMake((NSInteger)(_startPoint.x/gridWidth), (NSInteger)(_startPoint.y/gridHeight));
    CGPoint endCoord = CGPointMake((NSInteger)(_endPoint.x/gridWidth), (NSInteger)(_endPoint.y/gridHeight));
    
    NSDate *methodStart = [NSDate date];
    
    /* ... Do whatever you need to do ... */
    
    useVisionLine(startCoord.y, startCoord.x, endCoord.y, endCoord.x);
    
    NSDate *methodFinish = [NSDate date];
    NSTimeInterval executionTime = [methodFinish timeIntervalSinceDate:methodStart];
    NSLog(@"executionTime = %.5f", executionTime);
    
}


void POINT (int y, int x){
    NSLog(@"(%d,%d)" ,x , y);
    [thisClass highlightGridAtX:x Y:y];
}

// use Bresenham-like algorithm to print a line from (y1,x1) to (y2,x2)
// The difference with Bresenham is that ALL the points of the line are
//   printed, not only one per x coordinate.
// Principles of the Bresenham's algorithm (heavily modified) were taken from:
//   http://www.intranet.ca/~sshah/waste/art7.html
void useVisionLine (int y1, int x1, int y2, int x2)
{
    int i;               // loop counter
    int ystep, xstep;    // the step on y and x axis
    int error;           // the error accumulated during the increment
    int errorprev;       // *vision the previous value of the error variable
    int y = y1, x = x1;  // the line points
    int ddy, ddx;        // compulsory variables: the double values of dy and dx
    int dx = x2 - x1;
    int dy = y2 - y1;
    POINT (y1, x1);  // first point
    // NB the last point can't be here, because of its previous point (which has to be verified)
    if (dy < 0){
        ystep = -1;
        dy = -dy;
    }else
        ystep = 1;
    if (dx < 0){
        xstep = -1;
        dx = -dx;
    }else
        xstep = 1;
    ddy = 2 * dy;  // work with double values for full precision
    ddx = 2 * dx;
    if (ddx >= ddy){  // first octant (0 <= slope <= 1)
        // compulsory initialization (even for errorprev, needed when dx==dy)
        errorprev = error = dx;  // start in the middle of the square
        for (i=0 ; i < dx ; i++){  // do not use the first point (already done)
            x += xstep;
            error += ddy;
            if (error > ddx){  // increment y if AFTER the middle ( > )
                y += ystep;
                error -= ddx;
                // three cases (octant == right->right-top for directions below):
                if (error + errorprev < ddx)  // bottom square also
                    POINT (y-ystep, x);
                else if (error + errorprev > ddx)  // left square also
                    POINT (y, x-xstep);
                else{  // corner: bottom and left squares also
                    POINT (y-ystep, x);
                    POINT (y, x-xstep);
                }
            }
            POINT (y, x);
            errorprev = error;
        }
    }else{  // the same as above
        errorprev = error = dy;
        for (i=0 ; i < dy ; i++){
            y += ystep;
            error += ddx;
            if (error > ddy){
                x += xstep;
                error -= ddy;
                if (error + errorprev < ddy)
                    POINT (y, x-xstep);
                else if (error + errorprev > ddy)
                    POINT (y-ystep, x);
                else{
                    POINT (y, x-xstep);
                    POINT (y-ystep, x);
                }
            }
            POINT (y, x);
            errorprev = error;
        }
    }
    // assert ((y == y2) && (x == x2));  // the last point (y2,x2) has to be the same with the last point of the algorithm
}



@end
