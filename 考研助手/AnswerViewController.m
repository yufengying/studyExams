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
@interface AnswerViewController ()
{
    AnswerScrollView * view;
    SelectModelView * modelView;
}
@end

@implementation AnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    [self createData];
    
    NSMutableArray * arr = [NSMutableArray array];
    NSArray * array = [MyDataManager getData:answer];
    
    for (int i=0; i<array.count-1; i++) {
        AnswerModel *model = array[i];
        if ([model.pid intValue]==_number+1) {
            [arr addObject:model];
        }
    }
    
    view = [[AnswerScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64-60) withDataArray:arr];
    [self.view addSubview:view];
    [self createToolBar];
    [self createModelView];
}

-(void)createData{
    
}

-(void)createModelView{
    modelView = [[SelectModelView alloc]initWithFrame:self.view.frame addTouch:^(SelectModel model) {
        NSLog(@"当前模式：%d",model);
    }];
    
    [self.view addSubview:modelView];
    modelView.alpha = 0;
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"答题模式" style:UIBarButtonItemStylePlain target:self action:@selector(modelChange:)];
    self.navigationItem.rightBarButtonItem = item;
}

-(void)modelChange:(UIBarButtonItem *)item{
    [UIView animateWithDuration:0.3 animations:^{
        modelView.alpha = 1;
    }];
}

//创建答题界面的tabar
-(void)createToolBar{
    UIView * barView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-60-64, self.view.frame.size.width, 60)];
    barView.backgroundColor = [UIColor whiteColor];
    NSArray * arr = @[@"1111",@"查看答案",@"收藏本题"];
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
        case 302://查看答案
        {
            if ([view.hadAnswerArray[view.currentPage]intValue]!=0) {
                return;
            }else{
                AnswerModel *model = [view.dataArray objectAtIndex:view.currentPage];
                NSString * answer = model.manswer;
                NSLog(@"%@",answer);
                char an = [answer characterAtIndex:0];
                [view.hadAnswerArray replaceObjectAtIndex:view.currentPage withObject:[NSString stringWithFormat:@"%d",an-'A'+1]];
                [view reloadData];
            } 
        }
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
