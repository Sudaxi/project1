//
//  DXFMDBDispatchViewController.m
//  SuDaxiStudyPointDemo
// 05-FMDB数据库队列
//  Created by SYQ on 2017/3/16.
//  Copyright © 2017年 SYQ. All rights reserved.
//

#import "DXFMDBDispatchViewController.h"
#import "Masonry.h"
#import "UIView+ZR.h"
#import "FMDB.h"
@interface DXFMDBDispatchViewController ()
@property (strong, nonatomic)  UITextField *txtField;
@property (strong, nonatomic)  FMDatabaseQueue *queue;
@end

@implementation DXFMDBDispatchViewController

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
    //1、获得数据库文件的路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"person.db"];
    //2、获得数据库队列
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:path];
    //create建表
    /*
     具体文件路径，如果不存在会自动创建
     空字符串@""，会在临时目录创建一个空的数据库，当FMDatabase连接关闭时，数据库文件也被删除。
     nil，会创建一个内存中临时数据库，当FMDatabase连接关闭时，数据库会被销毁。
     */
    //3、打开数据库
    [queue inDatabase:^(FMDatabase *db) {
        //4、创表
        BOOL result = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_person (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL);"];
        if (result) {
            NSLog(@"创表成功");
        }else{
            NSLog(@"创表失败");
        }
    }];
    self.queue = queue;
}
- (void)backAction:(id)sender {
    //先清空之前的表数据
   [self delete];
    //先插入数据，之后查询结果
    [self insert];
    [self query];

}

-(void)delete{
    [self.queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"DROP TABLE IF EXISTS t_person;"];
        [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_person (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL);"];
    }];
}

-(void)insert{
    //插入数据库
    /*
     [self.queue inDatabase:^(FMDatabase *db) {
     [db executeUpdate:@"INSERT INTO t_person (name, age) VALUES (?, ?);",@"wendingding", @22];
     }];
     */
//    事务代码处理：
//1/    　　把多条语句添加到一个事务中去执行：
    /*
    [self.queue inDatabase:^(FMDatabase *db) {
        [db beginTransaction];
        [db executeUpdate:@"INSERT INTO t_person (name, age) VALUES (?, ?);",@"sudaxi", @22];
        [db executeUpdate:@"INSERT INTO t_person (name, age) VALUES (?, ?);",@"sudaxi", @23];
        [db executeUpdate:@"INSERT INTO t_person (name, age) VALUES (?, ?);",@"sudaxi", @24];
        [db executeUpdate:@"INSERT INTO t_person (name, age) VALUES (?, ?);",@"sudaxi", @25];
        [db commit];
    }];
     */
//    如果中途出现问题，那么会自动回滚，也可以选择手动回滚。
    /*
    [self.queue inDatabase:^(FMDatabase *db) {
        [db beginTransaction];
        [db executeUpdate:@"INSERT INTO t_person (name, age) VALUES (?, ?);",@"sudaxi", @22];
        [db executeUpdate:@"INSERT INTO t_person (name, age) VALUES (?, ?);",@"sudaxi", @23];
        [db executeUpdate:@"INSERT INTO t_person (name, age) VALUES (?, ?);",@"sudaxi", @24];
        [db rollback];
        [db executeUpdate:@"INSERT INTO t_person (name, age) VALUES (?, ?);",@"sudaxi", @25];
        [db commit];
    }];
    */
//    上面的代码。前三条插入语句是作废的。
    
    //事务处理的另一种方式：说明：先开事务，再开始事务，之后执行block中的代码段，最后提交事务。
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [db executeUpdate:@"INSERT INTO t_person (name, age) VALUES (?, ?);",@"sudaxi", @22];
        [db executeUpdate:@"INSERT INTO t_person (name, age) VALUES (?, ?);",@"sudaxi", @23];
        [db executeUpdate:@"INSERT INTO t_person (name, age) VALUES (?, ?);",@"sudaxi", @24];
    }];
}

-(void)query{
    //查询数据库
    [self.queue inDatabase:^(FMDatabase *db) {
        //1执行查询语句
        FMResultSet *resultset = [db executeQuery:@"SELECT * FROM t_person"];
        //2/遍历结果
        while ([resultset next]) {
            int ID = [resultset intForColumn:@"id"];
            NSString *name = [resultset stringForColumn:@"name"];
            int age = [resultset intForColumn:@"age"];
            NSLog(@"%d %@ %d", ID, name, age);
        }
    }];

}

-(void)initSubviews{
    
    UILabel *l = [UILabel new];
    l.text = @"FMDBDispatch";
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

@end
