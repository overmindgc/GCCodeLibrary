//
//  PNChartTestViewController.m
//  CodeLibrary
//
//  Created by 辰 宫 on 15/1/5.
//  Copyright (c) 2015年 overmindgc. All rights reserved.
//

#import "PNChartTestViewController.h"
#define ARC4RANDOM_MAX 0x100000000
#define PNFreshGreen    [UIColor colorWithRed:77.0 / 255.0 green:196.0 / 255.0 blue:122.0 / 255.0 alpha:1.0f]

@interface PNChartTestViewController ()
{
    NSMutableArray *chartViews;
}

@end

@implementation PNChartTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.titleLabel.textColor = PNFreshGreen;
    chartViews = [[NSMutableArray alloc] init];
    
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 60, 30)];
    closeBtn.backgroundColor = [UIColor orangeColor];
    [closeBtn setTitle:@"Close" forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    
    
    [self loadChartView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadChartView
{
    for (UIView *chartView in chartViews) {
        [chartView removeFromSuperview];
    }
    [chartViews removeAllObjects];
    self.changeValueButton.hidden = NO;
    if ([self.titleLabel.text isEqualToString:@"Line Chart"]) {
        
        self.lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 135.0, SCREEN_WIDTH, 200.0)];
        self.lineChart.yLabelFormat = @"%1.1f";
        self.lineChart.backgroundColor = [UIColor clearColor];
        [self.lineChart setXLabels:@[@"SEP 1",@"SEP 2",@"SEP 3",@"SEP 4",@"SEP 5",@"SEP 6",@"SEP 7"]];
        self.lineChart.showCoordinateAxis = YES;
        
        //Use yFixedValueMax and yFixedValueMin to Fix the Max and Min Y Value
        //Only if you needed
        self.lineChart.yFixedValueMax = 500.0;
        self.lineChart.yFixedValueMin = 1.0;
        
        // Line Chart #1
        NSArray * data01Array = @[@60.1, @160.1, @126.4, @262.2, @186.2, @127.2, @176.2];
        PNLineChartData *data01 = [PNLineChartData new];
        data01.color = PNFreshGreen;
        data01.alpha = 0.3f;
        data01.itemCount = data01Array.count;
        data01.inflexionPointStyle = PNLineChartPointStyleTriangle;
        data01.getData = ^(NSUInteger index) {
            CGFloat yValue = [data01Array[index] floatValue];
            return [PNLineChartDataItem dataItemWithY:yValue];
        };
        
        // Line Chart #2
        NSArray * data02Array = @[@20.1, @180.1, @26.4, @202.2, @126.2, @167.2, @276.2];
        PNLineChartData *data02 = [PNLineChartData new];
        data02.color = PNTwitterColor;
        data02.alpha = 0.5f;
        data02.itemCount = data02Array.count;
        data02.inflexionPointStyle = PNLineChartPointStyleSquare;
        data02.getData = ^(NSUInteger index) {
            CGFloat yValue = [data02Array[index] floatValue];
            return [PNLineChartDataItem dataItemWithY:yValue];
        };
        
        self.lineChart.chartData = @[data01, data02];
        [self.lineChart strokeChart];
        self.lineChart.delegate = self;
        
        
        [self.view addSubview:self.lineChart];
        [chartViews addObject:self.lineChart];
    }
    else if ([self.titleLabel.text isEqualToString:@"Bar Chart"])
    {
        
        self.barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, 135.0, SCREEN_WIDTH, 200.0)];
        self.barChart.backgroundColor = [UIColor clearColor];
        self.barChart.yLabelFormatter = ^(CGFloat yValue){
            CGFloat yValueParsed = yValue;
            NSString * labelText = [NSString stringWithFormat:@"%1.f",yValueParsed];
            return labelText;
        };
        self.barChart.labelMarginTop = 5.0;
        [self.barChart setXLabels:@[@"SEP 1",@"SEP 2",@"SEP 3",@"SEP 4",@"SEP 5",@"SEP 6",@"SEP 7"]];
        self.barChart.rotateForXAxisText = true ;
        [self.barChart setYValues:@[@1,@24,@12,@18,@30,@10,@21]];
        [self.barChart setStrokeColors:@[PNGreen,PNGreen,PNRed,PNGreen,PNGreen,PNYellow,PNGreen]];
        // Adding gradient
        self.barChart.barColorGradientStart = [UIColor blueColor];
        
        [self.barChart strokeChart];
        
        self.barChart.delegate = self;
        
        [self.view addSubview:self.barChart];
        
        //旋转横过来
        CGAffineTransform at = CGAffineTransformMakeRotation(M_PI/2);
        at = CGAffineTransformTranslate(at, 50, 0);
        [self.barChart setTransform:at];
        
        [chartViews addObject:self.barChart];
    }
    else if ([self.titleLabel.text isEqualToString:@"Circle Chart"])
    {
        
        
        self.circleChart = [[PNCircleChart alloc] initWithFrame:CGRectMake(0, 80.0, SCREEN_WIDTH, 100.0)
                                                          total:@100
                                                        current:@60
                                                      clockwise:YES
                                                         shadow:YES];
        self.circleChart.backgroundColor = [UIColor clearColor];
        [self.circleChart setStrokeColor:PNGreen];
        [self.circleChart setStrokeColorGradientStart:[UIColor blueColor]];
        [self.circleChart strokeChart];
        
        [self.view addSubview:self.circleChart];
        [chartViews addObject:self.circleChart];
    }
    else if ([self.titleLabel.text isEqualToString:@"Pie Chart"])
    {
        
        NSArray *items = @[[PNPieChartDataItem dataItemWithValue:10 color:PNLightGreen],
                           [PNPieChartDataItem dataItemWithValue:20 color:PNFreshGreen description:@"WWDC"],
                           [PNPieChartDataItem dataItemWithValue:40 color:PNDeepGreen description:@"GOOG I/O"],
                           ];
        
        self.pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(SCREEN_WIDTH /2.0 - 100, 135, 200.0, 200.0) items:items];
        self.pieChart.descriptionTextColor = [UIColor whiteColor];
        self.pieChart.descriptionTextFont  = [UIFont fontWithName:@"Avenir-Medium" size:11.0];
        self.pieChart.descriptionTextShadowColor = [UIColor clearColor];
        [self.pieChart strokeChart];
        
        
        [self.view addSubview:self.pieChart];
        [chartViews addObject:self.pieChart];
        self.changeValueButton.hidden = YES;
    }
    else if ([self.titleLabel.text isEqualToString:@"Scatter Chart"])
    {
        
        self.scatterChart = [[PNScatterChart alloc] initWithFrame:CGRectMake(SCREEN_WIDTH /6.0 - 30, 135, 280, 200)];
        [self.scatterChart setAxisXWithMinimumValue:20 andMaxValue:100 toTicks:6];
        [self.scatterChart setAxisYWithMinimumValue:30 andMaxValue:50 toTicks:5];
        
        NSArray * data01Array = [self randomSetOfObjects];
        PNScatterChartData *data01 = [PNScatterChartData new];
        data01.strokeColor = PNGreen;
        data01.fillColor = PNFreshGreen;
        data01.size = 2;
        data01.itemCount = [[data01Array objectAtIndex:0] count];
        data01.inflexionPointStyle = PNScatterChartPointStyleCircle;
        __block NSMutableArray *XAr1 = [NSMutableArray arrayWithArray:[data01Array objectAtIndex:0]];
        __block NSMutableArray *YAr1 = [NSMutableArray arrayWithArray:[data01Array objectAtIndex:1]];
        data01.getData = ^(NSUInteger index) {
            CGFloat xValue = [[XAr1 objectAtIndex:index] floatValue];
            CGFloat yValue = [[YAr1 objectAtIndex:index] floatValue];
            return [PNScatterChartDataItem dataItemWithX:xValue AndWithY:yValue];
        };
        
        [self.scatterChart setup];
        self.scatterChart.chartData = @[data01];
        /***
         this is for drawing line to compare
         CGPoint start = CGPointMake(20, 35);
         CGPoint end = CGPointMake(80, 45);
         [self.scatterChart drawLineFromPoint:start ToPoint:end WithLineWith:2 AndWithColor:PNBlack];
         ***/
        self.scatterChart.delegate = self;
        self.changeValueButton.hidden = YES;
        [self.view addSubview:self.scatterChart];
        [chartViews addObject:self.scatterChart];
    }
}

