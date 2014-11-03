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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 60, 30)];
    closeBtn.backgroundColor = [UIColor orangeColor];
    [closeBtn setTitle:@"Close" forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    
    NineGridPasswordView *nineGideView = [[NineGridPasswordView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view insertSubview:nineGideView atIndex:0];
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
