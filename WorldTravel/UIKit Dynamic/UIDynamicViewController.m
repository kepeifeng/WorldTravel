//
//  UIDynamicViewController.m
//  WorldTravel
//
//  Created by Kent on 10/10/15.
//  Copyright © 2015 Kent Peifeng Ke. All rights reserved.
//

#import "UIDynamicViewController.h"

@interface UIDynamicViewController ()

@end

@implementation UIDynamicViewController{

    UIDynamicAnimator * _animator;
    UIGravityBehavior * _gravity;
    UICollisionBehavior * _collision;
    
    UIView * _blockView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemRefresh) target:self action:@selector(resetItemTapped:)];
    [self setupView];
}
-(void)resetItemTapped:(id)sender{

    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self setupView];
}

-(void)setupView{

    UIButton * sqareView = [[UIButton alloc] initWithFrame:(CGRectMake((CGRectGetWidth(self.view.frame) - 80.0f)/2, 80.0f, 80.0f, 80.0f))];
    [sqareView addTarget:self action:@selector(sqareButtonTapped:) forControlEvents:(UIControlEventTouchUpInside)];
    sqareView.backgroundColor = [UIColor redColor];
    [self.view addSubview:sqareView];
    
    
    _blockView = [[UIView alloc] initWithFrame:(CGRectMake(0, 300, 150, 30))];
    _blockView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_blockView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)sqareButtonTapped:(UIButton *)sender{
    
    //Setup Animation Engine
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    //Setup a Gravity behavior
    _gravity = [[UIGravityBehavior alloc] initWithItems:@[sender]];

//    _gravity.angle = 45.0;
    [_animator addBehavior:_gravity];
    
    //Limit to the boundary
    _collision = [[UICollisionBehavior alloc] initWithItems:@[sender]];
    CGPoint endPoint = _blockView.frame.origin;
    endPoint.x += CGRectGetWidth(_blockView.frame);
    [_collision addBoundaryWithIdentifier:@"blockBoundary" fromPoint:_blockView.frame.origin toPoint:endPoint];
    _collision.translatesReferenceBoundsIntoBoundary = YES;
    [_animator addBehavior:_collision];
    
    UIDynamicItemBehavior * itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[sender]];
    itemBehavior.elasticity = 0.6;//弹性
    itemBehavior.friction = 0.2;//摩擦力
    itemBehavior.density = 10;//密度
//    itemBehavior.resistance = 0.1;//抵抗力
//    itemBehavior.angularResistance =
//    itemBehavior.allowsRotation = NO;
    [_animator addBehavior:itemBehavior];
    
    
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
