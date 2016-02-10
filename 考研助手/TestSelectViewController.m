//
//  TestSelectViewController.m
//  考研助手
//
//  Created by zhuzhu on 16/2/2.
//  Copyright © 2016年 zhuzhu. All rights reserved.
//

/*
  章节练习界面
 */

#import "TestSelectViewController.h"
#import "TestSelectTableViewCell.h"
#import "TestSelectModel.h"
#import "AnswerViewController.h"

@interface TestSelectViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}
@end

@implementation TestSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title =_myTitle;
    [self createTableView];
}

- (void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

#pragma mark - tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"TestSelectTableViewCell";
    TestSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:cellID owner:self options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.numberLabel.layer.masksToBounds = YES;
        cell.numberLabel.layer.cornerRadius = 8;
    }
    TestSelectModel * model = _dataArray[indexPath.row];
    cell.numberLabel.text = model.pid;
    cell.titleLabel.text = model.pname;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AnswerViewController * avc = [[AnswerViewController alloc]init];
    avc.number = indexPath.row;
    [self.navigationController pushViewController:avc animated:YES];
}

@end
