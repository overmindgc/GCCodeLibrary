//
//  LeftNavViewController.h
//  CodeLibrary
//
//  Created by 辰 宫 on 14-10-13.
//  Copyright (c) 2014年 overmindgc. All rights reserved.
//

#import "LeftNavViewController.h"
#import "MainDesktopViewController.h"

static const CGFloat TopViewHight = 30.0f;
static NSString * const ColorsViewControllerCellReuseId = @"ColorsViewControllerCellReuseId";


@interface LeftNavViewController ()

@property (nonatomic, assign) NSInteger previousRow;

@end



@implementation LeftNavViewController
{
    UIColor *bgColor;
    UIColor *selectColor;
}

- (id)init
{
    self = [super init];
    if (self != nil) {
        bgColor = [UIColor colorWithRed:60.0f/255.0f green:60.0f/255.0f blue:60.0f/255.0f alpha:1.0f];
        selectColor = [UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1.0f];
        
        //加载数据源数据
        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"collectionSource.plist"];
        self.types = [[NSArray alloc] initWithContentsOfFile:path];
    }
    return self;
}

#pragma mark - Managing the view

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = bgColor;
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TopViewHight)];
    topView.backgroundColor = selectColor;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(17, 0, 200, TopViewHight)];
    titleLabel.text = @"分类导航";
    titleLabel.textColor = [UIColor whiteColor];
    [topView addSubview:titleLabel];
    [self.view addSubview:topView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TopViewHight, SCREEN_WIDTH, SCREEN_HEIGHT - TopViewHight)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = bgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.separatorColor = [UIColor colorWithRed:40.0f/255.0f green:40.0f/255.0f blue:40.0f/255.0f alpha:1.0f];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ColorsViewControllerCellReuseId];
    
    [self.view addSubview:self.tableView];
}

#pragma mark - Configuring the view’s layout behavior

- (UIStatusBarStyle)preferredStatusBarStyle
{
    // Even if this view controller hides the status bar, implementing this method is still needed to match the center view controller's
    // status bar style to avoid a flicker when the drawer is dragged and then left to open.
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSParameterAssert(self.types);
    return self.types.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSParameterAssert(self.types);
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ColorsViewControllerCellReuseId
                                                            forIndexPath:indexPath];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = selectColor;
    NSDictionary *rowDict = [self.types objectAtIndex:indexPath.row];
    cell.textLabel.text = [rowDict valueForKey:@"typeName"];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.tag = [[rowDict valueForKey:@"typeId"] integerValue];
    cell.backgroundColor = bgColor;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 50.0f;
//}
//
////自定义section样式
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView* myView = [[UIView alloc] init];
//    myView.backgroundColor = bgColor;
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.textColor = [UIColor whiteColor];
//    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
//    titleLabel.text = @"导航";
//    [myView addSubview:titleLabel];
//    return myView;
//}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.previousRow) {
        // Close the drawer without no further actions on the center view controller
        [self.drawer close];
    }
    else {
        // Reload the current center view controller and update its background color
        typeof(self) __weak weakSelf = self;
        NSDictionary *rowDict = [self.types objectAtIndex:indexPath.row];
        [self.drawer reloadCenterViewControllerUsingBlock:^(){
//            weakSelf.drawer.centerViewController.view.backgroundColor = weakSelf.colors[indexPath.row];
            MainDesktopViewController *mainDesktopVC = weakSelf.drawer.centerViewController;
            [mainDesktopVC changeTitleText:[rowDict objectForKey:@"typeName"]];
            [mainDesktopVC loadListViewBy:[rowDict objectForKey:@"child"]];
        }];
        
//        // Replace the current center view controller with a new one
//        ICSPlainColorViewController *center = [[ICSPlainColorViewController alloc] init];
//        center.view.backgroundColor = [UIColor redColor];
//        [self.drawer replaceCenterViewControllerWithViewController:center];
    }
    self.previousRow = indexPath.row;
}

#pragma mark - ICSDrawerControllerPresenting

- (void)drawerControllerWillOpen:(ICSDrawerController *)drawerController
{
    self.view.userInteractionEnabled = NO;
}

- (void)drawerControllerDidOpen:(ICSDrawerController *)drawerController
{
    self.view.userInteractionEnabled = YES;
}

- (void)drawerControllerWillClose:(ICSDrawerController *)drawerController
{
    self.view.userInteractionEnabled = NO;
}

- (void)drawerControllerDidClose:(ICSDrawerController *)drawerController
{
    self.view.userInteractionEnabled = YES;
}

@end
