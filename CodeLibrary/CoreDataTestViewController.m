//
//  CoreDataTestViewController.m
//  CodeLibrary
//
//  Created by 辰 宫 on 14/12/1.
//  Copyright (c) 2014年 overmindgc. All rights reserved.
//

#import "CoreDataTestViewController.h"
#import "CoreDateManager.h"

@interface CoreDataTestViewController ()

@end

@implementation CoreDataTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CoreDateManager *coreManager = [[CoreDateManager alloc] init];
    
//    NSMutableArray *newsArray = [[NSMutableArray alloc] init];
//    NSMutableDictionary *newsDict1 = [[NSMutableDictionary alloc] init];
//    [newsDict1 setValue:@"新闻标题1" forKey:@"title"];
//    [newsArray addObject:newsDict1];
//    [coreManager insertCoreData:newsArray];
    
    NSMutableArray *result = [coreManager selectData:10 andOffset:0];
    for (News *news in result) {
        NSLog(@"%@",news.title);
    }
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
