//
//  CDPlayerViewController.m
//  CodeLibrary
//
//  Created by 辰 宫 on 14/11/18.
//  Copyright (c) 2014年 overmindgc. All rights reserved.
//

#import "CDPlayerViewController.h"
#import "AlbumBackgroundView.h"

@interface CDPlayerViewController ()
{
    NSArray *musicArray;
    NSInteger currentMusicIndex;
}

@property (nonatomic,strong) CDView *cdView;
@property (nonatomic,strong) AlbumBackgroundView *bgView;
@property (nonatomic,strong) AVAudioPlayer *avAudioPlayer;//播放器player
@property (nonatomic,strong) NSTimer *timer;//监控音频播放进度

@end

@implementation CDPlayerViewController

@synthesize cdView;
@synthesize bgView;
@synthesize avAudioPlayer;
@synthesize btnPlayPause,btnLast,btnNext;
@synthesize progressV;
@synthesize labelProgressTime,labelTotalTime,labelTitle;
@synthesize timer;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置屏幕常亮
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
    musicArray = @[@"Deemo",@"Waltzing Leaves",@"Try-Colbie Caillat"];
    
    // Do any additional setup after loading the view from its nib.
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 18, 60, 30)];
    closeBtn.backgroundColor = [UIColor orangeColor];
    [closeBtn setTitle:@"Close" forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    
    //更改进度条高度
//    progressV.transform = CGAffineTransformMakeScale(1.0f,2.0f);
    
    currentMusicIndex = 0;
    
    bgView = [[AlbumBackgroundView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bgView.bgImageName = [musicArray objectAtIndex:currentMusicIndex];
    [self.view insertSubview:bgView atIndex:0];
    
    float CDWidth = SCREEN_WIDTH - 100;
    float CD_Y = SCREEN_HEIGHT/2.2 - CDWidth/2;
    cdView = [[CDView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - CDWidth/2, CD_Y, CDWidth, CDWidth)];
    cdView.delegate = self;
    cdView.cdImageName = [musicArray objectAtIndex:currentMusicIndex];
    [self.view insertSubview:cdView aboveSubview:bgView];
    [cdView.layer setNeedsDisplay];
    
    float titleY = cdView.frame.origin.y - CDWidth * 0.3;
    labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - (SCREEN_WIDTH - 50)/2, titleY, SCREEN_WIDTH - 50, 50)];
    labelTitle.text = [musicArray objectAtIndex:currentMusicIndex];
    labelTitle.textColor = [UIColor whiteColor];
    labelTitle.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:labelTitle];
    
    
    //用NSTimer来监控音频播放进度
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self
                                           selector:@selector(playProgress)
                                           userInfo:nil repeats:YES];
    
    
    [self createAvAudioPlayerWithName:[musicArray objectAtIndex:currentMusicIndex]];
    
    [self addGesture];
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

#pragma mark 添加手势
-(void)addGesture
{
    /*添加点按手势*/
    //创建手势对象
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnView:)];
    //设置手势属性
    tapGesture.numberOfTapsRequired = 2;//设置点按次数，默认为1，注意在iOS中很少用双击操作
    tapGesture.numberOfTouchesRequired = 1;//点按的手指数
    //添加手势到对象(注意，这里添加到了控制器视图中，而不是图片上，否则点击空白无法隐藏导航栏)
    [self.view addGestureRecognizer:tapGesture];
    
    /*添加拖动手势*/
//    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panOnView:)];
//    [self.view addGestureRecognizer:panGesture];
    
    /*添加轻扫手势*/
    //注意一个轻扫手势只能控制一个方向，默认向右，通过direction进行方向控制
    UISwipeGestureRecognizer *swipeGestureToRight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeOnView:)];
    //swipeGestureToRight.direction=UISwipeGestureRecognizerDirectionRight;//默认为向右轻扫
    [self.view addGestureRecognizer:swipeGestureToRight];
    
    UISwipeGestureRecognizer *swipeGestureToLeft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeOnView:)];
    swipeGestureToLeft.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeGestureToLeft];
}

#pragma mark 远程控制事件
-(void)remoteControlReceivedWithEvent:(UIEvent *)event{
//    NSLog(@"%i,%li",event.type,event.subtype);
    if(event.type==UIEventTypeRemoteControl){
        switch (event.subtype) {
            case UIEventSubtypeRemoteControlPlay:
                [self playOrPause];
                break;
            case UIEventSubtypeRemoteControlTogglePlayPause:
                [self playOrPause];
                break;
            case UIEventSubtypeRemoteControlNextTrack:
                NSLog(@"Next...");
                [self playNext];
                break;
            case UIEventSubtypeRemoteControlPreviousTrack:
                NSLog(@"Previous...");
                [self playLast];
                break;
            case UIEventSubtypeRemoteControlBeginSeekingForward:
                NSLog(@"Begin seek forward...");
                break;
            case UIEventSubtypeRemoteControlEndSeekingForward:
                NSLog(@"End seek forward...");
                break;
            case UIEventSubtypeRemoteControlBeginSeekingBackward:
                NSLog(@"Begin seek backward...");
                break;
            case UIEventSubtypeRemoteControlEndSeekingBackward:
                NSLog(@"End seek backward...");
                break;
            default:
                break;
        }
    }
}

#pragma mark - 手势操作
#pragma mark 双击暂停播放
- (void)tapOnView:(UITapGestureRecognizer *)gesture{
    [self playOrPause];
}

