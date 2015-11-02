//
//  WTArticleViewController.m
//  WorldTravel
//
//  Created by Kent on 10/21/15.
//  Copyright © 2015 Kent Peifeng Ke. All rights reserved.
//

#import "WTArticleViewController.h"
#import "WTVerticalTextContainer.h"
#import "WTVerticalTextView.h"
#import "WTArticleView.h"

@interface WTArticleViewController ()

@end

@implementation WTArticleViewController{

    UITextView * _textView;
    
    NSTextStorage * _textStorage;
    
    BOOL _originalNavBarHidden;
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.automaticallyAdjustsScrollViewInsets = NO;
//        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}

-(CGFloat)DegreesToRadians:(CGFloat)degrees
{
    return degrees * M_PI / 180;
};

-(CGFloat)RadiansToDegrees:(CGFloat)radians
{
    return radians * 180 / M_PI;
};

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIEdgeInsets insert = UIEdgeInsetsMake(0, 0, 0, 20);
    
    WTArticleView * articleView = [[WTArticleView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame) + 20,
                                                                                  CGRectGetWidth(self.view.bounds),
                                                                                  CGRectGetHeight(self.view.bounds) - CGRectGetMaxY(self.navigationController.navigationBar.frame) - 40)];
    articleView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:articleView];
    articleView.contentSize = articleView.bounds.size;
    articleView.contentInset = insert;
    articleView.titleView.text = self.articleEntity.title;
    articleView.authorLabel.text = self.articleEntity.author;
    articleView.contentLabel.text = self.articleEntity.content;
    articleView.showsHorizontalScrollIndicator = NO;
    articleView.showsVerticalScrollIndicator = NO;
    
    
//    UIButton * backButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
//    backButton.frame = (CGRectMake(CGRectGetWidth(self.view.bounds) - 10 - 80, CGRectGetHeight(self.view.bounds) - 10 - 80, 80, 80));
//    [backButton setTitle:@"Back" forState:(UIControlStateNormal)];
//    [backButton addTarget:self action:@selector(backButtonTapped:) forControlEvents:(UIControlEventTouchUpInside)];
//    [self.view addSubview:backButton];
    
    
    CGSize buttonSize = CGSizeMake(40, 40);
    CGFloat innerSpacing = 10;
    
    CGFloat width = ((buttonSize.width + innerSpacing) * 3 - innerSpacing);
    UIView * toolbar = [[UIView alloc] initWithFrame:(CGRectMake(CGRectGetWidth(self.view.bounds) - width,
                                                                 CGRectGetHeight(self.view.bounds) - buttonSize.height,
                                                                 width, buttonSize.height))];
    

    toolbar.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:toolbar];
    
//    UIButton * previousButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
//    previousButton.frame = CGRectMake(0, 0, buttonSize.width, buttonSize.height);
//    [previousButton setImage:[UIImage imageNamed:@"icon-left"] forState:(UIControlStateNormal)];
//    [previousButton addTarget:self action:@selector(previousButtonTapped:) forControlEvents:(UIControlEventTouchUpInside)];
//    [toolbar addSubview:previousButton];
//    
//    UIButton * nextButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
//    nextButton.frame = CGRectMake((buttonSize.width + innerSpacing), 0, buttonSize.width, buttonSize.height);
//    [nextButton setImage:[UIImage imageNamed:@"icon-right"] forState:(UIControlStateNormal)];
//    [nextButton addTarget:self action:@selector(nextButtonTapped:) forControlEvents:(UIControlEventTouchUpInside)];
//    [toolbar addSubview:nextButton];
//    
//    
//    UIButton * favButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
//    favButton.frame = CGRectMake((buttonSize.width + innerSpacing) * 2, 0, buttonSize.width, buttonSize.height);
//    [favButton setImage:[UIImage imageNamed:@"icon-heart-empty"] forState:(UIControlStateNormal)];
//    [favButton setImage:[UIImage imageNamed:@"icon-heart-full"] forState:(UIControlStateSelected)];
//    [favButton addTarget:self action:@selector(favButtonTapped:) forControlEvents:(UIControlEventTouchUpInside)];
//    [toolbar addSubview:favButton];
    
    
//    self.navigationController.hidesBarsOnTap = YES;

    
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:(UIBarButtonItemStylePlain) target:self action:@selector(backButtonTapped:)];
    UIBarButtonItem * space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemFlexibleSpace) target:nil action:NULL];
    UIBarButtonItem * prevButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-left"]
                                                                    style:(UIBarButtonItemStylePlain)
                                                                   target:self action:@selector(previousButtonTapped:)];
    
    UIBarButtonItem * nextButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-right"]
                                                                    style:(UIBarButtonItemStylePlain)
                                                                   target:self action:@selector(nextButtonTapped:)];
    UIBarButtonItem * favButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-heart-empty"]
                                                                   style:(UIBarButtonItemStylePlain)
                                                                  target:self action:@selector(favButtonTapped:)];
    
    self.toolbarItems = @[backItem, space, prevButton, nextButton, favButton];
    self.navigationController.toolbarHidden = NO;

