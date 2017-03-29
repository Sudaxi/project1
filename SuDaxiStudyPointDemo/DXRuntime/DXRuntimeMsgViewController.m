//
//  DDXRuntimeMsgViewController.m
//  SuDaxiStudyPointDemo
//
//  Created by SuDaxi on 2017/3/25.
//  Copyright © 2017年 SYQ. All rights reserved.
//

#import "DXRuntimeMsgViewController.h"
#import <objc/message.h>
#import "Person.h"
#import "DXRuntimeExchangeViewController.h"
@interface DXRuntimeMsgViewController ()

@end

@implementation DXRuntimeMsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"runtime";
    [self dx_setLeftBarButtonItem];
    self.isHiddenNavBarLine = YES;
    // Do any additional setup after loading the view.
    [self runtimeTest];
    
    NextClickView *v = [[NextClickView alloc] initWithFrame:CGRectMake(self.view.centerX - 50, self.view.centerY * 0.4, 100, 50)];
    @weakify(self);
    v.clickBlock = ^(){
        @strongify(self);
           [self.navigationController pushViewController:[DXRuntimeExchangeViewController new] animated:YES];
    };
    [self.view addSubview:v];
}

-(void)runtimeTest{
    //runtime简称运行时。OC就是运行时机制，也就是在运行时候的一些机制，其中最主要的是消息机制。
    //OC函数属于动态调用过程，在编译的时候并不能决定真正调用那个函数，只有在真正运行的时候才会根据函数的名称找到对应函数来调用。
    
    /**
     * 1:objc_getClass("Person")表示获得类对象，sel_registerName("alloc")表示注册一个方法
       2:调用eat：是对象调用eat，消息机制就是谁发送的什么消息：objc_msgSend(p, @selector(eat));
     */
        Person *p = [Person alloc];
//    Person *p = objc_msgSend(objc_getClass("Person"), sel_registerName("alloc"));
    
    
        p = [p init];
//    p = objc_msgSend(p, sel_registerName("init"));
    
    
    
    // 调用run
        [p run];
//    objc_msgSend(p, @selector(run));
    //    objc_msgSend(p, @selector(run:),20);
    
}
/**
 1:一个对象的初始化方法可分解为两步：alloc 来开辟内存空间，init来初始化：id objc = [NSObject alloc];开辟内存空间的时候获得一个类对象，类对象在初始化得到一个对象objc = [objc init];
 
 2：上述初始化的过程用runtime来实现：
 
 //id objc = [NSObject alloc];
 id objc = objc_msgSend([NSObject class], @selector(alloc));
 //objc = [objc init];
 objc = objc_msgSend(objc, @selector(init));
 *
 */
- (void)test
{
        id objc = [NSObject alloc];
//    id objc = objc_msgSend([NSObject class], @selector(alloc));
    
        objc = [objc init];
//    objc = objc_msgSend(objc, @selector(init));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 总结：
 1：
 runtime:必须要导入头文件 <objc/message.h>，此头文件中已经引入了<objc/runtime.h>
 任何方法调用本质:发送一个消息,用runtime发送消息.OC底层实现通过runtime实现
 验证:方法调用,是否真的是转换为消息机制
 runtime都有一个前缀,谁的事情使用谁
 
 
 2：((NSObject *(*)(id, SEL))(void *)objc_msgSend)([NSObject class], @selector(alloc));
 
 此段代码可简化为：objc_msgSend([NSObject class], @selector(alloc));,其中(NSObject *(*)(id, SEL))此为一个函数指针，返回值类型为NSObject *，参数为(id, SEL))，id代表谁发送的消息 ，SEL：函数入口，发送什么消息
 
 xcode6之前,苹果运行使用objc_msgSend.而且有参数提示
 xcode6苹果不推荐我们使用runtime
 
 3：解决消息机制方法提示步骤
 查找build setting -> 搜索msg，设置为NO，一般配置信息都在build setting中设置，build Phases一般是引入系统框架和设置参与编译的.m文件，.h文件不参与编译
 最终生成消息机制,编译器做的事情
 最终代码,需要把当前代码重新编译,用xcode编译器,clang
 
 4：runtime:方法都是有前缀,谁的事情谁开头
 开发中使用场景:
 需要用到runtime,消息机制
 1.装逼
 2.不得不用runtime消息机制,可以调用系统API中或是框架中的私有方法
 
 5：消息机制的调用过程：
 面试:
 方法调用流程
 怎么去调用eat方法 ,对象方法:类对象的方法列表 类方法:元类中方法列表
 1.通过isa去对应的类中查找
 2.注册方法编号
 3.根据方法编号去查找对应方法
 4.找到只是最终函数实现地址,根据地址去方法区调用对应函数
 
 过程：一个对象被初始化后，内部会有一个isa指针，指向类对象（类对象的方法列表），类对象中会有一个方法列表，此时会根据方法列表注册方法编号，方法编号对应方法列表，根据方法编号查找对应的方法，找到的只是最终函数的实现地址，根据地址去内存中的方法区调用对应函数
 
 
 
 内存的5大区
 1.栈 2.堆 3.静态区 4.常量区 5.方法区
 1.栈:不需要手动管理内存,自动管理
 2.堆,需要手动管理内存,自己去释放
 
 */

@end
