//
//  News.h
//  CodeLibrary
//
//  Created by 辰 宫 on 14/12/2.
//  Copyright (c) 2014年 overmindgc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface News : NSManagedObject

@property (nonatomic, retain) NSString * descr;
@property (nonatomic, retain) NSString * imgurl;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * newsid;
@property (nonatomic, retain) NSString * islook;

@end
