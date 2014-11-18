//
//  AnimationBaseViewController.m
//  CodeLibrary
//
//  Created by 辰 宫 on 14/11/11.
//  Copyright (c) 2014年 overmindgc. All rights reserved.
//

#import "AnimationBaseViewController.h"
#define PHOTO_HEIGHT 200
#define PHOTO_CENTER_HEIGHT 30

@interface AnimationBaseViewController (){
    CALayer *_layer;
}


@end

@implementation AnimationBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 60, 30)];
    closeBtn.backgroundColor = [UIColor orangeColor];
    [closeBtn setTitle:@"Close" forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];

    self.view.backgroundColor = [UIColor orangeColor];
    
    
    CGPoint position= CGPointMake(160, 200);
    CGRect bounds=CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT);
    CGFloat cornerRadius=PHOTO_HEIGHT/2;
    CGFloat borderWidth=2;
    
    //阴影图层
    CALayer *layerShadow=[[CALayer alloc]init];
    layerShadow.bounds=bounds;
    layerShadow.position=position;
    layerShadow.cornerRadius=cornerRadius;
    layerShadow.shadowColor=[UIColor darkGrayColor].CGColor;
    layerShadow.shadowOffset=CGSizeMake(3, 1);
    layerShadow.shadowOpacity=1;
    layerShadow.borderColor=[UIColor whiteColor].CGColor;
    layerShadow.borderWidth=borderWidth;
    [self.view.layer addSublayer:layerShadow];
    
    //容器图层
    _layer=[[CALayer alloc]init];
    _layer.bounds=bounds;
    _layer.position=position;
    _layer.backgroundColor=[UIColor redColor].CGColor;
    _layer.cornerRadius=cornerRadius;
    _layer.masksToBounds=YES;
    _layer.borderColor=[UIColor whiteColor].CGColor;
    _layer.borderWidth=borderWidth;
    
    //设置图层代理
    _layer.delegate=self;
    
    //添加图层到根图层
    [self.view.layer addSublayer:_layer];
    
    //调用图层setNeedDisplay,否则代理方法不会被调用
    [_layer setNeedsDisplay];
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
    //判断是否已经常见过动画，如果已经创建则不再创建动画
    CAAnimation *animation= [_layer animationForKey:@"KCBasicAnimation_Rotation"];
    if(animation){
        if (_layer.speed==0) {
            [self animationResume];
        }else{
            [self animationPause];
        }
    }else{
        //创建并开始动画
        [self rotationAnimation];
    }
}

#pragma mark 绘制图形、图像到图层，注意参数中的ctx是图层的图形上下文，其中绘图位置也是相对图层而言的
-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    //    NSLog(@"%@",layer);//这个图层正是上面定义的图层
    CGContextSaveGState(ctx);
    
    //图形上下文形变，解决图片倒立的问题
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -PHOTO_HEIGHT);
    
    UIImage *image=[UIImage imageNamed:@"example.jpg"];
    //注意这个位置是相对于图层而言的不是屏幕
    CGContextDrawImage(ctx, CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT), image.CGImage);
    
    //    CGContextFillRect(ctx, CGRectMake(0, 0, 100, 100));
    //    CGContextDrawPath(ctx, kCGPathFillStroke);
    
    //添加对象,绘制椭圆（圆形）的过程也是先创建一个矩形
    CGRect rect = CGRectMake(PHOTO_HEIGHT/2 - PHOTO_CENTER_HEIGHT/2, PHOTO_HEIGHT/2 - PHOTO_CENTER_HEIGHT/2, PHOTO_CENTER_HEIGHT, PHOTO_CENTER_HEIGHT);
    CGContextAddEllipseInRect(ctx, rect);
    CGContextSetLineWidth(ctx, 2.0);//线的宽度
    //设置属性
    CGContextSetFillColorWithColor(ctx, [UIColor colorWithWhite:0.1 alpha:1].CGColor);
    CGContextSetStrokeColorWithColor(ctx,[UIColor whiteColor].CGColor);
    //绘制
    CGContextDrawPath(ctx, kCGPathFillStroke);
    
    //中心外层圆圈
    float centerOutHight = PHOTO_CENTER_HEIGHT + 6;
    CGRect rectOut = CGRectMake(PHOTO_HEIGHT/2 - centerOutHight/2, PHOTO_HEIGHT/2 - centerOutHight/2, centerOutHight, centerOutHight);
    CGContextAddEllipseInRect(ctx, rectOut);
    CGContextSetLineWidth(ctx, 4.0);//线的宽度
    //设置属性
    CGContextSetStrokeColorWithColor(ctx,[UIColor colorWithWhite:0.2 alpha:1].CGColor);
    //绘制
    CGContextDrawPath(ctx, kCGPathStroke);
    
    CGContextRestoreGState(ctx);
}

#pragma mark 旋转动画
-(void)rotationAnimation{
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
    [_layer addAnimation:basicAnimation forKey:@"KCBasicAnimation_Rotation"];
}

#pragma mark 动画暂停
-(void)animationPause{
    //取得指定图层动画的媒体时间，后面参数用于指定子图层，这里不需要
    CFTimeInterval interval=[_layer convertTime:CACurrentMediaTime() fromLayer:nil];
    //设置时间偏移量，保证暂停时停留在旋转的位置
    [_layer setTimeOffset:interval];
    //速度设置为0，暂停动画
    _layer.speed=0;
}

#pragma mark 动画恢复
-(void)animationResume{
    //获得暂停的时间
    CFTimeInterval beginTime= CACurrentMediaTime()- _layer.timeOffset;
    //设置偏移量
    _layer.timeOffset=0;
    //设置开始时间
    _layer.beginTime=beginTime;
    //设置动画速度，开始运动
    _layer.speed=1.0;
}

- (void) closeAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
