//
//  MyDataManager.h
//  考研助手
//
//  Created by zhuzhu on 16/2/6.
//  Copyright © 2016年 zhuzhu. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    chapter,//章节练习
    answer,//答题数据
} DataType;

@interface MyDataManager : NSObject
+ (NSArray *)getData:(DataType)type;
@end
