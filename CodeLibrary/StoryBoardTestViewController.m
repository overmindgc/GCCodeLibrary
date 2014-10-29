//
//  StoryBoardTestViewController.m
//  CodeLibrary
//
//  Created by 辰 宫 on 14/10/29.
//  Copyright (c) 2014年 overmindgc. All rights reserved.
//

#import "StoryBoardTestViewController.h"

@interface StoryBoardTestViewController ()

@end

@implementation StoryBoardTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backToRoot:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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
