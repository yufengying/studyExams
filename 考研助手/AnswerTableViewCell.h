//
//  AnswerTableViewCell.h
//  考研助手
//
//  Created by zhuzhu on 16/2/6.
//  Copyright © 2016年 zhuzhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnswerTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UIImageView *numberImage;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;

@end
