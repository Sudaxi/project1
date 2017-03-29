//
//  DXRuntimeAddViewController.m
//  SuDaxiStudyPointDemo
//
//  Created by SYQ on 2017/3/29.
//  Copyright © 2017年 SYQ. All rights reserved.
//

#import "DXRuntimeAddMethodViewController.h"
#import "Animals.h"
#import "DXRuntimeAddPropertyViewController.h"
/*
 1：
 Runtime(动态添加方法):OC都是懒加载机制,只要一个方法实现了,就会马上添加到方法列表中.
 app:免费版,收费版
 QQ,微博,直播等等应用,都有会员机制
 performSelector：去执行某个方法。performSelector withObject ：object为前面方法的参数
 
 2：
 美团有个面试题?有没有使用过performSelector,什么时候使用?动态添加方法的时候使用过?怎么动态添加方法?用runtime?为什么要动态添加方法?
 */

@interface DXRuntimeAddMethodViewController ()

@end

@implementation DXRuntimeAddMethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"runtime_addMethod";
    [self dx_setLeftBarButtonItem];
    // Do any additional setup after loading the view.
    //    _cmd:当前方法的方法编号
    Animals *ani = [[Animals alloc] init];
    // 执行某个方法
    //    [p performSelector:@selector(eat)];
    [ani performSelector:@selector(run:) withObject:@10];
    
    NextClickView *v = [[NextClickView alloc] initWithFrame:CGRectMake(self.view.centerX - 50, self.view.centerY * 0.4, 100, 50)];
    @weakify(self);
    v.clickBlock = ^(){
        @strongify(self);
        [self.navigationController pushViewController:[DXRuntimeAddPropertyViewController new] animated:YES];
    };
    [self.view addSubview:v];
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
