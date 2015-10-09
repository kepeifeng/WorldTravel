//
//  EmptyButtonViewController.m
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 14/11/7.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import "EmptyButtonViewController.h"

static int VCCount = 1;
@interface EmptyButtonViewController ()

@end

@implementation EmptyButtonViewController{

    NSString * _name;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"Hello";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    NSLog(@"Hi, I am the real viewDidLoad");
    _name = [NSString stringWithFormat:@"%d号", VCCount];
    VCCount++;
    NSArray * colors = @[[UIColor colorWithRed:0.850 green:0.218 blue:0.159 alpha:1.000],
                         [UIColor colorWithRed:0.977 green:0.605 blue:0.000 alpha:1.000],
                         [UIColor colorWithRed:0.986 green:0.780 blue:0.000 alpha:1.000],
                         [UIColor colorWithRed:0.595 green:0.750 blue:0.000 alpha:1.000],
                         [UIColor colorWithRed:0.182 green:0.694 blue:0.530 alpha:1.000],
                         [UIColor colorWithRed:0.190 green:0.358 blue:0.438 alpha:1.000],
                         [UIColor colorWithRed:0.669 green:0.731 blue:0.949 alpha:1.000]];
    
    SharedLabel* view = [SharedLabel new];
    view.frame = (CGRectMake(10, 10, 300, 150));
    view.backgroundColor = [colors objectAtIndex:arc4random_uniform(colors.count-1)];
    view.text = _name;
    self.sharedView = view;
    [self.view addSubview:self.sharedView];
    
//    self.navigationController.navigationBarHidden = !self.navigationController.navigationBarHidden;

    
//    _labelStatus = [LabelStatus new];
//    _labelStatus.frame = (CGRectMake(10, 10, 300, 150));
//    _labelStatus.backgroundColor = [colors objectAtIndex:arc4random_uniform(colors.count-1)];
//    _labelStatus.text = _name;
    
//    _labelStatus.textAlignment = NSTextAlignmentCenter;
//    _labelStatus.font = [UIFont systemFontOfSize:64];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"%@ DID APPEAR", _name);
//    [self.view addSubview:self.sharedView];
    
    NSLog(@"%@ 还原", _name);
    
    [self.sharedView viewDidAppear];
    if ([_name isEqualToString:self.sharedView.text] == NO) {
        NSLog(@"WRONG!!!!");
    }
}
- (IBAction)navBarToggle:(id)sender {
    self.navigationController.navigationBarHidden = !self.navigationController.navigationBarHidden;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"%@ WILL APPEAR", _name);
    
    
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"%@ WILL DISAPPEAR", _name);
    
    NSLog(@"%@ 保存", _name);
    [self.sharedView viewDidDisappear];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSLog(@"%@ DID DISAPPEAR", _name);
    

}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
//    NSLog(@"%@ DID LayoutSubViews", _name);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)goNextButtonTapped:(id)sender {
    EmptyButtonViewController * viewController =[[[self class] alloc] init];
//    viewController.sharedView = self.sharedView;
    viewController.title = [NSString stringWithFormat:@"%@o",self.title];
    [self.navigationController pushViewController:viewController animated:YES];
}
- (IBAction)goWithNameButtonTapped:(id)sender {
    
    self.navigationItem.backBarButtonItem.title = self.title;
    [self goNextButtonTapped:sender];
}
- (IBAction)mapSizeToggle:(UIButton *)sender {
    sender.selected = !sender.selected;
    CGRect shareViewRect = self.sharedView.frame;
    if (sender.selected) {
        shareViewRect.size.width /=2;
    }else{
        shareViewRect.size.width *=2;
    
    }
    
    self.sharedView.frame = shareViewRect;
    
}

