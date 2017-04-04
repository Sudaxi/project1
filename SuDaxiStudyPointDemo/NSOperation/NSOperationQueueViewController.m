//
//  NSOperationQueueViewController.m
//  SuDaxiStudyPointDemo
//
//  Created by SuDaxi on 2017/4/4.
//  Copyright © 2017年 SYQ. All rights reserved.
//

#import "NSOperationQueueViewController.h"

@interface NSOperationQueueViewController ()
@property (nonatomic, strong) ClickBtn *btn;
@end

@implementation NSOperationQueueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    [self.array0 mutableCopy];
    ClickBtn *btn = [[ClickBtn alloc] init];
    //    WithFrame:CGRectMake((self.view.width - 250)/2, self.view.height*0.5 - 30, 250, 60)
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    self.btn = btn;
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(140);
        make.centerX.equalTo(self.view);
        //        make.width.height.equalTo(@30);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
}

-(void)click{
    NSLog(@"点击到了区域");
    [self noDependency];
}
-(void)noDependency{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^(){
        NSLog(@"执行第1次操作：%@",[NSThread currentThread]);
    }];
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"执行第2次操作：%@",[NSThread currentThread]);
    }];
    
        //没有设置依赖关系
//    [queue addOperation:operation1];
//    [queue addOperation:operation2];
    /*
     可以看出，默认是按照添加顺序执行的，先执行operation1，再执行operation2
     2017-04-04 11:06:54.619 SuDaxiStudyPointDemo[1467:40191] 执行第1次操作：<NSThread: 0x608000261300>{number = 3, name = (null)}
     2017-04-04 11:06:54.619 SuDaxiStudyPointDemo[1467:40190] 执行第2次操作：<NSThread: 0x6080002613c0>{number = 4, name = (null)}
    */
     //设置依赖关系
    [operation1 addDependency:operation2];
    [queue addOperation:operation1];
    [queue addOperation:operation2];
    /*
     可以看出，先执行operation2，再执行operation1
     2017-04-04 11:31:33.771 SuDaxiStudyPointDemo[1615:48221] 执行第2次操作：<NSThread: 0x60000026b900>{number = 3, name = (null)}
     2017-04-04 11:31:33.772 SuDaxiStudyPointDemo[1615:48211] 执行第1次操作：<NSThread: 0x60000026a000>{number = 4, name = (null)}
     
     */
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
