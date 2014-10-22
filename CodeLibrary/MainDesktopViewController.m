//
//  MainDesktopViewController.m
//  CodeLibrary
//  桌面控制器
//  Created by 辰 宫 on 14-10-13.
//  Copyright (c) 2014年 overmindgc. All rights reserved.
//

#import "MainDesktopViewController.h"
#import "ColorfulButtonCell.h"

static NSString * const colorfulCellReuseId = @"colorfulCellReuseId";

@interface MainDesktopViewController ()

/*桌面块颜色*/
@property (nonatomic, strong) NSArray *colorLibrary;

@property (nonatomic, strong) NSArray *sourceLibrary;

@property (nonatomic, strong) NSArray *currSourceArray;

@end

@implementation MainDesktopViewController

@synthesize colorLibrary;

@synthesize sourceLibrary;

@synthesize currSourceArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    colorLibrary = @[[UIColor colorWithRed:19.0f/255.0f green:168.0f/255.0f blue:157.0f/255.0f alpha:1.0f],
                     [UIColor colorWithRed:232.0f/255.0f green:82.0f/255.0f blue:112.0f/255.0f alpha:1.0f],
                     [UIColor colorWithRed:66.0f/255.0f green:130.0f/255.0f blue:166.0f/255.0f alpha:1.0f],
                     [UIColor colorWithRed:112.0f/255.0f green:178.0f/255.0f blue:130.0f/255.0f alpha:1.0f],
                     [UIColor colorWithRed:238.0f/255.0f green:116.0f/255.0f blue:95.0f/255.0f alpha:1.0f],
                     [UIColor colorWithRed:35.0f/255.0f green:156.0f/255.0f blue:182.0f/255.0f alpha:1.0f],
                     [UIColor colorWithRed:175.0f/255.0f green:202.0f/255.0f blue:119.0f/255.0f alpha:1.0f],
                     [UIColor colorWithRed:238.0f/255.0f green:142.0f/255.0f blue:82.0f/255.0f alpha:1.0f],
                     [UIColor colorWithRed:4.0f/255.0f green:184.0f/255.0f blue:205.0f/255.0f alpha:1.0f],
                     [UIColor colorWithRed:203.0f/255.0f green:215.0f/255.0f blue:108.0f/255.0f alpha:1.0f],
                     [UIColor colorWithRed:249.0f/255.0f green:162.0f/255.0f blue:75.0f/255.0f alpha:1.0f],
                     [UIColor colorWithRed:103.0f/255.0f green:199.0f/255.0f blue:189.0f/255.0f alpha:1.0f],
                     [UIColor colorWithRed:217.0f/255.0f green:70.0f/255.0f blue:84.0f/255.0f alpha:1.0f],
                     [UIColor colorWithRed:237.0f/255.0f green:181.0f/255.0f blue:58.0f/255.0f alpha:1.0f],
                     [UIColor colorWithRed:138.0f/255.0f green:204.0f/255.0f blue:164.0f/255.0f alpha:1.0f],
                     [UIColor colorWithRed:140.0f/255.0f green:86.0f/255.0f blue:143.0f/255.0f alpha:1.0f],
                     [UIColor colorWithRed:235.0f/255.0f green:196.0f/255.0f blue:79.0f/255.0f alpha:1.0f],
                     [UIColor colorWithRed:3.0f/255.0f green:201.0f/255.0f blue:169.0f/255.0f alpha:1.0f]];
    
    sourceLibrary = @[[NSDictionary dictionaryWithObjects:@[@"1",@"1",@"UITableView示例",@"TableViewExampleTableViewController"] forKeys:@[@"typeId",@"orderId",@"labelText",@"className"]],
                      [NSDictionary dictionaryWithObjects:@[@"1",@"2",@"UICollectionView示例",@""] forKeys:@[@"typeId",@"orderId",@"labelText",@"className"]],
                      [NSDictionary dictionaryWithObjects:@[@"2",@"1",@"MyView",@""] forKeys:@[@"typeId",@"orderId",@"labelText",@"className"]],
                      [NSDictionary dictionaryWithObjects:@[@"3",@"1",@"Navigation示例",@""] forKeys:@[@"typeId",@"orderId",@"labelText",@"className"]],
                      [NSDictionary dictionaryWithObjects:@[@"4",@"1",@"图片模糊",@""] forKeys:@[@"typeId",@"orderId",@"labelText",@"className"]],
                      [NSDictionary dictionaryWithObjects:@[@"5",@"1",@"画板",@""] forKeys:@[@"typeId",@"orderId",@"labelText",@"className"]],
                      [NSDictionary dictionaryWithObjects:@[@"6",@"1",@"下载进度",@""] forKeys:@[@"typeId",@"orderId",@"labelText",@"className"]],
                      [NSDictionary dictionaryWithObjects:@[@"7",@"1",@"autoLayeOut",@""] forKeys:@[@"typeId",@"orderId",@"labelText",@"className"]],
                      [NSDictionary dictionaryWithObjects:@[@"8",@"1",@"tip手势示例",@""] forKeys:@[@"typeId",@"orderId",@"labelText",@"className"]],
                      [NSDictionary dictionaryWithObjects:@[@"9",@"1",@"陀螺仪",@""] forKeys:@[@"typeId",@"orderId",@"labelText",@"className"]]];
    
    currSourceArray = sourceLibrary;
    
    [self.collectionView registerClass:[ColorfulButtonCell class] forCellWithReuseIdentifier:colorfulCellReuseId];
    
    UIView *tableBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.collectionView.frame.size.width, self.collectionView.frame.size.height)];
    tableBgView.backgroundColor = [UIColor colorWithRed:107.0f/255.0f green:185.0f/255.0f blue:240.0f/255.0f alpha:1.0f];
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [tipLabel setTextColor:[UIColor colorWithWhite:1.0 alpha:1.0f]];
    tipLabel.text = @"© https://github.com/overmindgc/GCCodeLibrary";
    [tipLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12]];
    //文字加阴影效果
    tipLabel.layer.shadowOpacity = 0.5;
    tipLabel.layer.shadowOffset = CGSizeZero;
    tipLabel.layer.shadowRadius = 0.5;
    [tableBgView addSubview:tipLabel];
    [self.collectionView setBackgroundView:tableBgView];
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

