//
//  CDView.m
//  CodeLibrary
//
//  Created by 辰 宫 on 14/11/18.
//  Copyright (c) 2014年 overmindgc. All rights reserved.
//

#import "CDView.h"

@implementation CDView
{
    CGFloat photo_hight;
    CGFloat photo_center_hight;
}

@synthesize cdImageName;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        cdImageName = @"example";
        
        photo_hight = frame.size.width;
        photo_center_hight = photo_hight * 0.15;
        CGFloat radius = photo_hight / 2;
        
        //设置view的图层参数
        self.layer.cornerRadius = radius;
        self.layer.masksToBounds = YES;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 2;
        
        //阴影图层
        CALayer *layerShadow = [[CALayer alloc]init];
        layerShadow.bounds = frame;
        layerShadow.position = CGPointMake(photo_hight/2, photo_hight/2);
        layerShadow.cornerRadius = radius;
        layerShadow.shadowColor = [UIColor darkGrayColor].CGColor;
        layerShadow.shadowOffset = CGSizeMake(3, 1);
        layerShadow.shadowOpacity = 1;
        layerShadow.borderColor = [UIColor whiteColor].CGColor;
        layerShadow.borderWidth = 2;
        [self.layer addSublayer:layerShadow];
        
        

    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
//    [self drawLayer:_layer inContext:ctx];
}

- (void)routeStartOrStop
{
    //判断是否已经常见过动画，如果已经创建则不再创建动画
    CAAnimation *animation= [self.layer animationForKey:@"KCBasicAnimation_Rotation"];
    if(animation){
        if (self.layer.speed==0) {
            [self animationResume];
        }else{
            [self animationPause];
        }
    }else{
        //创建并开始动画
        [self rotationAnimation];
    }
}

#pragma mark layer的代理方法，绘制图形、图像到图层，注意参数中的ctx是图层的图形上下文，其中绘图位置也是相对图层而言的
-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    //    NSLog(@"%@",layer);//这个图层正是上面定义的图层
    CGContextSaveGState(ctx);
    
    //图形上下文形变，解决图片倒立的问题
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -photo_hight);
    
    UIImage *image=[UIImage imageNamed:cdImageName];
    //注意这个位置是相对于图层而言的不是屏幕
    CGContextDrawImage(ctx, CGRectMake(0, 0, photo_hight, photo_hight), image.CGImage);
    
    //    CGContextFillRect(ctx, CGRectMake(0, 0, 100, 100));
    //    CGContextDrawPath(ctx, kCGPathFillStroke);
    
    //添加对象,绘制椭圆（圆形）的过程也是先创建一个矩形
    CGRect rect = CGRectMake(photo_hight/2 - photo_center_hight/2, photo_hight/2 - photo_center_hight/2, photo_center_hight, photo_center_hight);
    CGContextAddEllipseInRect(ctx, rect);
    CGContextSetLineWidth(ctx, 2.0);//线的宽度
    //设置属性
    CGContextSetFillColorWithColor(ctx, [UIColor colorWithWhite:0.1 alpha:1].CGColor);
    CGContextSetStrokeColorWithColor(ctx,[UIColor whiteColor].CGColor);
    //绘制
    CGContextDrawPath(ctx, kCGPathFillStroke);
    
    //中心外层圆圈
    float centerOutHight = photo_center_hight + 5;
    CGRect rectOut = CGRectMake(photo_hight/2 - centerOutHight/2, photo_hight/2 - centerOutHight/2, centerOutHight, centerOutHight);
    CGContextAddEllipseInRect(ctx, rectOut);
    CGContextSetLineWidth(ctx, 5.0);//线的宽度
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
    [self.layer addAnimation:basicAnimation forKey:@"KCBasicAnimation_Rotation"];
}

#pragma mark 动画暂停
-(void)animationPause{
    //取得指定图层动画的媒体时间，后面参数用于指定子图层，这里不需要
    CFTimeInterval interval=[self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    //设置时间偏移量，保证暂停时停留在旋转的位置
    [self.layer setTimeOffset:interval];
    //速度设置为0，暂停动画
    self.layer.speed=0;
}

#pragma mark 动画恢复
-(void)animationResume{
    //获得暂停的时间
    CFTimeInterval beginTime= CACurrentMediaTime()- self.layer.timeOffset;
    //设置偏移量
    self.layer.timeOffset=0;
    //设置开始时间
    self.layer.beginTime=beginTime;
    //设置动画速度，开始运动
    self.layer.speed=1.0;
}


@end
