//
//  CDView.m
//  CodeLibrary
//
//  Created by 辰 宫 on 14/11/18.
//  Copyright (c) 2014年 overmindgc. All rights reserved.
//

#import "CDView.h"
#import "CDLayerView.h"

@implementation CDView
{
    CGFloat photo_hight;
    CGFloat photo_center_hight;
    CGRect originFrame;
    CDLayerView *_cdLayerView;
}

@synthesize isRotating;
@synthesize cdImageName;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        originFrame = frame;
        cdImageName = @"album1";
        
        photo_hight = frame.size.width;
        photo_center_hight = photo_hight * 0.15;
        CGFloat radius = photo_hight / 2;
        
        //设置view的图层参数
        self.layer.cornerRadius = radius;
        self.layer.masksToBounds = YES;
        
        //设置view的图层参数
        _cdLayerView = [[CDLayerView alloc] initWithFrame:frame];
        _cdLayerView.photo_hight = photo_hight;
        _cdLayerView.photo_center_hight = photo_center_hight;
        _cdLayerView.cdImageName = cdImageName;
        _cdLayerView.layer.position = CGPointMake(photo_hight/2, photo_hight/2);
        _cdLayerView.layer.cornerRadius = radius;
        _cdLayerView.layer.masksToBounds = YES;
        _cdLayerView.layer.borderColor = [UIColor whiteColor].CGColor;
        _cdLayerView.layer.borderWidth = 2;
        [self addSubview:_cdLayerView];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//}

- (void)changeNextWithImageName:(NSString *)newImgName
{
    cdImageName = newImgName;
    _cdLayerView.cdImageName = cdImageName;
    
    [self changeCDAnimation];
}

- (void)rotateStart
{
    //判断是否已经常见过动画，如果已经创建则不再创建动画
    CAAnimation *animation = [_cdLayerView.layer animationForKey:@"KCBasicAnimation_Rotation"];
    if(animation){
        if (_cdLayerView.layer.speed == 0) {
            [self animationResume];
        }
    }else{
        //创建并开始动画
        [self rotationAnimation];
    }
}

- (void)rotateStop
{
    if (_cdLayerView.layer.speed != 0) {
        [self animationPause];
    }
}

#pragma mark layer的代理方法，绘制图形、图像到图层，注意参数中的ctx是图层的图形上下文，其中绘图位置也是相对图层而言的
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    _cdLayerView.cdImageName = cdImageName;
    [_cdLayerView.layer setNeedsDisplay];
}

#pragma mark 点击事件
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
}

#pragma mark 移动动画
- (void)changeCDAnimation{
    CGPoint location = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT);
    //方法1：block方式
    /*开始动画，UIView的动画方法执行完后动画会停留在重点位置，而不需要进行任何特殊处理
     duration:执行时间
     delay:延迟时间
     options:动画设置，例如自动恢复、匀速运动等
     completion:动画完成回调方法
     */
    [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.layer.position = location;
        self.layer.opacity = 0;
    } completion:^(BOOL finished) {
        self.layer.position = location;
        [_cdLayerView.layer setNeedsDisplay];
        [self showAnimation];
    }];
}

- (void)showAnimation{
    CGPoint location = CGPointMake(SCREEN_WIDTH/2, originFrame.origin.y + originFrame.size.height/2);
    //方法1：block方式
    /*开始动画，UIView的动画方法执行完后动画会停留在重点位置，而不需要进行任何特殊处理
     duration:执行时间
     delay:延迟时间
     options:动画设置，例如自动恢复、匀速运动等
     completion:动画完成回调方法
     */
    [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.layer.position = location;
        self.layer.opacity = 1;
    } completion:^(BOOL finished) {
        [self.delegate changeCDAmimationAccomplished];
    }];
}

#pragma mark 旋转动画
- (void)rotationAnimation{
    //1.创建动画并指定动画属性
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    //2.设置动画属性初始值、结束值
    //    basicAnimation.fromValue=[NSNumber numberWithInt:M_PI_2];
    basicAnimation.toValue = [NSNumber numberWithFloat:M_PI_2*4];
    
    //设置其他动画属性
    basicAnimation.duration = 5.0;
    basicAnimation.repeatCount = HUGE_VALF;//设置无限循环
    basicAnimation.removedOnCompletion = YES;
    
    //4.添加动画到图层，注意key相当于给动画进行命名，以后获得该动画时可以使用此名称获取
    [_cdLayerView.layer addAnimation:basicAnimation forKey:@"KCBasicAnimation_Rotation"];
    isRotating = YES;
}

#pragma mark 动画暂停
- (void)animationPause{
    //取得指定图层动画的媒体时间，后面参数用于指定子图层，这里不需要
    CFTimeInterval interval = [_cdLayerView.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    //设置时间偏移量，保证暂停时停留在旋转的位置
    [_cdLayerView.layer setTimeOffset:interval];
    //速度设置为0，暂停动画
    _cdLayerView.layer.speed = 0;
    isRotating = NO;
}

#pragma mark 动画恢复
- (void)animationResume{
    //获得暂停的时间
    CFTimeInterval beginTime = CACurrentMediaTime() - _cdLayerView.layer.timeOffset;
    //设置偏移量
    _cdLayerView.layer.timeOffset = 0;
    //设置开始时间
    _cdLayerView.layer.beginTime = beginTime;
    //设置动画速度，开始运动
    _cdLayerView.layer.speed = 1.0;
    isRotating = YES;
}


@end
