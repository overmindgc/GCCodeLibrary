//
//  NineGridPasswordViewController.m
//  CodeLibrary
//
//  Created by 辰 宫 on 14/11/3.
//  Copyright (c) 2014年 overmindgc. All rights reserved.
//

#import "NineGridPasswordViewController.h"
#import "NineGridPasswordView.h"

@interface NineGridPasswordViewController ()

@end

@implementation NineGridPasswordViewController

@synthesize titleLabel,passwordLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    passwordLabel.text = @"";
    
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 60, 30)];
    closeBtn.backgroundColor = [UIColor orangeColor];
    [closeBtn setTitle:@"Close" forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    
    double gridViewWidth = SCREEN_WIDTH * 0.83;
    double gridY = SCREEN_HEIGHT - gridViewWidth - SCREEN_WIDTH * 0.195 - 10;
    NineGridPasswordView *nineGideView = [[NineGridPasswordView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - gridViewWidth / 2, gridY, gridViewWidth, gridViewWidth)];
    nineGideView.delegete = self;
    nineGideView.correctPassword = @"167294385";
    [self.view addSubview:nineGideView];
}

//设置状态栏亮白色样式
- (UIStatusBarStyle)preferredStatusBarStyle
{
    // Even if this view controller hides the status bar, implementing this method is still needed to match the center view controller's
    // status bar style to avoid a flicker when the drawer is dragged and then left to open.
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark NineGridPasswordDelegate
/*密码输入正确回调*/
- (void)passwordView:(NineGridPasswordView *)passwordView withCorrectPassword:(NSString *)password
{
    [titleLabel setTextColor:[UIColor colorWithRed:128.0f/255.0f green:128.0f/255.0f blue:128.0f/255.0f alpha:1.0f]];
    [passwordLabel setTextColor:[UIColor colorWithRed:128.0f/255.0f green:128.0f/255.0f blue:128.0f/255.0f alpha:1.0f]];
    titleLabel.text = @"恭喜你密码正确";
    passwordLabel.text = password;
}

/*密码输入错误回调*/
- (void)passwordView:(NineGridPasswordView *)passwordView withErrorPassword:(NSInteger)errorTime
{
    [titleLabel setTextColor:[UIColor colorWithRed:208.0f/255.0f green:52.0f/255.0f blue:19.0f/255.0f alpha:1.0f]];
    [passwordLabel setTextColor:[UIColor colorWithRed:208.0f/255.0f green:52.0f/255.0f blue:19.0f/255.0f alpha:1.0f]];
    titleLabel.text = @"对不起密码输入错误";
    passwordLabel.text = [NSString stringWithFormat:@"%ld次",errorTime];
}

- (void) closeAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
