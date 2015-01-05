//
//  PNChartTestViewController.h
//  CodeLibrary
//
//  Created by 辰 宫 on 15/1/5.
//  Copyright (c) 2015年 overmindgc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNChartDelegate.h"
#import "PNChart.h"

@interface PNChartTestViewController : UIViewController <PNChartDelegate>

@property (nonatomic) PNLineChart * lineChart;
@property (nonatomic) PNBarChart * barChart;
@property (nonatomic) PNCircleChart * circleChart;
@property (nonatomic) PNPieChart *pieChart;
@property (nonatomic) PNScatterChart *scatterChart;


@property (weak, nonatomic) IBOutlet UISegmentedControl *segmented;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *changeValueButton;
- (IBAction)changeValue:(id)sender;
- (IBAction)segmentedChangeValue:(id)sender;

@end
