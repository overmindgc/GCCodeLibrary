//
//  ColorfulButtonCell.m
//  CodeLibrary
//
//  Created by 辰 宫 on 14-10-14.
//  Copyright (c) 2014年 overmindgc. All rights reserved.
//

#import "ColorfulButtonCell.h"

@implementation ColorfulButtonCell

- (void)awakeFromNib {
    // Initialization code
}

/*重写init方法*/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 初始化时加载collectionCell.xib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"ColorfulButtonCell" owner:self options:nil];
        
        // 如果路径不存在，return nil
        if (arrayOfViews.count < 1)
        {
            return nil;
        }
        // 如果xib中view不属于UICollectionViewCell类，return nil
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]])
        {
            return nil;
        }
        // 加载nib
        self = [arrayOfViews objectAtIndex:0];
    }
    return self;
}

@end
