//
//  CollectionViewController.m
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 14/10/24.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import "CollectionViewController.h"

@interface CollectionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property CGAffineTransform cellTransform;
@end

@implementation CollectionViewController

-(void)loadView{
    [super loadView];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    layout.itemSize = CGSizeMake(60, 60);
    layout.minimumInteritemSpacing = 5;
    layout.minimumLineSpacing = 5;
    
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.view addSubview:collectionView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGAffineTransform transfrom = CGAffineTransformIdentity;
    transfrom = CGAffineTransformScale(transfrom, 1.2, 1.2);
    
    self.cellTransform = transfrom;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 100;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UICollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];

    }
    
    UILabel * label = (UILabel *)[cell.contentView viewWithTag:100];
    if (!label) {
        label = [[UILabel alloc] initWithFrame:cell.bounds];
        label.tag = 100;
        label.font = [UIFont systemFontOfSize:24];
        [cell.contentView addSubview:label];
    }
    
    NSArray * colors = @[[UIColor redColor], [UIColor orangeColor], [UIColor yellowColor], [UIColor greenColor], [UIColor cyanColor], [UIColor blueColor], [UIColor magentaColor]];
    label.backgroundColor = [colors objectAtIndex:arc4random_uniform(colors.count-1)];
    label.text = [NSString stringWithFormat:@"%d", indexPath.row];
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{

//    return;
    cell.transform = self.cellTransform;
    cell.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        cell.transform = CGAffineTransformIdentity;
        cell.alpha = 1;
    }];
    
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
