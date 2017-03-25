//
//  DXNotificationViewController.m
//  SuDaxiStudyPointDemo
//
//  Created by SYQ on 2017/3/13.
//  Copyright © 2017年 SYQ. All rights reserved.
//

#import "DXNotificationViewController.h"
#import "Masonry.h"
#import "UIView+ZR.h"

@interface DXNotificationViewController ()
@property (strong, nonatomic)  UITextField *txtField;
@end

@implementation DXNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initSubviews];
}
-(void)initSubviews{
    
    UILabel *l = [UILabel new];
    l.text = @"Notify";
    l.font = [UIFont systemFontOfSize:34];
    [self.view addSubview:l];
    
    UILabel *la = [UILabel new];
    la.text = @"这里写上传的值";
    la.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:la];
    
    UITextField *txtField = [UITextField new];
    txtField.borderStyle = UITextBorderStyleRoundedRect;
    txtField.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:txtField];
    self.txtField = txtField;
    
    UIButton *btn = [UIButton new];
    btn.backgroundColor = [UIColor orangeColor];
    btn.layer.cornerRadius = 5.0;
    btn.layer.masksToBounds = YES;
    [btn setTitle:@"点我返回" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [l mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(80);
        make.centerX.equalTo(self.view);
    }];
    
    [la mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(l.mas_bottom).offset(40);
        make.centerX.equalTo(self.view);
    }];
    
    [self.txtField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(la.mas_bottom).offset(5);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(200);
    }];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.txtField.mas_bottom).offset(20);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(200, 40));
    }];
}
- (void)backAction:(id)sender {
    //1.创建userInfo携带的信息
    NSString *str  = self.txtField.text;
    NSDictionary *dic = [NSDictionary dictionaryWithObject:str forKey:@"MyUserInfoKey"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MyNotificationName" object:nil userInfo:dic];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
