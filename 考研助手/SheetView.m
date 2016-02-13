

//
//  SheetView.m
//  考研助手
//  Created by zhuzhu on 16/2/12.
//  Copyright © 2016年 zhuzhu. All rights reserved.
//

#import "SheetView.h"
@interface SheetView(){
    //UIView *_backView;
    UIView *_superView;
    BOOL _startMoving;
    float _height;
    float _width;
    float _y;
    UIScrollView *_scrollView;
    int _count;
}
@end

@implementation SheetView

-(instancetype)initWithFrame:(CGRect)frame WithSuperView:(UIView *)superView andQuesCount:(int)count{
    self = [self initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        //基础初始化的坐标位置
        _height = frame.size.height;
        _width = frame.size.width;
        _superView = superView;
        _y = frame.origin.y;
        _count = count;
        [self createView];//创建下面题目点击按钮
        [self createUpView];//创建正确与否的数目
    }
    return self;
}

-(void)createView{
    _backView = [[UIView alloc]initWithFrame:_superView.frame];
    _backView.backgroundColor = [UIColor blackColor];
    _backView.alpha = 0;
    [_superView addSubview:_backView];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 70,self.frame.size.width, self.frame.size.height-70)];
    [self addSubview:_scrollView];
    for (int i = 0;  i<_count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake((_width-46*6)/2+46*(i%6), 10+46*(i/6), 40, 40);
        btn.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
        if (i==0) {
            btn.backgroundColor = [UIColor orangeColor];
        }
        [btn setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 8;
        btn.tag = 101+i;
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:btn];
    }
    int tip = (_count%6)?1:0;
    _scrollView.contentSize = CGSizeMake(0, 20+46*(_count/6+1+tip));
}

- (void)createUpView {
    _label = [[UILabel alloc]initWithFrame:CGRectMake(40, 30, 300, 40)];
    _label.text = [NSString stringWithFormat:@"正确的题目数:%d 错误的题目数:%d 还剩%d题未做",0,0,0];
    _label.font = [UIFont systemFontOfSize:14];
    [self addSubview:_label];
}

-(void)click:(UIButton *)btn{
    int index =(int) btn.tag-100;
    for (int i=0; i<_count; i++) {
        UIButton *button = (UIButton *)[self viewWithTag:i+101];
        if (i!=index-1) {
            button.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
        }else{
            button.backgroundColor = [UIColor orangeColor];
        }
    }
    [_delegate SheetViewClick:index];
    NSLog(@"%@",_ansArray);
}

//-(void) setImageWith:(NSMutableArray *)arr{
//    _ansArray = [[NSMutableArray alloc]initWithArray:arr];
//    for (int i =0; i<_count; i++) {
//        UIButton *button1 = (UIButton *)[self viewWithTag:i+101];
//        NSString *temp = _ansArray[i];
//        
//        if ([temp isEqualToString:@"0"]) {
//            button1.backgroundColor = [UIColor grayColor];
//        }else if([temp isEqualToString:@"1"]){
//            button1.backgroundColor = [UIColor greenColor];
//        }else if([temp isEqualToString:@"-1"]){
//            button1.backgroundColor =[UIColor redColor];
//        }
//    }
//}

//point 为点击点在SheetView中的相对位置  self.frame.origin.y是当前的在父控件中的相对位置
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:[touch view]];
    if(point.y < 25){
        _startMoving = YES;
    }
    if (_startMoving && self.frame.origin.y >= _y - _height && [self convertPoint:point toView:_superView].y>=80) {
        self.frame = CGRectMake(0, [self convertPoint:point toView:_superView].y, _width, _height);
        float offset = self.frame.origin.y/(self.frame.size.height-80);
        _backView.alpha = (1-offset) * 0.8;
    }
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _startMoving = NO;
    if (self.frame.origin.y>_y-_height/2) {
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = CGRectMake(0, _y, _width, _height);
            _backView.alpha = 0;
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = CGRectMake(0, _y - _height, _width, _height);
            _backView.alpha = 0.8;
        }];
    }
}

@end
