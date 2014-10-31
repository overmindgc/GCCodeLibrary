//
//  BaseCoreGraphicsViewController.m
//  CodeLibrary
//
//  Created by 辰 宫 on 14/10/31.
//  Copyright (c) 2014年 overmindgc. All rights reserved.
//

#import "BaseCoreGraphicsViewController.h"
#import "BaseCoreGraphicsView.h"

@interface BaseCoreGraphicsViewController ()

@end

@implementation BaseCoreGraphicsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 60, 30)];
    closeBtn.backgroundColor = [UIColor orangeColor];
    [closeBtn setTitle:@"Close" forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    
    BaseCoreGraphicsView *bgView = [[BaseCoreGraphicsView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view insertSubview:bgView atIndex:0];
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