/*
    CGRect titleRect = [articleView.contentLabel.attributedText boundingRectWithSize:CGSizeMake(CGRectGetHeight(self.view.bounds), 9999)
                                                               options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin)
                                                               context:nil];
    
    UILabel * label = [[UILabel alloc] initWithFrame:titleRect];
    label.attributedText = articleView.contentLabel.attributedText;
    label.textColor = [UIColor blackColor];
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor blueColor];
//    [self.view addSubview:label];
    
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [scrollView addSubview:label];
    scrollView.contentSize = label.bounds.size;
    [self.view addSubview:scrollView];
 
    self.navigationController.hidesBarsOnTap = YES;
*/
    
//    self.navigationController.navigationBarHidden = YES;
    
/*
    UILabel * label = [[UILabel alloc] init];
    label.text = self.articleEntity.content;
    label.transform = CGAffineTransformMakeRotation([self DegreesToRadians:90.0]);
    label.frame = self.view.bounds;
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.baseWritingDirection = NSWritingDirectionRightToLeft;
    NSAttributedString * attrString = [[NSAttributedString alloc] initWithString:@"最好还是用CoreText去实现。CoreText的用法以后会介绍"
                                                                      attributes:@{NSParagraphStyleAttributeName: paragraphStyle, NSVerticalGlyphFormAttributeName:@(YES)}];
    label.attributedText = attrString;
    [self.view addSubview:label];
*/



//    NSString * path = [[NSBundle mainBundle] pathForResource:@"vertical-text" ofType:@"html"];
//    NSMutableString * html = [[NSMutableString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//    [html replaceOccurrencesOfString:@"$TITLE$" withString:self.articleEntity.title options:0 range:(NSMakeRange(0, html.length))];
//    [html replaceOccurrencesOfString:@"$AUTHOR$" withString:self.articleEntity.author options:0 range:(NSMakeRange(0, html.length))];
//    NSString * content = [self.articleEntity.content stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
//    [html replaceOccurrencesOfString:@"$CONTENT$" withString:content options:0 range:(NSMakeRange(0, html.length))];
//    
//    
//    UIWebView * webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
////    webView.delegate = self;
//    webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//
//    [self.view addSubview:webView];
//    
//    [webView loadHTMLString:html baseURL:nil];

    
/*
    _textStorage = [[NSTextStorage alloc] init];
    NSLayoutManager * layoutManager = [[NSLayoutManager alloc] init];
    [_textStorage addLayoutManager:layoutManager];
    
    NSTextContainer * textContainer = [[WTVerticalTextContainer alloc] initWithSize:self.view.bounds.size];
    [layoutManager addTextContainer:textContainer];
    
    _textView = [[UITextView alloc] initWithFrame:self.view.bounds textContainer:textContainer];
//    _textView = [[UITextView alloc] initWithFrame:self.view.bounds];
    _textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//    _textView.attributedText = [[NSAttributedString alloc] initWithString:self.articleEntity.content attributes:@{NSVerticalGlyphFormAttributeName:@(1)}];
    _textView.text = self.articleEntity.content;
    _textView.textAlignment = NSTextAlignmentCenter;
    _textView.editable = NO;
    
    [self.view addSubview:_textView];
*/
}

-(void)previousButtonTapped:(id)sender{

}

-(void)nextButtonTapped:(id)sender{
    
}


-(void)favButtonTapped:(id)sender{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _originalNavBarHidden = self.navigationController.navigationBarHidden;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:_originalNavBarHidden animated:YES];
}


-(void)backButtonTapped:(id)sender{

    [self.navigationController popViewControllerAnimated:YES];
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
