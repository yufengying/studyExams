//
//  Tools.h
//  考研助手
//
//  Created by zhuzhu on 16/2/7.
//  Copyright © 2016年 zhuzhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Tools : NSObject
+(NSArray *)getAnswerWithString:(NSString *)str;
+(CGSize)getSizeWithString:(NSString *)str with:(UIFont *)font withSize:(CGSize)size;
@end
