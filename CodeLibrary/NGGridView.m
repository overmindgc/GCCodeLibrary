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

@synthesize isSelected;

- (id)init
{
    self = [super init];
    if (self) {
        isSelected = NO;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    if (isSelected) {
        [self drawSelectedCircle];
    } else {
        [self drawCircle];
    }
    

    UITapGestureRecognizer *tapSelected = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchSelected:)];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tapSelected];
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
//    [[UIColor colorWithRed:88.0f/255.0f green:105.0f/255.0f blue:127.0f/255.0f alpha:1.0f] set];
    CGContextSetRGBStrokeColor(context, 107.0f/255.0f, 125.0f/255.0f, 146.0f/255.0f, 1.0f);//设置笔触颜色
    //绘制
    CGContextDrawPath(context, kCGPathStroke);
    
    //画中心园
    
}

#pragma mark 绘制选中圆
-(void)drawSelectedCircle
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    

    //添加对象,绘制椭圆（圆形）的过程也是先创建一个矩形
    CGRect rect = CGRectMake(1, 1, CircleWidth, CircleWidth);
    CGContextAddEllipseInRect(context, rect);
    //设置属性
    CGContextSetLineWidth(context, 2.0);//设置线条宽度
    //    [[UIColor colorWithRed:88.0f/255.0f green:105.0f/255.0f blue:127.0f/255.0f alpha:1.0f] set];
    CGContextSetRGBStrokeColor(context, 4.0f/255.0f, 174.0f/255.0f, 238.0f/255.0f, 1.0f);//设置笔触颜色
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
    UIColor*centerColor = [UIColor colorWithRed:4.0f/255.0f green:174.0f/255.0f blue:238.0f/255.0f alpha:1.0f];
    CGContextSetFillColorWithColor(context, centerColor.CGColor);//填充颜色
    //绘制
    CGContextDrawPath(context, kCGPathFill);
}

- (void)touchSelected:(UISwipeGestureRecognizer *)gestureRecognizer
{
    isSelected = !isSelected;
    [self setNeedsDisplay];
}

@end
