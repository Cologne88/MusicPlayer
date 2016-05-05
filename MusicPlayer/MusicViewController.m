//
//  MusicViewController.m
//  MusicPlayer
//
//  Created by 欲往无处去相逢 on 16/4/20.
//  Copyright © 2016年 Macbook. All rights reserved.
//

#import "MusicViewController.h"
#import "UISlider+touch.h"
#import <AVFoundation/AVFoundation.h>
@interface MusicViewController ()<AVAudioPlayerDelegate>{
    
}
@property  (nonatomic) AVAudioPlayer *player;
@property(nonatomic) UISlider * slider;
@property (nonatomic ) UIImageView *imgview;
@end

@implementation MusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUserView];
    
}


- (AVAudioPlayer *)player{
    if (_player ==nil) {
        NSString *urlString = [[NSBundle mainBundle]  pathForResource:@"花火" ofType:@"mp3"];
        NSURL *url =[NSURL  fileURLWithPath:urlString];
        NSError *error = nil;
        _player  =[[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        _player.volume =0.5;
        _player.delegate =self;
        if (error) {
            NSLog(@"%@  播放失败",error);
        }
        NSLog(@"zz");
    }

    return _player;
}

//Create a slider
- (UISlider *)slider{
    if (_slider ==nil) {
        
        _slider  = [[UISlider alloc] initWithFrame:CGRectMake(50, 300, 300, 20)];
        _slider.value =  0.5;
        _slider.maximumValue = 1.0;
        _slider.minimumValue = 0;
        _slider.minimumTrackTintColor =[UIColor grayColor];
        _slider.maximumTrackTintColor =[UIColor  redColor];
        _slider.thumbTintColor = [UIColor greenColor];
        [_slider addTapGestureWithTarget:self action:@selector(sliderChange)];
        [_slider addTarget:self action:@selector(sliderChange) forControlEvents:UIControlEventValueChanged];
        
        [self.view addSubview:_slider];
        
    }
    return _slider;
}

- (void)sliderChange{
    self.player.volume = self.slider.value;
}

//Create an imgview
- (UIImageView *)imgview{
    if (_imgview==nil) {
        
        _imgview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"贝贝.jpg"]];
        _imgview.frame = CGRectMake(50, 350, 300, 300);
        [self.view addSubview:_imgview];
        
    }
    return _imgview;
}




- (void)loadUserView{
    self.view.backgroundColor = [UIColor colorWithRed:255/255.0 green:182/255.0 blue:203/255.0 alpha:1];
    UIButton * buttonPlay = [UIButton  buttonWithType:UIButtonTypeCustom];
    [buttonPlay  setTitle:@"PLAY" forState:UIControlStateNormal];
    [buttonPlay setFrame:CGRectMake(50, 100, 100, 100)];
    [buttonPlay addTarget:self action:@selector(buttonplay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonPlay];
    
    UIButton *buttonPause = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonPause setTitle:@"Pause" forState:UIControlStateNormal];
    [buttonPause addTarget:self action:@selector(buttonpause) forControlEvents:UIControlEventTouchUpInside];
    [buttonPause setFrame:CGRectMake(160, 100, 100, 100)];
    [self.view addSubview:buttonPause];
    
    UIButton *buttonStop = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonStop setTitle:@"Stop" forState:UIControlStateNormal];
    [buttonStop setFrame:CGRectMake(270, 100, 100, 100)];
    [buttonStop addTarget:self action:@selector(buttonstop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonStop];
    
    [self slider];
    [self imgview];
    
}
- (void)buttonplay{
    [self.player play];
    
}
- (void)buttonpause{
    [self.player pause];
}

- (void)buttonstop{
    [self.player stop];
}

#pragma - AVAudioPlayerDelegate代理方法
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    NSLog(@"播放完毕调用");
}
- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player{
    NSLog(@"中断前调用");
}



@end
