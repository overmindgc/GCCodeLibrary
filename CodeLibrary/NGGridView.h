//
//  NGGridView.h
//  CodeLibrary
//
//  Created by 辰 宫 on 14/11/3.
//  Copyright (c) 2014年 overmindgc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NGGridView : UIView

/*格子编号*/
@property NSInteger *gridNo;

@property BOOL isSelected;

@property BOOL isError;

- (void)setSelected:(BOOL)selected withError:(BOOL)error;

@end