-(NSString *)randomName{
    NSArray * array = @[@"苏轼",	@"孙逖",	@"苏廷",	@"司空曙",	@"诗经",	@"僧志南",	@"宋之问",	@"沈佺期",
                        @"司马光",	@"沈括",	@"司马图",	@"苏舜钦",	@"宋无名氏",	@"邵雍",	@"沈雁冰",	@"司马相如",
                        @"宋子侯",	@"苏武",	@"孙绰",	@"沈约",	@"隋无名氏",	@"孙万寿",	@"僧皎然",	@"上官仪",
                        @"神秀",	@"神赞",	@"师鼐",	@"施肩吾",	@"拾得",	@"司空图",	@"苏廷硕",	@"苏味道",
                        @"孙光宪",	@"沈与求",	@"宋祁",	@"苏辙",	@"石孝友",	@"史达祖",	@"蜀妓",	@"孙道绚",
                        @"萨都剌",	@"商挺",	@"守常",	@"孙周卿",	@"塞尔赫",	@"沈德潜",	@"施闰章",	@"释宗渭",
                        @"舒位",	@"宋琬",	@"宋湘",	@"孙枝蔚",	@"上官昭容",	@"宋若华",	@"宋若昭",	@"宋若宪",
                        @"苏颋",	@"沈彬",	@"僧贯休",	@"僧齐己",	@"僧子兰",	@"孙鲂",	@"沈叔安",	@"苏瑰",
                        @"邵大震",	@"宋璟璟",	@"邵升",	@"史俊",	@"司马逸客",	@"宋务光",	@"孙佺",	@"苏晋",
                        @"宋鼎",	@"孙翃",	@"苏绾",	@"沈如筠",	@"孙处玄",	@"史青",	@"厍狄履温",	@"宋昱",
                        @"孙昌胤",	@"沈宇",	@"沈颂",	@"孙欣",	@"苏寓",	@"苏源明",	@"沈东美",	@"苏涣",
                        @"宋华",	@"沈千运",	@"史延",	@"沈回",	@"苏易简",	@"沈邈",	@"石延年",	@"沈唐",
                        @"苏氏",	@"沈注",	@"寿涯禅师",	@"孙洙",	@"孙浩然",	@"舒氏",	@"舒亶",	@"苏琼",
                        @"时彦",	@"邵伯温",	@"苏庠",	@"司马槱",	@"沈蔚",	@"孙觌",	@"邵博",	@"沈晦",
                        @"宋齐愈",	@"宋江",	@"苏仲及",	@"邵叔齐",	@"石耆翁",	@"史远道",	@"孙惔",	@"孙舣",
                        @"施酒监",	@"僧儿",	@"邵缉",	@"史浩",	@"邵某",	@"石安民",	@"邵伯雍",	@"石敦夫",
                        @"沈瀛",	@"沈端节",	@"邵怀英",	@"舒邦佐",	@"苏十能",	@"宋先生",	@"史弥巩",	@"孙居敬",
                        @"孙惟信",	@"苏泂",	@"苏茂一",	@"史愚",	@"宋自道",	@"宋自逊",	@"沈刚孙",	@"史隽之",
                        @"史可堂",	@"孙吴会",	@"施枢",	@"施乘之",	@"松洲",	@"石正伦",	@"史铸",	@"施岳",
                        @"史深",	@"宋德广",	@"施翠岩",	@"史介翁",	@"蜀中妓",	@"孙锐",	@"沈钦",	@"宋丰之",
                        @"孙夫人",	@"石麟",	@"邵桂子",	@"三槐",	@"沈明叔",	@"苏小娘",	@"申二官人",	@"双渐",
                        @"宋媛",	@"随车娘子",	@"善珍",	@"沈长卿",	@"沈伯文",	@"邵元实",	@"申国章",	@"史佐尧",
                        @"沈元实",	@"沈仲昌",	@"邵真",	@"邵偃",	@"邵楚苌",	@"沈传师",	@"宋济",	@"孙叔向",
                        @"苏郁",	@"舒元舆",	@"沈亚之",	@"石贯",	@"司马扎",	@"孙纬",	@"司马都",	@"邵谒",
                        @"孙蜀",	@"孙偓",	@"孙郃",	@"沈颜",	@"孙定",	@"苏拯",	@"孙棨",	@"宋齐丘",
                        @"孙岘",	@"孙元晏",	@"沈麟",	@"孙咸",	@"宋雍",	@"沈祖仙",	@"邵士彦",	@"沈徽",
                        @"石召",	@"石殷士",	@"孙顾",	@"孙頠",	@"叔孙玄观",	@"石倚",	@"宋迪",	@"沈鹏",
                        @"苏广文",	@"孙氏",	@"慎氏",	@"谁氏女",	@"史凤",	@"僧凤",	@"释泚",	@"善生",
                        @"僧鸾",	@"神颖",	@"尚颜",	@"释彪",	@"尚能",	@"水心寺僧",	@"神迥",	@"司马承祯",
                        @"司马退之",	@"舒道纪",	@"孙思邈",	@"申欢",	@"沈廷瑞",	@"嵩岳诸仙",	@"蜀酒阁道",	@"上元夫人",
                        @"蜀宫群仙",	@"嵩山女",	@"水府君",	@"水神",	@"释明解",	@"书生",	@"沈青箱",	@"商山三丈",
                        @"石恪",	@"商山客死",	@"沙碛女子",	@"苏检妻",	@"苏检",	@"少年",	@"孙长史女",	@"石季武",
                        @"省吏",	@"释元康",	@"石抱忠",	@"邵景",	@"石惠泰",	@"史思明",	@"孙子多",	@"苏芸",
                        @"商则",	@"僧法轨",	@"宋元素",	@"沈会宗",	@"沈禧",	@"苏大年",	@"束从周",	@"舒逊",
                        @"邵亨贞",	@"石岩",	@"沈景高",	@"孙景文",	@"善住",	@"山主",	@"孙不二",	@"史药房",
                        @"施可道",	@"宋远",	@"宋德方",	@"三于真人",	@"沈泓",	@"沈谦",	@"释敬安",	@"沈曾植",
                        @"宋濂",	@"释德韶",	@"释志端",	@"沈惟肖",	@"苏文饶",	@"宋白",	@"孙仅",	@"沈明臣",
                        @"孙承宗",	@"石达开",	@"苏麟",	@"宋真宗",	@"僧志文",	@"苏曼殊",	@"孙原湘",	@"孙中山",
                        @"孙楚",	@"石崇",	@"苏蕙"];
    
    return [array objectAtIndex:arc4random_uniform(array.count-1)];
    
}
- (IBAction)changeTextButtonTapped:(id)sender {

    NSString * oldName = _name;
    _name = [self randomName];
    self.sharedView.text = _name;
    NSLog(@"%@ changed to %@", oldName, _name);
}

-(void)dealloc{
    NSLog(@"EmptyButtonViewController dealloc");
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
