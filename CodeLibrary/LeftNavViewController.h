//
//  LeftNavViewController.h
//  CodeLibrary
//
//  Created by 辰 宫 on 14-10-13.
//  Copyright (c) 2014年 overmindgc. All rights reserved.
//

#import "ICSDrawerController.h"

@interface LeftNavViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, ICSDrawerControllerChild, ICSDrawerControllerPresenting>

@property(nonatomic, weak) ICSDrawerController *drawer;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *types;

@end
