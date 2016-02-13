//
//  AnswerViewController.m
//  考研助手
//
//  Created by zhuzhu on 16/2/6.
//  Copyright © 2016年 zhuzhu. All rights reserved.
//

#import "AnswerViewController.h"
#import "AnswerScrollView.h"
#import "MyDataManager.h"
#import "AnswerModel.h"
#import "SelectModelView.h"
#import "SheetView.h"

@interface AnswerViewController ()
{
    AnswerScrollView * _answerScrollerView;
    SelectModelView * _SelectModelView;
    SheetView *_sheeetView;
    NSMutableArray *_arr;
    NSMutableArray *_isRightArr;
    int _rightAns;
    int _wrongAns;
}
@end

@implementation AnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _rightAns=0;
    _wrongAns = 0;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    [self createData];
    
    
    [self.view addSubview:_answerScrollerView];
    _answerScrollerView.delegate = self;
    //判断所选答案的正确性
    _isRightArr = [[NSMutableArray alloc]initWithArray:_answerScrollerView.isAnswerArray];
    //NSLog(@"%@,",_isRightArr);

    [self createToolBar];
    [self createModelView];
    [self createSheetView];
    
}

-(void)createData{
    if(_type==1){
        _arr = [NSMutableArray array];
        NSArray * array = [MyDataManager getData:answer];
        
        for (int i=0; i<array.count-1; i++) {
            AnswerModel *model = array[i];
            if ([model.pid intValue]==_number+1) {
                [_arr addObject:model];
            }
        }
        
        _answerScrollerView = [[AnswerScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64-60) withDataArray:_arr];
    }else if(_type ==2){
        //顺序练习处理
        _answerScrollerView = [[AnswerScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64-60) withDataArray:[MyDataManager getData:answer]];

    }else if(_type ==3 ){
        //随机练习
        NSMutableArray * temArr = [[NSMutableArray alloc]init];
        NSArray *array = [MyDataManager getData:answer];
        NSMutableArray *dataArray = [[NSMutableArray alloc]init];
        [temArr addObjectsFromArray:array];
        for (int i=0; i<temArr.count; ) {
            int index = arc4random()%(temArr.count);
            [dataArray addObject:temArr[index]];
            [temArr removeObjectAtIndex:index];
        }
        _answerScrollerView = [[AnswerScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64-60) withDataArray:dataArray];
    }else if (_type ==4){
        _arr = [NSMutableArray array];
        NSArray * array = [MyDataManager getData:answer];
        
        for (int i=0; i<array.count-1; i++) {
            AnswerModel *model = array[i];
            if ([model.sid isEqualToString:_subStrNumber]) {
                [_arr addObject:model];
            }
        }
        
        _answerScrollerView = [[AnswerScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64-60) withDataArray:_arr];
    }

}

-(void)createSheetView{
    _sheeetView = [[SheetView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-80) WithSuperView:self.view andQuesCount:(int)_arr.count];
    _sheeetView.delegate = self;
    [self.view addSubview:_sheeetView];
}

-(void)createModelView{
    _SelectModelView = [[SelectModelView alloc]initWithFrame:self.view.frame addTouch:^(SelectModel model) {
        NSLog(@"当前模式：%d",model);
    }];
    
    [self.view addSubview:_SelectModelView];
    _SelectModelView.alpha = 0;
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"答题模式" style:UIBarButtonItemStylePlain target:self action:@selector(modelChange:)];
    self.navigationItem.rightBarButtonItem = item;
}

-(void)modelChange:(UIBarButtonItem *)item{
    [UIView animateWithDuration:0.3 animations:^{
        _SelectModelView.alpha = 1;
    }];
}

//创建答题界面的tabar
-(void)createToolBar{
    UIView * barView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-60-64, self.view.frame.size.width, 60)];
    barView.backgroundColor = [UIColor whiteColor];
    NSArray * arr = @[[NSString stringWithFormat:@"共%ld题",_answerScrollerView.dataArray.count],@"查看答案",@"收藏本题"];
    for (int i = 0; i<3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(self.view.frame.size.width/3*i+self.view.frame.size.width/3/2-22, 0, 36, 36);
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",16+i]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d-2.png",16+i]] forState:UIControlStateHighlighted];
        btn.tag = 301+i;
        [btn addTarget:self action:@selector(clickToolBar:) forControlEvents:UIControlEventTouchUpInside];
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(btn.center.x-30, 40, 60, 18)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = arr[i];
        label.font = [UIFont systemFontOfSize:12];
        [barView addSubview:btn];
        [barView addSubview:label];
    }
    [self.view addSubview:barView];
}

-(void)clickToolBar:(UIButton *)btn{
    switch (btn.tag) {
        case 301://查看答案
        {
            [UIView animateWithDuration:0.3 animations:^{
                _sheeetView.frame = CGRectMake(0, 80, self.view.frame.size.width, self.view.frame.size.height-80);
                //访问SheetView中的_backView.h的public属性 用 "->"访问
                _sheeetView->_backView.alpha = 0.8;
            }];
        }
            break;
        case 302://查看答案
        {
            if ([_answerScrollerView.hadAnswerArray[_answerScrollerView.currentPage]intValue]!=0) {
                return;
            }else{
                AnswerModel *model = [_answerScrollerView.dataArray objectAtIndex:_answerScrollerView.currentPage];
                NSString * answer = model.manswer;
                NSLog(@"%@",answer);
                char an = [answer characterAtIndex:0];
                [_answerScrollerView.hadAnswerArray replaceObjectAtIndex:_answerScrollerView.currentPage withObject:[NSString stringWithFormat:@"%d",an-'A'+1]];
                [_answerScrollerView reloadData];
            } 
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - SheetViewDelegate
-(void)SheetViewClick:(int)index{
    //_answerScrollerView.currentPage = index;
    UIScrollView *scroll = _answerScrollerView->_scrollView;
    scroll.contentOffset = CGPointMake((index-1)*scroll.frame.size.width, 0);
    [scroll.delegate scrollViewDidEndDecelerating:scroll];
}

#pragma mark -AnswerScrollViewDelegate
-(void)AnswerScrollViewClick{
    _isRightArr = [[NSMutableArray alloc]initWithArray:_answerScrollerView.isAnswerArray];
    //NSLog(@"%@",_isRightArr);
    for (int i = 0;i<_isRightArr.count;i++) {
        if ([_isRightArr[i] isEqualToString:@"1"]) {
            _rightAns++;

        }else if ([_isRightArr[i] isEqualToString:@"-1"]){
            _wrongAns++;
        }
    }
    [_sheeetView setImageWith:_isRightArr];
    //_sheeetView.ansArray = [[NSMutableArray alloc]initWithArray:_isRightArr];
    _sheeetView.label.text = [NSString stringWithFormat:@"正确 :%d 道题 错误 :%d 道题 还剩 %d 题未做",_rightAns,_wrongAns,(int)_isRightArr.count-_rightAns-_wrongAns];
    _rightAns = 0;
    _wrongAns =0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
