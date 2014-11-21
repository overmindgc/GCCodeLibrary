//
//  CDPlayerViewController.h
//  CodeLibrary
//
//  Created by 辰 宫 on 14/11/18.
//  Copyright (c) 2014年 overmindgc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "CDView.h"

@interface CDPlayerViewController : UIViewController <AVAudioPlayerDelegate,CDViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btnPlayPause;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;
@property (weak, nonatomic) IBOutlet UIProgressView *progressV;//播放进度
@property (weak, nonatomic) IBOutlet UIButton *btnLast;
@property (weak, nonatomic) IBOutlet UILabel *labelProgressTime;
@property (weak, nonatomic) IBOutlet UILabel *labelTotalTime;
@property (nonatomic,strong) UILabel *labelTitle;

@end
