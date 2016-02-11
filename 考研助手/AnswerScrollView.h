//
//  AnswerScrollView.h
//  考研助手
//
//  Created by zhuzhu on 16/2/6.
//  Copyright © 2016年 zhuzhu. All rights reserved.
//
/*
 答题界面的左右划定scrollview
 */

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@interface AnswerScrollView : UIView
- (instancetype)initWithFrame:(CGRect)frame withDataArray:(NSArray *)array;
@property(nonatomic,assign,readonly)int currentPage;
@property(nonatomic,strong)NSMutableArray *hadAnswerArray;
@property (nonatomic,strong) NSArray *dataArray;;
-(void)reloadData;
@end
