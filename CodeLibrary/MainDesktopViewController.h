//
//  MainDesktopViewController.h
//  CodeLibrary
//
//  Created by 辰 宫 on 14-10-13.
//  Copyright (c) 2014年 overmindgc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICSDrawerController.h"

@interface MainDesktopViewController : UIViewController <ICSDrawerControllerChild, ICSDrawerControllerPresenting, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property(nonatomic, weak) ICSDrawerController *drawer;

@property (weak,nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UINavigationItem *titleLabel;

@property (nonatomic, copy) NSString *typeId;

/*更改title文字*/
- (void)changeTitleText:(NSString *)text;

@end