#pragma mark 拖动控制进度和音量
//- (void)panOnView:(UIPanGestureRecognizer *)gesture{
//    CGPoint translation = [gesture translationInView:self.view];//利用拖动手势的translationInView:方法取得在相对指定视图（这里是控制器根视图）的移动
//    if (gesture.state == UIGestureRecognizerStateChanged) {
//
//    } else if (gesture.state == UIGestureRecognizerStateEnded) {
//        
//    }
//}

#pragma mark 轻扫则查看下一张或上一张
//注意虽然轻扫手势是连续手势，但是只有在识别结束才会触发，不用判断状态
-(void)swipeOnView:(UISwipeGestureRecognizer *)gesture{
    float increase = 20.0f;
    //direction记录的轻扫的方向
    if (gesture.direction==UISwipeGestureRecognizerDirectionRight) {//向右
        if (avAudioPlayer.currentTime + increase > avAudioPlayer.duration) {
            avAudioPlayer.currentTime = avAudioPlayer.duration - 1;
        } else {
            avAudioPlayer.currentTime = avAudioPlayer.currentTime + increase;
        }
    }else if(gesture.direction==UISwipeGestureRecognizerDirectionLeft){//向左
        avAudioPlayer.currentTime = avAudioPlayer.currentTime - increase;
    }
}

#pragma mark 点击事件
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    avAudioPlayer.currentTime = avAudioPlayer.duration - 5;
}

#pragma mark CDViewDelegate
- (void)changeCDAmimationAccomplished
{
    if (cdView.isRotating == YES) {
        [btnPlayPause setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
        [self playOrPause];
    } else {
        [btnPlayPause setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    }
}

- (void)createAvAudioPlayerWithName:(NSString *)musicName
{
    
    //从budle路径下读取音频文件 这个文件名是你的歌曲名字,mp3是你的音频格式
    NSString *string = [[NSBundle mainBundle] pathForResource:musicName ofType:@"mp3"];
    //把音频文件转换成url格式
    NSURL *url = [NSURL fileURLWithPath:string];
    //初始化音频类 并且添加播放文件
    avAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    //设置代理
    avAudioPlayer.delegate = self;
    
    //设置初始音量大小
    avAudioPlayer.volume = 1.0f;
    
    //设置音乐播放次数  -1为一直循环
    avAudioPlayer.numberOfLoops = 0;
    
    //预播放
    [avAudioPlayer prepareToPlay];
}


- (IBAction)playAction:(id)sender {
    [self playOrPause];
}

- (IBAction)lastAction:(id)sender {
    [self playLast];
}

- (IBAction)nextAction:(id)sender {
    [self playNext];
}


//播放/暂停
- (void)playOrPause
{
    if (avAudioPlayer.playing == YES) {
        [avAudioPlayer pause];
        [btnPlayPause setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        [cdView rotateStop];
    } else {
        [avAudioPlayer play];
        labelTotalTime.text = [self stringWithMinuteAndSecond:avAudioPlayer.duration];
        [btnPlayPause setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
        [cdView rotateStart];
    }
}

- (void)playLast
{
    if (currentMusicIndex == 0) {
        currentMusicIndex = musicArray.count - 1;
    } else {
        currentMusicIndex--;
    }
    [cdView changeNextWithImageName:[musicArray objectAtIndex:currentMusicIndex]];
    [bgView changeAlbumWithImageName:[musicArray objectAtIndex:currentMusicIndex]];
    labelTitle.text = [musicArray objectAtIndex:currentMusicIndex];
    [self resumeViewState];
    [self createAvAudioPlayerWithName:[musicArray objectAtIndex:currentMusicIndex]];
    
}

- (void)playNext
{
    if (currentMusicIndex == musicArray.count -1) {
        currentMusicIndex = 0;
    } else {
        currentMusicIndex++;
    }
    [cdView changeNextWithImageName:[musicArray objectAtIndex:currentMusicIndex]];
    [bgView changeAlbumWithImageName:[musicArray objectAtIndex:currentMusicIndex]];
    labelTitle.text = [musicArray objectAtIndex:currentMusicIndex];
    [self resumeViewState];
    [self createAvAudioPlayerWithName:[musicArray objectAtIndex:currentMusicIndex]];
}

//停止
- (void)stop
{
    avAudioPlayer.currentTime = 0;  //当前播放时间设置为0
    [avAudioPlayer stop];
}

//重置视图状态
- (void)resumeViewState
{
    progressV.progress = 0.0;
    labelProgressTime.text = @"00:00";
    labelTotalTime.text = @"00:00";
    [self stop];
}

//播放进度条
- (void)playProgress
{
    //通过音频播放时长的百分比,给progressview进行赋值;
    progressV.progress = avAudioPlayer.currentTime/avAudioPlayer.duration;
    labelProgressTime.text = [self stringWithMinuteAndSecond:avAudioPlayer.currentTime];
//    NSLog(@"总长：%f 当前：%f",avAudioPlayer.duration,avAudioPlayer.currentTime);
}

#pragma mark AVAudioPlayerDelegate
//播放完成时调用的方法  (代理里的方法),需要设置代理才可以调用
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self playNext];
}

//根据秒数取得 分钟：秒 格式字符串
- (NSString *)stringWithMinuteAndSecond:(float)duration
{
    //根据秒数，创建一个从零开始的日期
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:duration];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:confromTimesp];
    NSDate *localeDate = [confromTimesp  dateByAddingTimeInterval: interval];
    
    //只取分钟和秒
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"mm:ss"];  // 格式化时间NSDate
    NSString *stringFromDate = [formatter stringFromDate:localeDate];
    return stringFromDate;
}

- (void) closeAction
{
    //关闭屏幕常亮
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    [self stop];
    [timer invalidate];//NSTimer暂停   invalidate  使...无效;
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