- (void)userClickedOnLineKeyPoint:(CGPoint)point lineIndex:(NSInteger)lineIndex pointIndex:(NSInteger)pointIndex{
    NSLog(@"Click Key on line %f, %f line index is %d and point index is %d",point.x, point.y,(int)lineIndex, (int)pointIndex);
}

- (void)userClickedOnLinePoint:(CGPoint)point lineIndex:(NSInteger)lineIndex{
    NSLog(@"Click on line %f, %f, line index is %d",point.x, point.y, (int)lineIndex);
}


- (IBAction)segmentedChangeValue:(id)sender {
    NSInteger index = self.segmented.selectedSegmentIndex;
    
    switch (index) {
        case 0:
            self.titleLabel.text = @"Line Chart";
            break;
        case 1:
            self.titleLabel.text = @"Bar Chart";
            break;
        case 2:
            self.titleLabel.text = @"Circle Chart";
            break;
        case 3:
            self.titleLabel.text = @"Pie Chart";
            break;
        case 4:
            self.titleLabel.text = @"Scatter Chart";
            break;
    }
    [self loadChartView];
    
}

- (void) closeAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)changeValue:(id)sender {
    if ([self.titleLabel.text isEqualToString:@"Line Chart"]) {
        
        // Line Chart #1
        NSArray * data01Array = @[@(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300)];
        PNLineChartData *data01 = [PNLineChartData new];
        data01.color = PNFreshGreen;
        data01.itemCount = data01Array.count;
        data01.inflexionPointStyle = PNLineChartPointStyleTriangle;
        data01.getData = ^(NSUInteger index) {
            CGFloat yValue = [data01Array[index] floatValue];
            return [PNLineChartDataItem dataItemWithY:yValue];
        };
        
        // Line Chart #2
        NSArray * data02Array = @[@(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300)];
        PNLineChartData *data02 = [PNLineChartData new];
        data02.color = PNTwitterColor;
        data02.itemCount = data02Array.count;
        data02.inflexionPointStyle = PNLineChartPointStyleSquare;
        data02.getData = ^(NSUInteger index) {
            CGFloat yValue = [data02Array[index] floatValue];
            return [PNLineChartDataItem dataItemWithY:yValue];
        };
        
        [self.lineChart setXLabels:@[@"DEC 1",@"DEC 2",@"DEC 3",@"DEC 4",@"DEC 5",@"DEC 6",@"DEC 7"]];
        [self.lineChart updateChartData:@[data01, data02]];
        
    }
    else if ([self.titleLabel.text isEqualToString:@"Bar Chart"])
    {
        [self.barChart setXLabels:@[@"Jan 1",@"Jan 2",@"Jan 3",@"Jan 4",@"Jan 5",@"Jan 6",@"Jan 7"]];
        [self.barChart updateChartData:@[@(arc4random() % 30),@(arc4random() % 30),@(arc4random() % 30),@(arc4random() % 30),@(arc4random() % 30),@(arc4random() % 30),@(arc4random() % 30)]];
    }
    else if ([self.titleLabel.text isEqualToString:@"Circle Chart"])
    {
        [self.circleChart updateChartByCurrent:@(arc4random() % 100)];
    }
    else if ([self.titleLabel.text isEqualToString:@"Scatter Chart"])
    {
        // will be code soon.
    }
}

