//
//  NineGridPasswordView.h
//  CodeLibrary
//
//  Created by 辰 宫 on 14/11/3.
//  Copyright (c) 2014年 overmindgc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NineGridPasswordView;

@protocol NineGridPasswordDelegate <NSObject>

/*密码输入正确回调*/
- (void)passwordView:(NineGridPasswordView *)passwordView withCorrectPassword:(NSString *)password;

/*密码输入错误回调*/
- (void)passwordView:(NineGridPasswordView *)passwordView withErrorPassword:(NSInteger)errorTime;

@end

@interface NineGridPasswordView : UIView

@property (nonatomic, weak) id<NineGridPasswordDelegate>delegete;

/*正确的密码*/
@property (nonatomic, copy) NSString *correctPassword;

@end
