//
//  CoreDateManager.h
//  CodeLibrary
//
//  Created by 辰 宫 on 14/12/2.
//  Copyright (c) 2014年 overmindgc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "News.h"
#define TableName @"News"

@interface CoreDateManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

//插入数据
- (void)insertCoreData:(NSMutableArray*)dataArray;
//查询
- (NSMutableArray*)selectData:(int)pageSize andOffset:(int)currentPage;
//删除
- (void)deleteData;
//更新
- (void)updateData:(NSString*)newsId withIsLook:(NSString*)islook;

@end