- (void)userClickedOnBarAtIndex:(NSInteger)barIndex
{
    
    NSLog(@"Click on bar %@", @(barIndex));
    
    PNBar * bar = [self.barChart.bars objectAtIndex:barIndex];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    animation.fromValue = @1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.toValue = @1.1;
    animation.duration = 0.2;
    animation.repeatCount = 0;
    animation.autoreverses = YES;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    
    [bar.layer addAnimation:animation forKey:@"Float"];
}

/* this function is used only for creating random points */
- (NSArray *) randomSetOfObjects{
    NSMutableArray *array = [NSMutableArray array];
    NSString *LabelFormat = @"%1.f";
    NSMutableArray *XAr = [NSMutableArray array];
    NSMutableArray *YAr = [NSMutableArray array];
    for (int i = 0; i < 25 ; i++) {
        [XAr addObject:[NSString stringWithFormat:LabelFormat,(((double)arc4random() / ARC4RANDOM_MAX) * (self.scatterChart.AxisX_maxValue - self.scatterChart.AxisX_minValue) + self.scatterChart.AxisX_minValue)]];
        [YAr addObject:[NSString stringWithFormat:LabelFormat,(((double)arc4random() / ARC4RANDOM_MAX) * (self.scatterChart.AxisY_maxValue - self.scatterChart.AxisY_minValue) + self.scatterChart.AxisY_minValue)]];
    }
    [array addObject:XAr];
    [array addObject:YAr];
    return (NSArray*) array;
}


@end
