//
//  CDLayerView.m
//  CodeLibrary
//
//  Created by 辰 宫 on 14/11/21.
//  Copyright (c) 2014年 overmindgc. All rights reserved.
//

#import "CDLayerView.h"

@implementation CDLayerView

@synthesize cdImageName;
@synthesize photo_center_hight,photo_hight;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark layer的代理方法，绘制图形、图像到图层，注意参数中的ctx是图层的图形上下文，其中绘图位置也是相对图层而言的
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
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


@end
