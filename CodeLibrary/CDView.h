//
//  CDView.h
//  CodeLibrary
//
//  Created by 辰 宫 on 14/11/18.
//  Copyright (c) 2014年 overmindgc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDView : UIView

@property (nonatomic, copy) NSString *cdImageName;

/*CD视图旋转开始或结束*/
- (void)routeStartOrStop;

@end
