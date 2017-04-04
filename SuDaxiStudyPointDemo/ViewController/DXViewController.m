//
//  DXViewController.m
//  SuDaxiStudyPointDemo
//
//  Created by SYQ on 2017/3/13.
//  Copyright © 2017年 SYQ. All rights reserved.
//

#import "DXViewController.h"
#import "DXBlockViewController.h"
#import "DXDelegateViewController.h"
#import "DXNotificationViewController.h"
#import "DXKVOViewController.h"
#import "DXKVCViewController.h"
#import "DXDataPersistenceViewController.h"
#import "DXFMDBViewController.h"
#import "DXFMDBDispatchViewController.h"
#import "DXRuntimeMsgViewController.h"
#import "DXCornerViewController.h"
#import "NSOperationQueueViewController.h"
#import "DispatchGroupViewController.h"
@interface DXViewController ()<PassByValueDelegate>
@property (nonatomic, copy) NSString *str;
@property (nonatomic, strong) DXKVOViewController *bvc;
@end

@implementation DXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.str = @"初始化";
    // Do any additional setup after loading the view, typically from a nib.
    [self addNotificationObserver];
    [self addKVOobserver];
    
    NextClickView *v = [[NextClickView alloc] initWithFrame:CGRectMake(self.view.centerX - 50, self.view.centerY + 100, 100, 50)];
    @weakify(self);
    v.clickBlock = ^(){
        @strongify(self);
        [self.navigationController pushViewController:[DXCornerViewController new] animated:YES];
    };
    [self.view addSubview:v];
}

- (IBAction)pushToBvc:(id)sender {
    //    [self pushBlockVC];
    //    [self pushDelegateVC];
    //    [self pushNotificationVC];
    //    [self pushKvoVC];
    //    [self pushKvcVC];
//    [self pushDataPersistentVC];
//    [self pushFMDBvc];
//    [self pushFMDBDispatchvc];
//    [self runtimetest];
//    [self NSOperationQueuevc];
    [self dispatchgroupVc];
    
}
-(void)dispatchgroupVc{
    DispatchGroupViewController *vc = [DispatchGroupViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)NSOperationQueuevc{
    NSOperationQueueViewController *vc = [NSOperationQueueViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)runtimetest
{
    DXRuntimeMsgViewController *vc = [DXRuntimeMsgViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)pushFMDBDispatchvc{
    DXFMDBDispatchViewController *dvc = [DXFMDBDispatchViewController new];
    [self.navigationController pushViewController:dvc animated:YES];
}
-(void)pushFMDBvc{
    DXFMDBViewController *vc = [DXFMDBViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)pushDataPersistentVC{
    DXDataPersistenceViewController *vc = [DXDataPersistenceViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)pushKvcVC{
    DXKVCViewController *vc = [DXKVCViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
//-----------------//-----------------//-----------------//
-(void)pushKvoVC{
    [self.navigationController pushViewController:self.bvc animated:YES];
}
    /*
     1.注册对象myKVO为被观察者:option中，
     NSKeyValueObservingOptionOld 以字典的形式提供 “初始对象数据”;      
     NSKeyValueObservingOptionNew 以字典的形式提供 “更新后新的数据”;      
     */
-(void)addKVOobserver
{
    self.bvc = [[DXKVOViewController alloc] init];
    [self.bvc addObserver:self forKeyPath:@"kvoText" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
}
/* 2.只要object的keyPath属性发生变化，就会调用此回调方法，进行相应的处理：UI更新：*/
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"kvoText"]) {
        self.str = [NSString stringWithFormat:@"%@",[change valueForKey:@"new"]];
    }
}
//-----------------//-----------------//-----------------//
-(void)addNotificationObserver{
    //1/注册为观察者，监听B视图中的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(aMethod:) name:@"MyNotificationName" object:nil];
}

-(void)aMethod:(NSNotification *)notification{
   //2/获取通知携带的数据，
    NSDictionary *dic = [notification userInfo];
    self.str = [dic objectForKey:@"MyUserInfoKey"];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    //3、移除所有的通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    /* 3.移除KVO */
    [self.bvc removeObserver:self forKeyPath:@"kvoText"];
}

-(void)pushNotificationVC{
    DXNotificationViewController *bvc = [DXNotificationViewController new];
    [self.navigationController pushViewController:bvc animated:YES];
}
//-----------------//-----------------//-----------------//
-(void)pushBlockVC{
    DXBlockViewController *bvc = [DXBlockViewController new];
    bvc.byValueBlock = ^(NSString *str){
        self.str = str;
    };
    [self.navigationController pushViewController:bvc animated:YES];
}
//-----------------//-----------------//-----------------//
-(void)pushDelegateVC{
    DXDelegateViewController *bvc = [DXDelegateViewController new];
    bvc.delegate = self;
    [self.navigationController pushViewController:bvc animated:YES];
}
-(void)sendValue:(NSString *)value{
    self.str = value;
}
-(void)error{
    
}
//-----------------//-----------------//-----------------//
- (IBAction)clickBtn:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"成功" message:self.str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionA = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:actionA];
    UIAlertAction *actionB = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:actionB];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
