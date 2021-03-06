//
//  AnswerViewController.h
//  考研助手
//
//  Created by zhuzhu on 16/2/6.
//  Copyright © 2016年 zhuzhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SheetView.h"
@interface AnswerViewController : UIViewController<SheetViewDelegate>
//number为选择的章节数
@property(nonatomic,copy)NSString * subStrNumber;
@property (nonatomic,assign)int number;
//type=1 章节 type=2 顺序练习 type=3 随机练习 type=4专项练习
@property (nonatomic,assign)int type;

@end
