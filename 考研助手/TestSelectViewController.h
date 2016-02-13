//
//  TestSelectViewController.h
//  考研助手
//
//  Created by zhuzhu on 16/2/2.
//  Copyright © 2016年 zhuzhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestSelectViewController : UIViewController

@property(nonatomic,copy)NSString * myTitle;
@property (nonatomic,copy) NSArray *dataArray;
//type=1  章节  2=专项    
@property(nonatomic,assign)int type;

@end
