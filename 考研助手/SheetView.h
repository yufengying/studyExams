//
//  SheetView.h
//  考研助手
//
//  Created by zhuzhu on 16/2/12.
//  Copyright © 2016年 zhuzhu. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SheetViewDelegate
-(void)SheetViewClick:(int)index;


@end


@interface SheetView : UIView{
    @public
    UIView *_backView;
}
@property (nonatomic,weak)id<SheetViewDelegate> delegate;
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) NSMutableArray *ansArray;

-(instancetype)initWithFrame:(CGRect)frame WithSuperView:(UIView *)superView andQuesCount:(int)count;
-(void) setImageWith:(NSMutableArray *)arr;
@end
