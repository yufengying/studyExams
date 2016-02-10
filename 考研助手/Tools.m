//
//  Tools.m
//  考研助手
//
//  Created by zhuzhu on 16/2/7.
//  Copyright © 2016年 zhuzhu. All rights reserved.
//

#import "Tools.h"

@implementation Tools

+(NSArray *)getAnswerWithString:(NSString *)str{
    NSMutableArray *array = [NSMutableArray array];
    NSArray *arr = [str componentsSeparatedByString:@"<BR>"];
    [array addObject:arr[0]];
    for ( int i=0; i<4; i++) {
        [array addObject:[arr[i+1] substringFromIndex:2]];
    }
    return array;
}

+(CGSize)getSizeWithString:(NSString *)str with:(UIFont *)font withSize:(CGSize)size{
    CGSize newSize = [str sizeWithFont:font constrainedToSize:size];
    return newSize;

}
@end
