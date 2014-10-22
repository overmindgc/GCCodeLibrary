//
//  MainNavigationViewController.m
//  CodeLibrary
//      主NavigationViewController
//  Created by 辰 宫 on 14/10/22.
//  Copyright (c) 2014年 overmindgc. All rights reserved.
//

#import "MainNavigationViewController.h"
#import "MainDesktopViewController.h"
#import "LeftNavViewController.h"

@interface MainNavigationViewController ()

@end

@implementation MainNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBarHidden = YES;
    LeftNavViewController *leftVC = [[LeftNavViewController alloc] init];
    
    MainDesktopViewController *desktop = [[MainDesktopViewController alloc] initWithNibName:@"MainDesktopViewController" bundle:nil];
    
    ICSDrawerController *drawer = [[ICSDrawerController alloc] initWithLeftViewController:leftVC
                                                                     centerViewController:desktop];
    self.viewControllers = @[drawer];
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

@end
