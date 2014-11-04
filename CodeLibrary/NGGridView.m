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
    UIColor *defaultColor;
    UIColor *selectedColor;
    UIColor *errorColor;
}

@synthesize isSelected;
@synthesize isError;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        isSelected = NO;
        isError = NO;
        defaultColor = [UIColor colorWithRed:107.0f/255.0f green:125.0f/255.0f blue:146.0f/255.0f alpha:1.0f];
        selectedColor = [UIColor colorWithRed:4.0f/255.0f green:174.0f/255.0f blue:238.0f/255.0f alpha:1.0f];
        errorColor = [UIColor colorWithRed:208.0f/255.0f green:52.0f/255.0f blue:19.0f/255.0f alpha:1.0f];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    if (isSelected) {
        [self drawSelectedCircleWithError:isError];
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
    
    //画中心园
    
}

#pragma mark 绘制选中圆
-(void)drawSelectedCircleWithError:(BOOL)error
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
    UIColor*fillColor = [UIColor colorWithRed:25.0f/255.0f green:55.0f/255.0f blue:92.0f/255.0f alpha:1.0f];
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
}

- (void)setSelected:(BOOL)selected withError:(BOOL)error
{
    isSelected = selected;
    isError = error;
    [self setNeedsDisplay];
}

@end
