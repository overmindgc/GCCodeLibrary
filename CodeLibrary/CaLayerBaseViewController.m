//
//  CaLayerBaseViewController.m
//  CodeLibrary
//
//  Created by 辰 宫 on 14/11/7.
//  Copyright (c) 2014年 overmindgc. All rights reserved.
//

#import "CaLayerBaseViewController.h"

@interface CaLayerBaseViewController ()

@end

@implementation CaLayerBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 60, 30)];
    closeBtn.backgroundColor = [UIColor orangeColor];
    [closeBtn setTitle:@"Close" forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    
    UIImage *image=[UIImage imageNamed:@"example.jpg"];
    UIImageView *imageView=[[UIImageView alloc]init];
    imageView.image=image;
    imageView.frame=CGRectMake(120, 140, 80, 80);
    [self.view addSubview:imageView];
    
    //两秒后开始一个持续一分钟的动画
    [UIView animateWithDuration:1 delay:2 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        imageView.bounds=CGRectMake(80, 100, 160, 160);
    } completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) closeAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
