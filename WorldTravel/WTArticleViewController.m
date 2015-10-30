//
//  WTArticleViewController.m
//  WorldTravel
//
//  Created by Kent on 10/21/15.
//  Copyright © 2015 Kent Peifeng Ke. All rights reserved.
//

#import "WTArticleViewController.h"
#import "WTVerticalTextContainer.h"

@interface WTArticleViewController ()

@end

@implementation WTArticleViewController{

    UITextView * _textView;
    
    NSTextStorage * _textStorage;
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
    

    NSString * path = [[NSBundle mainBundle] pathForResource:@"vertical-text" ofType:@"html"];
    NSMutableString * html = [[NSMutableString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [html replaceOccurrencesOfString:@"$TITLE$" withString:self.articleEntity.title options:0 range:(NSMakeRange(0, html.length))];
    [html replaceOccurrencesOfString:@"$AUTHOR$" withString:self.articleEntity.author options:0 range:(NSMakeRange(0, html.length))];
    NSString * content = [self.articleEntity.content stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
    [html replaceOccurrencesOfString:@"$CONTENT$" withString:content options:0 range:(NSMakeRange(0, html.length))];
    
    
    UIWebView * webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
//    webView.delegate = self;
    webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

    [self.view addSubview:webView];
    
    [webView loadHTMLString:html baseURL:nil];

    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
