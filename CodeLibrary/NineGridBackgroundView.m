//
//  NineGridBackgroundView.m
//  CodeLibrary
//
//  Created by 辰 宫 on 14/11/4.
//  Copyright (c) 2014年 overmindgc. All rights reserved.
//

#import "NineGridBackgroundView.h"

@implementation NineGridBackgroundView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    //设置渐变背景色
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawLinearGradient:context];
}

#pragma mark 线性渐变
- (void)drawLinearGradient:(CGContextRef)context{
    //使用rgb颜色空间
    CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceRGB();
    
    /*指定渐变色
     space:颜色空间
     components:颜色数组,注意由于指定了RGB颜色空间，那么四个数组元素表示一个颜色（red、green、blue、alpha），
     如果有三个颜色则这个数组有4*3个元素
     locations:颜色所在位置（范围0~1），这个数组的个数不小于components中存放颜色的个数
     count:渐变个数，等于locations的个数
     */
    CGFloat compoents[12]={
        8.0/255.0,18.0/255.0,42.0/255.0,1,
        16.0/255.0,50.0/255.0,85.0/255.0,1,
        19.0/255.0,44.0/255.0,74.0/255.0,1
    };
    CGFloat locations[3]={0,0.8,1.0};
    CGGradientRef gradient= CGGradientCreateWithColorComponents(colorSpace, compoents, locations, 3);
    
    /*绘制线性渐变
     context:图形上下文
     gradient:渐变色
     startPoint:起始位置
     endPoint:终止位置
     options:绘制方式,kCGGradientDrawsBeforeStartLocation 开始位置之前就进行绘制，到结束位置之后不再绘制，
     kCGGradientDrawsAfterEndLocation开始位置之前不进行绘制，到结束点之后继续填充
     */
    CGContextDrawLinearGradient(context, gradient, CGPointZero, CGPointMake(320, 300), kCGGradientDrawsAfterEndLocation);
    
    //释放颜色空间
    CGColorSpaceRelease(colorSpace);
}


@end
