//
//  DXRuntimeAddPropertyViewController.m
//  SuDaxiStudyPointDemo
//
//  Created by SYQ on 2017/3/29.
//  Copyright © 2017年 SYQ. All rights reserved.
//

#import "DXRuntimeAddPropertyViewController.h"
#import "NSObject+Property.h"

/**
 *    总结：1：动态添加属性:什么时候需要动态添加属性 开发场景：给系统的类添加属性的时候,可以使用runtime动态添加属性方法 本质:动态添加属性,就是让某个属性与对象产生关联。runtime一般都是针对系统的类
 2：让一个NSObject类 保存一个字符串：可以为系统的类写一个分类，属性定义某个变量：在分类中属性定义某个变量，则只会对该变量生成set，get方法的声明，不会生成实现，需要自己去写实现方法，也不会生成带下划线的成员变量。若要是想让外界访问该成员变量，1：可以在分类中用static定义全局变量，在get方法的实现中返回该成员变量 弊端：当该类销毁的时候，该属性的成员变量也不会销毁 2：在分类中利用runtime动态添加属性
 */

@interface DXRuntimeAddPropertyViewController ()

@end

@implementation DXRuntimeAddPropertyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"runtime_addProperty";
    [self dx_setLeftBarButtonItem];
    
    NSObject *objc = [[NSObject alloc] init];
    objc.name = @"123";
    NSLog(@"runtime_addproperty--%@",objc.name);
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.centerX - 50, self.view.centerY * 0.4, 100, 50)];
    [btn DX_setUpCustomBtn];
    [self.view addSubview:btn];
    
//    Person *p = [Person new];
//    //这里的私有变量 height ,假如直接使用Setter、Getter方法访问，就会出现下面的错误。
//    /*
//     p->skinColor = @"yellowColor";//@"yellowColor";调用私有变量的Setter
//     NSLog(@"person's skin is %@",p->skinColor);//p->skinColor调用私有变量的Getter
//     */
//    
//    // 这时候可以使用KVC来访问这个私有变量：
//    [p setValue:@"yellowColor" forKey:@"skinColor"];//给私有变量赋值
//    NSLog(@"person's skin is %@",[p valueForKey:@"skinColor"]);//读取私有变量的值
    
    
    // Do any additional setup after loading the view.
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
