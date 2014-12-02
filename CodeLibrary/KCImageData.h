//
//  KCImageData.h
//  CodeLibrary
//
//  Created by 辰 宫 on 14/11/26.
//  Copyright (c) 2014年 overmindgc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KCImageData : NSObject

#pragma mark 索引
@property (nonatomic,assign) int index;

#pragma mark 图片数据
@property (nonatomic,strong) NSData *data;

@end