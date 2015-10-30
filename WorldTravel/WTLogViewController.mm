//
//  WTLogViewController.m
//  WorldTravel
//
//  Created by Kent on 10/12/15.
//  Copyright © 2015 Kent Peifeng Ke. All rights reserved.
//

#import "WTLogViewController.h"
#import "DDFileLogger.h"

@interface WTLogViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation WTLogViewController{

    BOOL _displayed;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    DDFileLogger * fileLogger;
    for (id<DDLogger> logger in [DDLog allLoggers]) {
        if ([logger isKindOfClass:[DDFileLogger class]]) {
            fileLogger = logger;
            break;
        }
    }
    
//    DDLogInfo(@"%@",@"-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\nYeah");
//    DDLogInfo(@"Hello");
    
    DDLogFileInfo * fileInfo = [fileLogger valueForKeyPath:@"currentLogFileInfo"];
    self.textView.text = [NSString stringWithContentsOfFile:fileInfo.filePath
                                                   encoding:(NSUTF8StringEncoding)
                                                      error:nil];
    
    
    
}

-(void)viewDidLayoutSubviews{

    [super viewDidLayoutSubviews];
    if (_displayed == NO) {
        
        [self.textView scrollRangeToVisible:(NSMakeRange(self.textView.text.length - 1, 1))];
        _displayed = YES;
    }
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
