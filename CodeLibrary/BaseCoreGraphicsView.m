//
//  BaseCoreGraphicsView.m
//  CodeLibrary
//  基本绘图
//  Created by 辰 宫 on 14/10/31.
//  Copyright (c) 2014年 overmindgc. All rights reserved.
//

#import "BaseCoreGraphicsView.h"

@implementation BaseCoreGraphicsView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//绘图只能在此方法中调用，否则无法得到当前图形上下文
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    
    
    [self drawLine1];
    
    [self drawLine2];
    
    //1.取得图形上下文对象
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self drawRectWithContext:context];
    [self drawRectByUIKitWithContext:context];
    
    [self drawEllipse:context];
    
    [self drawArc:context];
    
    [self drawCurve:context];
}

- (void)drawLine1
{
    //1.取得图形上下文对象
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //2.创建路径对象
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 20, 80);//移动到指定位置（设置路径起点）
    CGPathAddLineToPoint(path, nil, 20, 130);//绘制直线（从起始位置开始）
    CGPathAddLineToPoint(path, nil, 130, 130);//绘制另外一条直线（从上一直线终点开始绘制）
    
    
    //3.添加路径到图形上下文
    CGContextAddPath(context, path);
    
    //4.设置图形上下文状态属性
    CGContextSetRGBStrokeColor(context, 1.0, 0, 0, 1);//设置笔触颜色
    CGContextSetRGBFillColor(context, 0, 1.0, 0, 1);//设置填充色
    CGContextSetLineWidth(context, 2.0);//设置线条宽度
    CGContextSetLineCap(context, kCGLineCapRound);//设置顶点样式,（20,50）和（300,100）是顶点
    CGContextSetLineJoin(context, kCGLineJoinRound);//设置连接点样式，(20,100)是连接点
    /*设置线段样式
     phase:虚线开始的位置
     lengths:虚线长度间隔（例如下面的定义说明第一条线段长度8，然后间隔3重新绘制8点的长度线段，当然这个数组可以定义更多元素）
     count:虚线数组元素个数
     */
    CGFloat lengths[2] = { 18, 9 };
    CGContextSetLineDash(context, 0, lengths, 2);
    /*设置阴影
     context:图形上下文
     offset:偏移量
     blur:模糊度
     color:阴影颜色
     */
    CGColorRef color = [UIColor grayColor].CGColor;//颜色转化，由于Quartz 2D跨平台，所以其中不能使用UIKit中的对象，但是UIkit提供了转化方法
    CGContextSetShadowWithColor(context, CGSizeMake(2, 2), 0.8, color);
    
    //5.绘制图像到指定图形上下文
    /*CGPathDrawingMode是填充方式,枚举类型
     kCGPathFill:只有填充（非零缠绕数填充），不绘制边框
     kCGPathEOFill:奇偶规则填充（多条路径交叉时，奇数交叉填充，偶交叉不填充）
     kCGPathStroke:只有边框
     kCGPathFillStroke：既有边框又有填充
     kCGPathEOFillStroke：奇偶填充并绘制边框
     */
    CGContextDrawPath(context, kCGPathFillStroke);//最后一个参数是填充类型
    
    //6.释放对象
    CGPathRelease(path);
}


-(void)drawLine2{
    //1.获得图形上下文
    CGContextRef context=UIGraphicsGetCurrentContext();
    
    //2.绘制路径（相当于前面创建路径并添加路径到图形上下文两步操作）
    CGContextMoveToPoint(context, 150, 80);
    CGContextAddLineToPoint(context, 150, 130);
    CGContextAddLineToPoint(context, 300, 130);
    //封闭路径:a.创建一条起点和终点的线,不推荐
    //CGPathAddLineToPoint(path, nil, 20, 50);
    //封闭路径:b.直接调用路径封闭方法
    CGContextClosePath(context);
    
    //3.设置图形上下文属性
    [[UIColor redColor]setStroke];//设置红色边框
    [[UIColor greenColor]setFill];//设置绿色填充
    //[[UIColor blueColor]set];//同时设置填充和边框色
    
    //4.绘制路径
    CGContextDrawPath(context, kCGPathFillStroke);
}

#pragma mark 绘制矩形
-(void)drawRectWithContext:(CGContextRef)context{
    //添加矩形对象
    CGRect rect=CGRectMake(20, 150, 70.0, 50.0);
    CGContextAddRect(context,rect);
    //设置属性
    [[UIColor blueColor]set];
    //绘制
    CGContextDrawPath(context, kCGPathFillStroke);
}

#pragma mark 绘制矩形（利用UIKit的封装方法）
-(void)drawRectByUIKitWithContext:(CGContextRef)context{
    CGRect rect= CGRectMake(120, 150, 70.0, 50.0);
    CGRect rect2=CGRectMake(210, 150, 70.0, 50.0);
    //设置属性
    [[UIColor yellowColor]set];
    //绘制矩形,相当于创建对象、添加对象到上下文、绘制三个步骤
    UIRectFill(rect);//绘制矩形（只有填充）
    
    [[UIColor redColor]setStroke];
    UIRectFrame(rect2);//绘制矩形(只有边框)
}

#pragma mark 绘制椭圆
-(void)drawEllipse:(CGContextRef)context{
    //添加对象,绘制椭圆（圆形）的过程也是先创建一个矩形
    CGRect rect=CGRectMake(20, 220, 100.0, 100.0);
    CGContextAddEllipseInRect(context, rect);
    //设置属性
    [[UIColor purpleColor]set];
    //绘制
    CGContextDrawPath(context, kCGPathFillStroke);
}

-(void)drawArc:(CGContextRef)context{
    /*添加弧形对象
     x:中心点x坐标
     y:中心点y坐标
     radius:半径
     startAngle:起始弧度
     endAngle:终止弧度
     closewise:是否逆时针绘制，0则顺时针绘制
     */
    CGContextAddArc(context, 200, 270, 50.0, 0.0, M_PI_2, 1);
    
    //设置属性
    [[UIColor yellowColor]set];
    
    //绘制
    CGContextDrawPath(context, kCGPathFillStroke);
}

#pragma mark 绘制贝塞尔曲线
-(void)drawCurve:(CGContextRef)context{
    
    //绘制曲线
    CGContextMoveToPoint(context, 20, 370);//移动到起始位置
    /*绘制二次贝塞尔曲线
     c:图形上下文
     cpx:控制点x坐标
     cpy:控制点y坐标
     x:结束点x坐标
     y:结束点y坐标
     */
    CGContextAddQuadCurveToPoint(context, 160, 300, 300, 370);
    
    CGContextMoveToPoint(context, 20, 460);
    /*绘制三次贝塞尔曲线
     c:图形上下文
     cp1x:第一个控制点x坐标
     cp1y:第一个控制点y坐标
     cp2x:第二个控制点x坐标
     cp2y:第二个控制点y坐标
     x:结束点x坐标
     y:结束点y坐标
     */
    CGContextAddCurveToPoint(context, 150, 300, 240, 550, 300, 390);
    
    //设置图形上下文属性
    [[UIColor yellowColor]setFill];
    [[UIColor redColor]setStroke];
    
    
    //绘制路径
    CGContextDrawPath(context, kCGPathFillStroke);
    
}

@end
