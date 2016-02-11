//
//  SelectModelView.h
//  考研助手
//
//  Created by zhuzhu on 16/2/11.
//  Copyright © 2016年 zhuzhu. All rights reserved.
//
/*
    选择答题模式或背题模式的uiview
 */
#import <UIKit/UIKit.h>
typedef enum {
    testModel,
    lookingModel
}SelectModel;
typedef void (^SelectTouch)(SelectModel model);
@interface SelectModelView : UIView

@property (nonatomic,assign)SelectModel model;
-(SelectModelView *)initWithFrame:(CGRect)frame addTouch:(SelectTouch)touch;

@end
