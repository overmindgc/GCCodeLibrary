//
//  NineGridPasswordView.m
//  CodeLibrary
//
//  Created by 辰 宫 on 14/11/3.
//  Copyright (c) 2014年 overmindgc. All rights reserved.
//

#import "NineGridPasswordView.h"
#import "NGGridView.h"

#define GridWidth SCREEN_WIDTH * 0.195

@interface NineGridPasswordView ()

/*默认未选中颜色*/
@property (nonatomic, strong) UIColor *defaultColor;
/*选中的颜色*/
@property (nonatomic, strong) UIColor *selectedColor;
/*错误的颜色*/
@property (nonatomic, strong) UIColor *errorColor;
/*选中的圆填充颜色*/
@property (nonatomic, strong) UIColor *circleFillColor;

/*是否是画轨迹模式*/
@property BOOL isTracking;
/*是否是错误模式*/
@property BOOL isError;
/*保存九宫格视图数组*/
@property (nonatomic, strong) NSMutableArray *gridArray;
/*保存选中的九宫格视图数组*/
@property (nonatomic, strong) NSMutableArray *selectedGridArray;
/*保存画线点数组*/
@property (nonatomic, strong) NSMutableArray *pathPointArray;
/*已固定点位数量*/
@property NSInteger fixedDotCount;

@end

@implementation NineGridPasswordView
{
    NSInteger errorTime;
}

@synthesize correctPassword;

@synthesize defaultColor,selectedColor,errorColor,circleFillColor;

@synthesize gridArray;

@synthesize selectedGridArray;

@synthesize isTracking,isError;

@synthesize pathPointArray;