#pragma mark - Configuring the view’s layout behavior

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - ICSDrawerControllerPresenting

- (void)drawerControllerWillOpen:(ICSDrawerController *)drawerController
{
    self.view.userInteractionEnabled = NO;
}

- (void)drawerControllerDidClose:(ICSDrawerController *)drawerController
{
    self.view.userInteractionEnabled = YES;
}

#pragma mark - Open drawer button

- (IBAction)openDrawer:(id)sender {
    [self.drawer open];
}

#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return currSourceArray.count;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ColorfulButtonCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:colorfulCellReuseId forIndexPath:indexPath];

//    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    NSDictionary *currDict = [currSourceArray objectAtIndex:indexPath.row];
    UIColor *cellColor = [colorLibrary objectAtIndex:(indexPath.row + colorLibrary.count) % colorLibrary.count];
    cell.backgroundColor = cellColor;
    cell.titleLabel.text = [currDict objectForKey:@"labelText"];
    cell.className = [currDict objectForKey:@"className"];
    
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    if ((indexPath.row + 1) % 3 == 0) {
//        return CGSizeMake(SCREEN_WIDTH - SCREEN_WIDTH / 3 * 2, SCREEN_WIDTH/3);
//    } else {
        return CGSizeMake(SCREEN_WIDTH/3, SCREEN_WIDTH/2.8);
//    }
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0;
}

//cell的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0;
}


#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ColorfulButtonCell * cell = (ColorfulButtonCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    cell.backgroundColor = [UIColor whiteColor];
    
    Class currClass = NSClassFromString(cell.className);
    
    id currView = [[currClass alloc] init];
    
    if (currView) {
        [self.navigationController pushViewController:currView animated:YES];
    }
    
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

@end