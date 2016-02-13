//
//  FirstViewController.m
//  考研助手
//
//  Created by zhuzhu on 16/2/1.
//  Copyright © 2016年 zhuzhu. All rights reserved.
//
/*
 实现第一个科目一理论考试界面
 */
#import "FirstViewController.h"
#import "FirstTableViewCell.h"
#import "TestSelectViewController.h"
#import "MyDataManager.h"
#import "AnswerViewController.h"

@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;
    NSArray *_dataArray;
}
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.title = @"科目一：理论考试";
    _dataArray = @[@"章节练习",@"顺序练习",@"随机练习",@"专项练习",@"仿真模拟考试"];
    [self createTableView];
    [self createView];
}

-(void)createView{
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-150, self.view.frame.size.height-64-140, 300, 30)];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.text = @"---------------我的考试分析-----------------";
    [self.view addSubview:lable];
    NSArray * arr = @[@"我的错题",@"我的收藏",@"我的成绩",@"练习统计"];
    for (int i = 0; i<4;i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(self.view.frame.size.width/4*i+self.view.frame.size.width/4/2-30, self.view.frame.size.height-64-100, 60, 60);
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",12+i]] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4*i+self.view.frame.size.width/4/2-30, self.view.frame.size.height-64-25, 60, 20)];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.text = arr[i];
        lab.font = [UIFont boldSystemFontOfSize:13];
        [self.view addSubview:lab];
    }
}

- (void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 250) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPat{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"FirstTableViewCell";
    FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:cellID owner:self options:nil]lastObject];
    }
    cell.myImageVIew.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.png",indexPath.row+7]];
    cell.myLable.text = _dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0://章节练习
        {
            TestSelectViewController *con = [[TestSelectViewController alloc]init];
            con.type = 1;
            con.myTitle = @"章节练习";
            con.dataArray = [MyDataManager getData:chapter];
            UIBarButtonItem *item = [[UIBarButtonItem alloc]init];
            item.title = @"";
            item.tintColor = [UIColor whiteColor];
            self.navigationItem.backBarButtonItem = item;
            [self.navigationController pushViewController:con animated:YES];
        }
            break;
        case 1://顺序练习
        {
            AnswerViewController *answer = [[AnswerViewController alloc]init];
            answer.type = 2;
            [self.navigationController pushViewController:answer animated:YES];
        }
            break;
        case 2://章节练习
        {
            AnswerViewController * answer = [[AnswerViewController alloc]init];
            answer.type = 3;
            [self.navigationController pushViewController:answer animated:YES];
        }
            break;
        case 3://专项练习
        {
            TestSelectViewController *con = [[TestSelectViewController alloc]init];
            con.type = 2;
            con.myTitle = @"专项练习";
            con.dataArray = [MyDataManager getData:subChapter];
            UIBarButtonItem *item = [[UIBarButtonItem alloc]init];
            item.title = @"";
            item.tintColor = [UIColor whiteColor];
            self.navigationItem.backBarButtonItem = item;
            [self.navigationController pushViewController:con animated:YES];
        }
            break;
        default:
            break;
    }
}

@end
