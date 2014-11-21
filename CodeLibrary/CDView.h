//
//  CDView.h
//  CodeLibrary
//
//  Created by 辰 宫 on 14/11/18.
//  Copyright (c) 2014年 overmindgc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CDViewDelegate <NSObject>

@optional
//切换动画结束
- (void)changeCDAmimationAccomplished;

@end

@interface CDView : UIView

@property (nonatomic, weak) id<CDViewDelegate>delegate;

@property (nonatomic, copy) NSString *cdImageName;

@property BOOL isRotating;

- (void)changeNextWithImageName:(NSString *)newImgName;

/*CD视图旋转开始或结束*/
- (void)rotateStart;
- (void)rotateStop;
@end
