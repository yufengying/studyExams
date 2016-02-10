//
//  AnswerScrollView.m
//  考研助手
//
//  Created by zhuzhu on 16/2/6.
//  Copyright © 2016年 zhuzhu. All rights reserved.
//

#import "AnswerScrollView.h"
#import "AnswerTableViewCell.h"
#import "AnswerModel.h"
#import "Tools.h"
#define SIZE self.frame.size
@interface AnswerScrollView()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>{

}
@end 

@implementation AnswerScrollView{
    UIScrollView *_scrollView;
    UITableView * _leftTableView;
    UITableView *_mainTableView;
    UITableView *_rightTableView;
    //NSArray * _dataArray;
    //NSMutableArray *_hadAnswerArray;
}

-(instancetype)initWithFrame:(CGRect)frame withDataArray:(NSArray *)array{
    self = [super initWithFrame:frame];
    if (self) {
        _currentPage = 0;
        _dataArray = [[NSArray alloc]initWithArray:array];
        _hadAnswerArray = [NSMutableArray array];
        for (int i =0; i<array.count; i++) {
            [_hadAnswerArray addObject:@"0"];
            
        }
        _scrollView = [[UIScrollView alloc]initWithFrame:frame];
        _scrollView.delegate = self;
        _leftTableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
        _mainTableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
        _rightTableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
        _leftTableView.delegate = self;
        _mainTableView.delegate = self;
        _rightTableView.delegate = self;
        _leftTableView.dataSource = self;
        _mainTableView.dataSource = self;
        _rightTableView.dataSource = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        if (_dataArray.count>1) {
            _scrollView.contentSize = CGSizeMake(SIZE.width*2, 0);
        }
        
        [self createView];
    }
    return  self;
}

-(void)createView{
    _leftTableView.frame = CGRectMake(0, 0, SIZE.width, SIZE.height);
    _mainTableView.frame = CGRectMake(SIZE.width, 0, SIZE.width, SIZE.height);
    _rightTableView.frame = CGRectMake(SIZE.width*2, 0, SIZE.width, SIZE.height);
    [_scrollView addSubview:_leftTableView];
    [_scrollView addSubview:_mainTableView];
    [_scrollView addSubview:_rightTableView];
    [self addSubview:_scrollView];
}

#pragma mark - tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height ;
    AnswerModel * model = [self getTheFitModel:tableView];
    if ([model.mtype intValue]==1) {
        NSString * str = [[Tools getAnswerWithString:model.mquestion]objectAtIndex:0];
        UIFont *font = [UIFont systemFontOfSize:16];
        height = [Tools getSizeWithString:str with:font withSize:CGSizeMake(tableView.frame.size.width-20,400)].height+20;
    }else {
        NSString * str = model.mquestion;
        UIFont *font = [UIFont systemFontOfSize:16];
        height = [Tools getSizeWithString:str with:font withSize:CGSizeMake(tableView.frame.size.width-20,400)].height+20;
    }
    if (height<=80) {
        return 80;
    }else{
        return height;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    AnswerModel * model = [self getTheFitModel:tableView];
    NSString *str = [NSString stringWithFormat:@"答案解析：%@",model.mdesc];
    UIFont *font = [UIFont systemFontOfSize:16];
    return [Tools getSizeWithString:str with:font withSize:CGSizeMake(tableView.frame.size.width-20, 400)].height + 20;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    CGFloat height;
    NSString * str;
    AnswerModel * model = [self getTheFitModel:tableView];

    str = [NSString stringWithFormat:@"答案解析：%@",model.mdesc];
    UIFont *font = [UIFont systemFontOfSize:16];
    height = [Tools getSizeWithString:str with:font withSize:CGSizeMake(tableView.frame.size.width-20,400)].height+20;
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE.width, height)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, tableView.frame.size.width-20, height-20)];
    label.text = str;
    label.font = [UIFont systemFontOfSize:16];
    label.numberOfLines = 0;
    label.textColor = [UIColor greenColor];
    [view addSubview:label];
    int page = [self getQuestionNumber:tableView andCurrentPage:_currentPage];
    
    if ([_hadAnswerArray[page-1] intValue]!=0) {
        return view;
    }
    
    return nil;

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CGFloat height;
    NSString * str;
    AnswerModel * model = [self getTheFitModel:tableView];
    if ([model.mtype intValue]==1) {
        str = [[Tools getAnswerWithString:model.mquestion]objectAtIndex:0];
        UIFont *font = [UIFont systemFontOfSize:16];
        height = [Tools getSizeWithString:str with:font withSize:CGSizeMake(tableView.frame.size.width-20,400)].height+20;
    }else {
        str = model.mquestion;
        UIFont *font = [UIFont systemFontOfSize:16];
        height = [Tools getSizeWithString:str with:font withSize:CGSizeMake(tableView.frame.size.width-20,400)].height+20;
    }
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE.width, height)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, tableView.frame.size.width-20, height-20)];
    
    label.text = [NSString stringWithFormat:@"%d.%@",[self getQuestionNumber:tableView andCurrentPage:_currentPage],str];
    
    label.font = [UIFont systemFontOfSize:16];
    label.numberOfLines = 0;
    [view addSubview:label];
    return view;
}

