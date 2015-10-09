//
//  ObserverViewController.m
//  WorldTravel
//
//  Created by Kent Peifeng Ke on 12/30/14.
//  Copyright (c) 2014 Kent Peifeng Ke. All rights reserved.
//

#import "ObserverViewController.h"

NSString * const ResultChangedNote = @"ResultChangedNote";
@interface DownloadTask()


@property (nonatomic, readwrite) float result;

@end
@implementation DownloadTask

-(void)setProgress:(float)progress{
    self.result = progress * 100;
//    [[NSNotificationCenter defaultCenter] postNotificationName:ResultChangedNote object:self];
}

@end
@interface ObserverViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ObserverViewController{
    DownloadTask * _task;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _task = [DownloadTask new];
    [_task addObserver:self forKeyPath:@"result" options:(NSKeyValueObservingOptionNew) context:NULL];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resultChanged:) name:ResultChangedNote object:nil];
}



-(void)resultChanged:(NSNotification *)note{
    dispatch_async(dispatch_get_main_queue(), ^{
        // Update the UI
        DownloadTask * task = note.object;
        self.label.text = [NSString stringWithFormat:@"%.2f%%", task.result];
        
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)goButtonTapped:(id)sender {
    
    dispatch_queue_t myQueue = dispatch_queue_create("My Queue",NULL);
    dispatch_async(myQueue, ^{
        // Perform long running process
        float max = 1000000.0;
        for (NSInteger i=0; i<max; i++) {
            _task.progress = i/max;
        }
        NSLog(@"over");

    });

}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{

    if (object == _task) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.label.text = [NSString stringWithFormat:@"%.2f%%", _task.result];
        });
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)progressValueChanged:(UISlider *)sender {
    _task.progress = sender.value;
}

-(void)dealloc{
    [_task removeObserver:self forKeyPath:@"result"];
}
@end
