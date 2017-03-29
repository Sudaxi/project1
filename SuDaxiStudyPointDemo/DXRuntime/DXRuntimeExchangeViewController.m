//
//  DXRuntimeExchangeViewController.m
//  SuDaxiStudyPointDemo
//
//  Created by SuDaxi on 2017/3/28.
//  Copyright © 2017年 SYQ. All rights reserved.
//

#import "DXRuntimeExchangeViewController.h"
#import "DXImage.h"
#import "DXRuntimeAddMethodViewController.h"
/*
 Runtime(交换方法):主要想修改系统的方法实现
 
 需求:
 
 比如说有一个项目,已经开发了2年,忽然项目负责人添加一个功能,每次UIImage加载图片,告诉我是否加载成功
 
 当系统提供的控件不能满足我们的需求的时候，我们可以
 
 1：通过继承系统控件，重写系统的方法，来扩充子类的行为（super的调用三种情况）
 2：当需要为系统类扩充别的属性或是方法的时候，与哪个类有关系，就为哪个类创建分类。3：利用runtime修改系统的类，增加属性，交换方法，消息机制，动态增加方法
 
 解决方法：1：重写系统的方法：新建类继承系统的类，重写系统的方法（要是覆盖父类的行为就不需要调用super，或是在super方法之下调用:在保留父类super原有的行为后，扩充子类自己的行为，代码写在super之上，可以修改super要传递的参数，例如重写setframe，要是想保留父类的行为就不要忘记调用super）。弊端：需要在每个类中都需要引入头文件 2：写分类：为哪个系统的类扩充属性和方法，就为哪个类写分类 3：利用runtime底层的实现来修改或是访问系统的类：增加属性，交换方法，消息机制，动态增加方法
 
 3：本需求利用runtime：不需要导入头文件，调用的还是系统类原来的方法，只是利用了runtime的交换方法。
 给系统的imageNamed添加功能,只能使用runtime(交互方法)
 1.给系统的方法添加分类
 2.自己实现一个带有扩展功能的方法
 3.交互方法,只需要交互一次,
 
 1.自定义UIImage
 2.UIImage添加分类
 
 */
@interface DXRuntimeExchangeViewController ()

@end

@implementation DXRuntimeExchangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"runtime_exchange";
    [self dx_setLeftBarButtonItem];
    //runtime实现
     // imageNamed => xmg_imageNamed 交互这两个方法实现
    UIImage *image = [UIImage imageNamed:@"newperson_back"];
    NSLog(@"runtime——--%@",image);
    
    DXImage *dx_image = [DXImage dx1_imageNamed:@"newperson_back"];
    NSLog(@"继承——--%@",dx_image);
    
    NextClickView *v = [[NextClickView alloc] initWithFrame:CGRectMake(self.view.centerX - 50, self.view.centerY * 0.4, 100, 50)];
    @weakify(self);
    v.clickBlock = ^(){
        @strongify(self);
        [self.navigationController pushViewController:[DXRuntimeAddMethodViewController new] animated:YES];
    };
    [self.view addSubview:v];
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
