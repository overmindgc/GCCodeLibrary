//
//  NineGridPasswordViewController.h
//  CodeLibrary
//
//  Created by 辰 宫 on 14/11/3.
//  Copyright (c) 2014年 overmindgc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NineGridPasswordView.h"

@interface NineGridPasswordViewController : UIViewController <NineGridPasswordDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;

@end
