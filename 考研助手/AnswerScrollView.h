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

@protocol AnswerScrollViewDelegate
-(void)AnswerScrollViewClick;

@end

@interface AnswerScrollView : UIView{
    @public
    UIScrollView *_scrollView;
    //NSMutableArray *_isAnswerArray;
}
- (instancetype)initWithFrame:(CGRect)frame withDataArray:(NSArray *)array;
@property(nonatomic,assign,readonly)int currentPage;
@property(nonatomic,strong)NSMutableArray *hadAnswerArray;//判断是否有答案的数组
@property(nonatomic,strong)NSMutableArray *isAnswerArray;//统计答案正确与否的数组
@property (nonatomic,strong) NSArray *dataArray;//答案数组
@property (nonatomic,weak)id<AnswerScrollViewDelegate> delegate;
-(void)reloadData;
@end
