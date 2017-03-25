//
//  DXFMDBViewController.m
//  SuDaxiStudyPointDemo
// 04-FMDB基本使用
//  Created by SYQ on 2017/3/14.
//  Copyright © 2017年 SYQ. All rights reserved.
//

#import "DXFMDBViewController.h"
#import "Masonry.h"
#import "UIView+ZR.h"
#import "FMDatabase.h"
@interface DXFMDBViewController ()
@property (strong, nonatomic)  UITextField *txtField;
@property (strong, nonatomic)  FMDatabase *database;
@end

@implementation DXFMDBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initSubviews];
    
    [self openDatabase];
// Do any additional setup after loading the view.
}
-(void)openDatabase{
    //NSDocumentDirectory 是指程序中对应的Documents路径
    //而NSDocumentionDirectory对应于程序中的Library/Documentation路径，这个路径是没有读写权限的，所以看不到文件生成。
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"student.db"];
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    //create建表
    /*
     具体文件路径，如果不存在会自动创建
     空字符串@""，会在临时目录创建一个空的数据库，当FMDatabase连接关闭时，数据库文件也被删除。
     nil，会创建一个内存中临时数据库，当FMDatabase连接关闭时，数据库会被销毁。
     */
    if ([database open]) {
        //创建表格
        BOOL res = [database executeUpdate:@"CREATE TABLE IF NOT EXISTS t_student (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL);;"];
        if (res) {
            NSLog(@"创表成功");
        }else{
             NSLog(@"创表失败");
        }
    }
    self.database = database;
}
- (void)backAction:(id)sender {
    [self delete];
    [self insert];
    [self query];
}

-(void)delete{
    for (int i = 0; i < 10; i++) {
        [self.database executeUpdate:@"DROP TABLE IF EXISTS t_student;"];
        [self.database executeUpdate:@"CREATE TABLE IF NOT EXISTS t_student (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL);"];
    }
}

-(void)insert{
    for (int i = 0; i < 10; i++) {
        NSString *name = [NSString stringWithFormat:@"daxi-%d",arc4random_uniform(100)];
        [self.database executeUpdate:@"INSERT INTO t_student (name, age) VALUES (?, ?);",name,@(arc4random_uniform(40))];
    }
}

-(void)query{
    //1/执行查询语句
    FMResultSet *resultSet = [self.database executeQuery:@"SELECT * FROM t_student"];
    //2/遍历结果
    while ([resultSet next]) {
        int ID = [resultSet intForColumn:@"id"];
        NSString *name = [resultSet stringForColumn:@"name"];
        int age = [resultSet intForColumn:@"age"];
        NSLog(@"%d %@ %d", ID, name, age);
    }
}

-(void)initSubviews{
    
    UILabel *l = [UILabel new];
    l.text = @"FMDB";
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
