//
//  NGGridView.m
//  CodeLibrary
//
//  Created by 辰 宫 on 14/11/3.
//  Copyright (c) 2014年 overmindgc. All rights reserved.
//

#import "NGGridView.h"

#define CircleWidth SCREEN_WIDTH * 0.195

@implementation NGGridView
{
    BOOL isError;
    NSInteger currAngle;
}

@synthesize isSelected;

@synthesize defaultColor,selectedColor,errorColor,circleFillColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        isSelected = NO;
        isError = NO;
        currAngle = NGGridArrowAngleNone;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    if (isSelected) {
        [self drawSelectedCircleWithArrow:currAngle isError:isError];
    } else {
        [self drawCircle];
    }
}

#pragma mark 绘制默认圆
-(void)drawCircle
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    //添加对象,绘制椭圆（圆形）的过程也是先创建一个矩形
    CGRect rect = CGRectMake(1, 1, CircleWidth, CircleWidth);
    CGContextAddEllipseInRect(context, rect);
    //设置属性
    CGContextSetLineWidth(context, 2.0);//设置线条宽度
    [defaultColor set];//设置笔触颜色
//    CGContextSetRGBStrokeColor(context, defaultColor);//设置笔触颜色
    //绘制
    CGContextDrawPath(context, kCGPathStroke);
    
}

#pragma mark 绘制选中圆
-(void)drawSelectedCircleWithArrow:(NSInteger)angle isError:(BOOL)error
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    

    //添加对象,绘制椭圆（圆形）的过程也是先创建一个矩形
    CGRect rect = CGRectMake(1, 1, CircleWidth, CircleWidth);
    CGContextAddEllipseInRect(context, rect);
    //设置属性
    CGContextSetLineWidth(context, 2.0);//设置线条宽度
    if (isError) {
        [errorColor set];//设置笔触颜色
    } else {
        [selectedColor set];//设置笔触颜色
    }
//    CGContextSetRGBStrokeColor(context, 4.0f/255.0f, 174.0f/255.0f, 238.0f/255.0f, 1.0f);//设置笔触颜色
    //设置填充颜色
    UIColor*fillColor = circleFillColor;
    CGContextSetFillColorWithColor(context, fillColor.CGColor);//填充颜色
    //绘制
    CGContextDrawPath(context, kCGPathFillStroke);
    
    
    double centerCircleWidth = CircleWidth * 0.3;
    double centXY = CircleWidth / 2 - centerCircleWidth / 2 + 1;
    CGRect centerRect = CGRectMake(centXY, centXY, centerCircleWidth, centerCircleWidth);
    CGContextAddEllipseInRect(context, centerRect);
    //设置填充颜色
    if (isError) {
        CGContextSetFillColorWithColor(context, errorColor.CGColor);//填充颜色
    } else {
        CGContextSetFillColorWithColor(context, selectedColor.CGColor);//填充颜色
    }
    
    //绘制
    CGContextDrawPath(context, kCGPathFill);
    
    if (angle != NGGridArrowAngleNone) {
        //利用path进行绘制三角箭头
        
        //三角形的底边长和高
        float triangleBaseWidth = centerCircleWidth * 0.5;
        float triangleHight = triangleBaseWidth * 0.7;
        //圆心坐标
        CGPoint circleCenterPoint = CGPointMake(CircleWidth/2 + 1, CircleWidth/2 + 1);
        //计算出顶部三角的三个点坐标，其他的三角的坐标就可以推算出来了
        float topBeginY = (CircleWidth/2 - centerCircleWidth/2)/2 - triangleHight/2.4;
        CGPoint triangleTopPoint = CGPointMake(CircleWidth/2 + 1, topBeginY);
        CGPoint triangleLeftPoint = CGPointMake(CircleWidth/2 - triangleBaseWidth/2 + 1, topBeginY + triangleHight);
        CGPoint triangleRightPoint = CGPointMake(CircleWidth/2 + triangleBaseWidth/2 + 1, topBeginY + triangleHight);
        
        CGPoint currTopPoint = [self rotaryAngle:angle withPoint:triangleTopPoint andCenter:circleCenterPoint];
        CGPoint currLeftPoint = [self rotaryAngle:angle withPoint:triangleLeftPoint andCenter:circleCenterPoint];
        CGPoint currRightPoint = [self rotaryAngle:angle withPoint:triangleRightPoint andCenter:circleCenterPoint];
        
        CGContextBeginPath(context);//标记
        CGContextMoveToPoint(context,currTopPoint.x,currTopPoint.y);//设置起点
        CGContextAddLineToPoint(context,currLeftPoint.x,currLeftPoint.y);
        CGContextAddLineToPoint(context,currRightPoint.x,currRightPoint.y);
        CGContextClosePath(context);//路径结束标志，不写默认封闭
        CGContextDrawPath(context,kCGPathFill);//绘制路径path
    }
    
}

- (void)setSelected:(BOOL)selected withArrowAngle:(NSInteger)angle isError:(BOOL)error
{
    isSelected = selected;
    isError = error;
    currAngle = angle;
    [self setNeedsDisplay];
}

/**
 假设对图片上任意点(x,y)，绕一个坐标点(rx0,ry0)逆时针旋转RotaryAngle角度后的新的坐标设为(x', y')，有公式：
 x'= (x - rx0)*cos(RotaryAngle) + (y - ry0)*sin(RotaryAngle) + rx0 ;
 y'=-(x - rx0)*sin(RotaryAngle) + (y - ry0)*cos(RotaryAngle) + ry0 ;
 radian = angle * PI / 180; //角度变成弧度
 */
- (CGPoint)rotaryAngle:(NSInteger)angle withPoint:(CGPoint)point andCenter:(CGPoint)centerPoint
{
    float radian = angle * M_PI / 180;
    float newX = (point.x - centerPoint.x) * cosf(radian) + (point.y - centerPoint.y) * sinf(radian) + centerPoint.x;
    float newY = -(point.x - centerPoint.x) * sinf(radian) + (point.y - centerPoint.y) * cosf(radian) + centerPoint.y;
    return CGPointMake(newX, newY);
}

@end
