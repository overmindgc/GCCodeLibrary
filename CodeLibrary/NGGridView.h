//
//  NGGridView.h
//  CodeLibrary
//
//  Created by 辰 宫 on 14/11/3.
//  Copyright (c) 2014年 overmindgc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NGGridArrowAngle) {
    NGGridArrowAngleNone = -1,
};

@interface NGGridView : UIView

/*格子编号*/
@property NSInteger *gridNo;

@property BOOL isSelected;

/*默认未选中颜色*/
@property (nonatomic, strong) UIColor *defaultColor;
/*选中的颜色*/
@property (nonatomic, strong) UIColor *selectedColor;
/*错误的颜色*/
@property (nonatomic, strong) UIColor *errorColor;
/*选中的圆填充颜色*/
@property (nonatomic, strong) UIColor *circleFillColor;

- (void)setSelected:(BOOL)selected withArrowAngle:(NSInteger)angle isError:(BOOL)error;

@end
