//
//  DXKVCViewController.m
//  SuDaxiStudyPointDemo
//
//  Created by SYQ on 2017/3/14.
//  Copyright © 2017年 SYQ. All rights reserved.
//

#import "DXKVCViewController.h"
#import "Masonry.h"
#import "UIView+ZR.h"
#import "Person.h"

@interface DXKVCViewController ()
@property (strong, nonatomic)  UITextField *txtField;
@end

@implementation DXKVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initSubviews];
    
    [self visitVariable];
    // Do any additional setup after loading the view.
}

-(void)visitVariable{
    Person *p = [Person new];
    //这里的私有变量 height ,假如直接使用Setter、Getter方法访问，就会出现下面的错误。
    /*
     p->skinColor = @"yellowColor";//@"yellowColor";调用私有变量的Setter
     NSLog(@"person's skin is %@",p->skinColor);//p->skinColor调用私有变量的Getter
     */
    
   // 这时候可以使用KVC来访问这个私有变量：
    [p setValue:@"yellowColor" forKey:@"skinColor"];//给私有变量赋值
    NSLog(@"person's skin is %@",[p valueForKey:@"skinColor"]);//读取私有变量的值

}

-(void)initSubviews{
    
    UILabel *l = [UILabel new];
    l.text = @"kvc";
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
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
