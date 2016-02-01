//
//  ViewController.m
//  考研助手
//
//  Created by zhuzhu on 16/1/30.
//  Copyright © 2016年 zhuzhu. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import "SelectView.h"
@interface ViewController ()
{
    SelectView * _selectView;
    
    __weak IBOutlet UIButton *selectBtn;
}
@end

@implementation ViewController
- (IBAction)click:(UIButton *)sender {
    switch (sender.tag) {
        case 100:{
            // selectBtn = sender;
            [UIView animateWithDuration:0.3 animations:^{
                _selectView.alpha = 1;
            }];
        }
            break;
        case 101:{
            [self.navigationController pushViewController:[[FirstViewController alloc]init] animated:YES];
        }
            break;
        
        case 102:{
        }
            break;
        
        case 103:{
        }
            break;
        
        case 104:{
        }
            break;
        
        case 105:{
            [self.navigationController pushViewController:[[FirstViewController alloc]init] animated:YES];
        }
            break;
        
        case 106:{
            [UIView animateWithDuration:0.3 animations:^{
                _selectView.alpha = 1;
            }];
        }
            break;
        case 107:{
            [UIView animateWithDuration:0.3 animations:^{
                _selectView.alpha = 1;
            }];
        }
            break;
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _selectView = [[SelectView alloc]initWithFrame:self.view.frame andBtn:selectBtn];
    _selectView.alpha = 0;
    [self.view addSubview:_selectView];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
