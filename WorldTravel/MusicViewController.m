//
//  MusicViewController.m
//  WorldTravel
//
//  Created by Kent on 10/12/15.
//  Copyright © 2015 Kent Peifeng Ke. All rights reserved.
//

#import "MusicViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface MusicViewController ()<AVAudioSessionDelegate>

@end

@implementation MusicViewController{

    AVPlayer * _player;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.


    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)playButtonTapped:(id)sender {
    
//    [[AVAudioSession sharedInstance] setDelegate: self];
    
    NSError *myErr;
    
    // Initialize the AVAudioSession here.
    if (![[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&myErr]) {
        // Handle the error here.
        NSLog(@"Audio Session error %@, %@", myErr, [myErr userInfo]);
    }
    else{
        // Since there were no errors initializing the session, we'll allow begin receiving remote control events
        [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    }
    
    
    NSURL * url = [[NSBundle mainBundle] URLForResource:@"music" withExtension:@"mp3"];
    
    AVPlayerItem * item = [[AVPlayerItem alloc] initWithURL:url];
    _player = [[AVPlayer alloc] initWithPlayerItem:item];
    
    __weak MusicViewController * wSelf = self;
    [_player addPeriodicTimeObserverForInterval:(CMTimeMake(1, 1)) queue:NULL usingBlock:^(CMTime time) {
        [wSelf updateNowPlaying];
    }];
    [_player play];
    
    

}

-(void)updateNowPlaying{

    NSMutableDictionary * playingInfo = [NSMutableDictionary new];
    MPMediaItemArtwork * artwork = [[MPMediaItemArtwork alloc] initWithImage:[UIImage imageNamed:@"main.jpg"]];
    [playingInfo setValue:@"公路" forKey:MPMediaItemPropertyTitle];
    [playingInfo setValue:@"回归" forKey:MPMediaItemPropertyAlbumTitle];
    [playingInfo setValue:@"纵贯线" forKey:MPMediaItemPropertyAlbumArtist];
    [playingInfo setValue:artwork forKey:MPMediaItemPropertyArtwork];
    
    [playingInfo setValue:@(_player.currentItem.duration.value / _player.currentItem.duration.timescale) forKey:MPMediaItemPropertyPlaybackDuration];
    [playingInfo setValue:@(_player.currentTime.value / _player.currentTime.timescale) forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
    [playingInfo setValue:@(1.0) forKey:MPNowPlayingInfoPropertyDefaultPlaybackRate];
    
    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:playingInfo];
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
