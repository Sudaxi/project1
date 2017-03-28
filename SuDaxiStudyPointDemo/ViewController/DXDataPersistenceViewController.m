//
//  DXDataPersistenceViewController.m
//  SuDaxiStudyPointDemo
//
//  Created by SYQ on 2017/3/14.
//  Copyright © 2017年 SYQ. All rights reserved.
//

#import "DXDataPersistenceViewController.h"
#import "Masonry.h"
#import "UIView+ZR.h"
#import "Person.h"

@interface DXDataPersistenceViewController ()<UITextFieldDelegate>
@property (strong, nonatomic)  UITextField *txtField;
@property (strong, nonatomic)  UILabel *label;
@end

@implementation DXDataPersistenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initSubviews];
    
    //数据持久化
    [self dataPersistentTest];

}
-(void)dataPersistentTest{
    //"应用程序包": 这里面存放的是应用程序的源文件，包括资源文件和可执行文件。
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSLog(@"应用程序--%@", path);
    //Documents: 最常用的目录，iTunes同步该应用时会同步此文件夹中的内容，适合存储重要数据。
    NSString *path1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSLog(@"Documents--%@", path1);
    //Library/Caches: iTunes不会同步此文件夹，适合存储体积大，不需要备份的非重要数据。
    NSString *path2 = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSLog(@"Documents--%@", path2);
    //Library/Preferences: iTunes同步该应用时会同步此文件夹中的内容，通常保存应用的设置信息。
    /*
    每个用户都有自己的独特偏好设置，而好的应用会让用户根据喜好选择合适的使用方式，把这些偏好记录在应用包的plist文件中，通过NSUserDefaults类来访问，这是NSUserDefaults的常用姿势。如果有一些设置你希望用户即使升级后还可以继续使用，比如玩游戏时得过的最高分、喜好和通知设置、主题颜色甚至一个用户头像，那么你可以使用NSUserDefaults来存储这些信息，如果有更多需求，可以了解数据持久化相关的知识。
     */
    
    //1.获得NSUserDefaults文件
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //2.向文件中写入内容//###存
    [defaults setObject:@"sudaxi" forKey:@"name"];
    [defaults setBool:YES forKey:@"sex"];
    [defaults setInteger:26 forKey:@"age"];
    
    //2.1立即同步
    [defaults synchronize];
    //3.读取文件//###读
    UIImage *image = [UIImage imageNamed:@"动画ipg"];
    NSData *imagedata = UIImageJPEGRepresentation(image, 100);//把image归档为NSData
    [defaults setObject:imagedata forKey:@"image"];
    
    NSString *name = [defaults objectForKey:@"name"];
    NSInteger age = [defaults integerForKey:@"age"];
//    BOOL sex = [defaults boolForKey:@"sex"];
//    NSData *imagedata1 = [defaults dataForKey:@"image"];
//    UIImage *image1 = [UIImage imageWithData:imagedata1];
    NSLog(@"--%@",name);
    NSLog(@"--%ld",(long)age);
    
    
    
    //tmp: iTunes不会同步此文件夹，系统可能在应用没运行时就删除该目录下的文件，所以此目录适合保存应用中的一些临时文件，用完就删除。
    NSString *path4 = NSTemporaryDirectory();
    NSLog(@"Documents--%@", path4);
    
    //1/获得文件路径
    NSString *path6 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *fileName = [path6 stringByAppendingPathComponent:@"123.plist"];
    
    //2/存储
    NSArray *arr = @[@"123",@"456",@"789"];
    [arr writeToFile:fileName atomically:YES];
    
    //3/读取
    NSArray *result = [NSArray arrayWithContentsOfFile:fileName];
    NSLog(@"plist--%@",result);
    
    /*
     遵循NSCoding协议
     需要把对象归档是调用NSKeyedArchiver的工厂方法 archiveRootObject: toFile: 方法。
     */
    NSArray *codePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *file = [codePath.firstObject stringByAppendingPathComponent:@"person.data"];
    Person *p = [Person new];
    p.names = self.label.text;
    p.age = arc4random() % 10;
    [NSKeyedArchiver archiveRootObject:p toFile:file];
    

}

- (void)backAction:(id)sender {
    //    [self.navigationController popViewControllerAnimated:YES];
    // 需要从文件中解档对象就调用NSKeyedUnarchiver的一个工厂方法 unarchiveObjectWithFile: 即可。
    NSString *file = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"person.data"];
    Person *p = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
    if (p) {
        self.txtField.text = p.names;
    }
}

-(void)initSubviews{
    
    UILabel *l = [UILabel new];
    l.text = @"DataPersistence";
    l.font = [UIFont systemFontOfSize:34];
    [self.view addSubview:l];
    self.label = l;
    
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
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(80);
        make.centerX.equalTo(self.view);
    }];
    
    [la mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label.mas_bottom).offset(40);
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