#pragma mark  获取当前问题的数目
-(int)getQuestionNumber:(UITableView *)tableView andCurrentPage:(int)page{
    if (tableView == _leftTableView && page ==0) {
        return 1;
    }else if (tableView == _leftTableView && page>0){
        return page;
    }else if (tableView == _mainTableView && page>0 && page< _dataArray.count-1){
        return page+1;
    }else if (tableView == _mainTableView && page == 0){
        return 2;
    }else if (tableView ==_mainTableView && page==_dataArray.count-1){
        return page;
    }else if (tableView == _rightTableView && page<_dataArray.count-1){
        return page+2;
    }else if (tableView == _rightTableView && page == _dataArray.count-1){
        return  page+1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellID = @"AnswerTableViewCell";
    AnswerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell==nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"AnswerTableViewCell" owner:self options:nil]lastObject];
        cell.numberLabel.layer.masksToBounds = YES;
        cell.numberLabel.layer.cornerRadius = 10;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.numberLabel.text = [NSString stringWithFormat:@"%c",(char)('A'+indexPath.row)];
    AnswerModel *model = [self getTheFitModel:tableView];
    if ([model.mtype intValue]==1) {
        cell.answerLabel.text = [[Tools getAnswerWithString:model.mquestion]objectAtIndex:indexPath.row+1];
    }
    
    int page = [self getQuestionNumber:tableView andCurrentPage:_currentPage];
    if ([_hadAnswerArray[page-1] intValue]!=0) {
        if ([model.manswer isEqualToString:[NSString stringWithFormat:@"%c",'A'+(int)indexPath.row]]) {
            cell.numberImage.hidden = NO;
            cell.numberImage.image = [UIImage imageNamed:@"19.png"];
        }
        //if (![model.manswer isEqualToString:[NSString stringWithFormat:@"%c",'A'+[_hadAnswerArray[page-1] intValue]-1]] && indexPath.row==[_hadAnswerArray[page-1] intValue]-1) {
        else if (![model.manswer isEqualToString:[NSString stringWithFormat:@"%c",'A'+(int)indexPath.row]] && indexPath.row==[_hadAnswerArray[page-1] intValue]-1) {
            cell.numberImage.hidden = NO;
            cell.numberImage.image = [UIImage imageNamed:@"20.png"];
        }else{
            cell.numberImage.hidden = YES;
        }
        //点击错误答案后，加载tableView时显示点击过的错误答案与正确答案
    }else{
        cell.numberImage.hidden = YES;
    }
    return cell;
}

//获取当前tableView的模型数据的模型数据
-(AnswerModel *)getTheFitModel:(UITableView *)tableView{
    AnswerModel *model;
    if (tableView == _leftTableView && _currentPage == 0) {
        model = _dataArray[_currentPage];
    } else if(tableView == _leftTableView && _currentPage>0) {
        model = _dataArray[_currentPage-1];
    } else if (tableView == _mainTableView &&_currentPage==0){
        model = _dataArray[_currentPage+1];
    } else if (tableView == _mainTableView && _currentPage>0&& _currentPage<_dataArray.count-1){
        model = _dataArray[_currentPage];
    } else if (tableView == _mainTableView && _currentPage==_dataArray.count-1){
        model = _dataArray[_currentPage-1];
    } else if (tableView == _rightTableView && _currentPage == _dataArray.count-1){
        model = _dataArray[_currentPage];
    } else if (tableView == _rightTableView && _currentPage <_dataArray.count -1){
        model =_dataArray[_currentPage+1];
    }
    return model;
}
//每当滑动结束时调用，当显示的tableView不是第一个与最后一个时，默认显示的是中间的_mainTableView，然后分别计算出两边的_leftTableView与_rightTableView的frame
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint currentOffset = scrollView.contentOffset;
    int page = (int)currentOffset.x/SIZE.width;
    if (page<_dataArray.count-1 && page>0) {
        _scrollView.contentSize = CGSizeMake(currentOffset.x+SIZE.width*2, 0);
        _mainTableView.frame = CGRectMake(currentOffset.x, 0, SIZE.width, SIZE.height);
        _leftTableView.frame = CGRectMake(currentOffset.x-SIZE.width, 0, SIZE.width, SIZE.height);
        _rightTableView.frame = CGRectMake(currentOffset.x+SIZE.width, 0, SIZE.width, SIZE.height);
        
    }
    _currentPage = page;
    [self reloadData];
}

-(void)reloadData{
    [_leftTableView reloadData];
    [_rightTableView reloadData];
    [_mainTableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int page = [self getQuestionNumber:tableView andCurrentPage:_currentPage];
    if ([_hadAnswerArray[page -1] intValue]!=0) {
        return;
    }else{
        [_hadAnswerArray replaceObjectAtIndex:page-1 withObject:[NSString stringWithFormat:@"%ld",indexPath.row+1]];
    }
    
    [self reloadData];
}

@end
