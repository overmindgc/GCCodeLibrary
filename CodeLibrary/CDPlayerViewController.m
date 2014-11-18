//
//  CDPlayerViewController.m
//  CodeLibrary
//
//  Created by 辰 宫 on 14/11/18.
//  Copyright (c) 2014年 overmindgc. All rights reserved.
//

#import "CDPlayerViewController.h"
#import "AlbumBackgroundView.h"
#import "CDView.h"

@interface CDPlayerViewController ()

@property (nonatomic,strong) CDView *cdView;
@property (nonatomic,strong) AVAudioPlayer *avAudioPlayer;//播放器player
@property (nonatomic,strong) UIButton *btnPlayPause;
@property (nonatomic,strong) UIProgressView *progressV;//播放进度
@property (nonatomic,strong) NSTimer *timer;//监控音频播放进度

@end

@implementation CDPlayerViewController

@synthesize cdView;
@synthesize avAudioPlayer;
@synthesize btnPlayPause;
@synthesize progressV;
@synthesize timer;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 60, 30)];
    closeBtn.backgroundColor = [UIColor orangeColor];
    [closeBtn setTitle:@"Close" forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    
    AlbumBackgroundView *bgView = [[AlbumBackgroundView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bgView.bgImageName = @"album";
    [self.view insertSubview:bgView atIndex:0];
    
    float CDWidth = SCREEN_WIDTH - 100;
    cdView = [[CDView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - CDWidth/2, 100, CDWidth, CDWidth)];
    cdView.cdImageName = @"album";
    [self.view addSubview:cdView];
    
    
    //初始化button
    btnPlayPause = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnPlayPause setFrame:CGRectMake(SCREEN_WIDTH/2 - 40/2, SCREEN_HEIGHT - 80, 40, 40)];
    [btnPlayPause setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    [btnPlayPause addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnPlayPause];
    
    //初始化一个播放进度条
    float progressWidth = CDWidth - 20;
    progressV = [[UIProgressView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - progressWidth/2, SCREEN_HEIGHT - 110, progressWidth, 20)];
    [progressV setProgressViewStyle:UIProgressViewStyleDefault];
    //更改进度条高度
    progressV.transform = CGAffineTransformMakeScale(1.0f,1.5f);
    [progressV setTrackTintColor:[UIColor colorWithWhite:0.4 alpha:1]];
    [progressV setProgressTintColor:[UIColor whiteColor]];
    [self.view addSubview:progressV];
    
    //用NSTimer来监控音频播放进度
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self
                                           selector:@selector(playProgress)
                                           userInfo:nil repeats:YES];
    
    
    //从budle路径下读取音频文件　　轻音乐 - 萨克斯回家 这个文件名是你的歌曲名字,mp3是你的音频格式
    NSString *string = [[NSBundle mainBundle] pathForResource:@"Try-ColbieCaillat" ofType:@"mp3"];
    //把音频文件转换成url格式
    NSURL *url = [NSURL fileURLWithPath:string];
    //初始化音频类 并且添加播放文件
    avAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    //设置代理
    avAudioPlayer.delegate = self;
    
    //设置初始音量大小
    avAudioPlayer.volume = 1.0f;
    
    //设置音乐播放次数  -1为一直循环
    avAudioPlayer.numberOfLoops = -1;
    
    //预播放
    [avAudioPlayer prepareToPlay];
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

#pragma mark 点击事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    [cdView routeStartOrStop];
}


//播放
- (void)play
{
    if (avAudioPlayer.playing == YES) {
        [avAudioPlayer pause];
        [btnPlayPause setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    } else {
        [avAudioPlayer play];
        [btnPlayPause setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    }
    [cdView routeStartOrStop];
}

//停止
- (void)stop
{
    avAudioPlayer.currentTime = 0;  //当前播放时间设置为0
    [avAudioPlayer stop];
}

//播放进度条
- (void)playProgress
{
    //通过音频播放时长的百分比,给progressview进行赋值;
    progressV.progress = avAudioPlayer.currentTime/avAudioPlayer.duration;
//    NSLog(@"总长：%f 当前：%f",avAudioPlayer.duration,avAudioPlayer.currentTime);
}

//播放完成时调用的方法  (代理里的方法),需要设置代理才可以调用
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [timer invalidate]; //NSTimer暂停   invalidate  使...无效;
}


- (void) closeAction
{
    [avAudioPlayer stop];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