@synthesize fixedDotCount;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        defaultColor = [UIColor colorWithRed:107.0f/255.0f green:125.0f/255.0f blue:146.0f/255.0f alpha:1.0f];
        selectedColor = [UIColor colorWithRed:4.0f/255.0f green:174.0f/255.0f blue:238.0f/255.0f alpha:1.0f];
        errorColor = [UIColor colorWithRed:208.0f/255.0f green:52.0f/255.0f blue:19.0f/255.0f alpha:1.0f];
        circleFillColor = [UIColor colorWithRed:25.0f/255.0f green:55.0f/255.0f blue:92.0f/255.0f alpha:1.0f];
        isTracking = NO;
        errorTime = 0;
        gridArray = [[NSMutableArray alloc] init];
        selectedGridArray = [[NSMutableArray alloc] init];
        pathPointArray = [[NSMutableArray alloc] init];
        fixedDotCount = 0;
        //添加九个宫格视图
        double viewWidth = self.frame.size.width;
        double gridGap = (viewWidth - GridWidth * 3) / 2;
        for (NSInteger n=0; n<3; n++) {
            for (NSInteger i=0; i<3; i++) {
                double gridX = gridGap * i + GridWidth * i;
                NGGridView *gridView = [[NGGridView alloc] initWithFrame:CGRectMake(gridX, GridWidth * n + gridGap * n, GridWidth + 2, GridWidth + 2)];
                gridView.backgroundColor = [UIColor clearColor];
                gridView.gridNo = i + 1 + n * 3;
                gridView.defaultColor = defaultColor;
                gridView.selectedColor = selectedColor;
                gridView.errorColor = errorColor;
                gridView.circleFillColor = circleFillColor;
                [self addSubview:gridView];
                [gridArray addObject:gridView];
            }
        }
        
    }
    
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    //如果点数组大于一个，画线
    if (pathPointArray.count > 1) {
        //1.获得图形上下文
        CGContextRef context=UIGraphicsGetCurrentContext();
        //4.设置图形上下文状态属性
        if (isError) {
            [errorColor set];//设置笔触颜色
        } else {
            [selectedColor set];//设置笔触颜色
        }
        
//        CGContextSetRGBStrokeColor(context, 4.0f/255.0f, 174.0f/255.0f, 238.0f/255.0f, 1.0f);//设置笔触颜色
        CGContextSetLineWidth(context, 5.0);//设置线条宽度
    
        for (NSInteger i=0; i<pathPointArray.count; i++) {
            NSValue *pointValue = [pathPointArray objectAtIndex:i];
            CGPoint point = [pointValue CGPointValue];
            //2.绘制路径（相当于前面创建路径并添加路径到图形上下文两步操作）
            if (i == 0) {
                CGContextMoveToPoint(context, point.x, point.y);
            } else {
                CGContextAddLineToPoint(context, point.x, point.y);
            }
        }
        
        //4.绘制路径
        CGContextDrawPath(context, kCGPathStroke);
    }
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    [self resetTrackingState];
    
    isTracking = YES;
    
    UITouch *touch = [touches anyObject];
    CGPoint currPoint = [touch locationInView:self];
    
    //判断是否在圆上，是就选中
    for (NGGridView *currGridView in gridArray) {
        if ([self containPoint:currPoint inCircle:currGridView.frame]) {
            [currGridView setSelected:YES withArrowAngle:NGGridArrowAngleNone isError:NO];
            [selectedGridArray addObject:currGridView];
            [pathPointArray addObject:[NSValue valueWithCGPoint:[self centerPointByFrame:currGridView.frame]]];
            fixedDotCount++;
            [self setNeedsDisplay];
            break;
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    
    CGPoint currPoint = [touch locationInView:self];

    //判断是否在新圆上，是就添加
    for (NGGridView *currGridView in gridArray) {
        if ([self containPoint:currPoint inCircle:currGridView.frame]) {
            if (![currGridView isSelected]) {
                [currGridView setSelected:YES withArrowAngle:NGGridArrowAngleNone isError:NO];
                [selectedGridArray addObject:currGridView];
                if (pathPointArray.count == fixedDotCount) {
                    [pathPointArray addObject:[NSValue valueWithCGPoint:[self centerPointByFrame:currGridView.frame]]];
                } else {
                    [pathPointArray replaceObjectAtIndex:pathPointArray.count - 1 withObject:[NSValue valueWithCGPoint:[self centerPointByFrame:currGridView.frame]]];
                }
                
                fixedDotCount++;
                [self addArrowToNGGridViews:selectedGridArray isError:NO];
            }
            break;
        }
    }
    
    //添加当前点
    if (pathPointArray.count > 0) {
        NSValue *currPointValue = [NSValue valueWithCGPoint:currPoint];
        if (pathPointArray.count == fixedDotCount) {
            [pathPointArray addObject:currPointValue];
        } else {
            [pathPointArray replaceObjectAtIndex:pathPointArray.count - 1 withObject:currPointValue];
        }
    }
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    if (selectedGridArray.count > 1)
    {
        NSString *currPassword = [self getPassword:selectedGridArray];
        if ([currPassword isEqualToString:correctPassword]) {
            if (pathPointArray.count > fixedDotCount) {
                [pathPointArray removeLastObject];
                [self setNeedsDisplay];
            }
            [self.delegete passwordView:self withCorrectPassword:[self getPassword:selectedGridArray]];
//            [self resetTrackingState];
            errorTime = 0;
            isError = NO;
            [self addArrowToNGGridViews:selectedGridArray isError:NO];
        } else {
            if (pathPointArray.count > fixedDotCount) {
                [pathPointArray removeLastObject];
                for (NGGridView *sGridView in selectedGridArray) {
                    [sGridView setSelected:YES withArrowAngle:NGGridArrowAngleNone isError:YES];
                }
                [self setNeedsDisplay];
            }
            isError = YES;
            errorTime++;
            [self.delegete passwordView:self withErrorPassword:errorTime];
            [self addArrowToNGGridViews:selectedGridArray isError:YES];
        }
    } else {
        [self resetTrackingState];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [self resetTrackingState];
}

//重置状态
- (void)resetTrackingState
{
    isTracking = NO;
    isError = NO;
    for (NGGridView *nGrid in gridArray) {
        [nGrid setSelected:NO withArrowAngle:NGGridArrowAngleNone isError:NO];
    }
    [selectedGridArray removeAllObjects];
    [pathPointArray removeAllObjects];
    fixedDotCount = 0;
    [self setNeedsDisplay];
}

//判断点是否在圆内
- (BOOL)containPoint:(CGPoint)point inCircle:(CGRect)rect
{
    double circleRadius = rect.size.width / 2;
    CGPoint center = CGPointMake(rect.origin.x + circleRadius, rect.origin.y + circleRadius);
    BOOL isContain = ((center.x - point.x) * (center.x - point.x) + (center.y - point.y) * (center.y - point.y) - circleRadius * circleRadius) < 0;
    return isContain;
}

//给数组里的宫格加箭头
- (void)addArrowToNGGridViews:(NSArray *)gArray isError:(BOOL)error
{
    if (gArray.count > 1) {
        NGGridView *lastGridView = [gArray objectAtIndex:0];
        for (NSInteger i=0; i<gArray.count; i++) {
            if (i > 0) {
                NGGridView *currGrid = [gArray objectAtIndex:i];
                [lastGridView setSelected:YES withArrowAngle:[self directionByOnePoint:lastGridView.center toAnotherPoint:currGrid.center] isError:error];
                lastGridView = currGrid;
            }
        }
    }
}

/**
 根据两点坐标返回与垂直向上方向的夹角
 角a = arctan(a/b)
 用反正切、反余切求角度
 */
- (NSInteger)directionByOnePoint:(CGPoint)point1 toAnotherPoint:(CGPoint)point2
{
    float sideA = point2.x - point1.x;
    float sideB = point2.y - point1.y;
    float angle = atanf(sideA / sideB) * 180 / M_PI;
    if (point1.y > point2.y) {
        return angle;
    } else {
        return angle - 180;
    }
    return angle;
}

//通过fame取得中心点
- (CGPoint)centerPointByFrame:(CGRect)frame
{
    double centerX = frame.origin.x + frame.size.width / 2;
    double centerY = frame.origin.y + frame.size.height / 2;
    CGPoint point = CGPointMake(centerX, centerY);
    return point;
}

//获取选中的密码
- (NSString*)getPassword:(NSArray*)array
{
    NSMutableString* password = [[NSMutableString alloc] init];
    for (int i = 0; i < [array count]; i++)
    {
        NGGridView *gridView = [array objectAtIndex:i];
        [password appendFormat:@"%ld",gridView.gridNo];
    }
    return password;
}

@end
