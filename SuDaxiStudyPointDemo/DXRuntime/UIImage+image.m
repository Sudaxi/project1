//
//  UIImage+image.m
//  SuDaxiStudyPointDemo
//
//  Created by SYQ on 2017/3/29.
//  Copyright © 2017年 SYQ. All rights reserved.
//

#import "UIImage+image.h"
#import <objc/runtime.h>

@implementation UIImage (image)
/**
 *  总结：
 1:  + (void)load 与 + (void)initialize的区别：
     + (void)load：当类加载进内存的时候调用，而且不管有没有子类，都只会调用一次，在main函数之前调用，用途：1：可以新建类在该类中实现一些配置信息 2：runtime交换方法的时候，因为只需要交换一次方法，所有可以在该方法中实现交换方法的代码，用于只实现一次的代码  2：+ (void)initialize：当类被初始化的时候调用，可能会被调用多次，若是没有子类，则只会调用一次，若是有子类的话，该方法会被调用多次，若是子类的继承关系，先会调用父类的+ (void)initialize方法，然后再去调用子类的+ (void)initialize方法(若是继承关系，调用某个方法的时候，先会去父类中查找，若是父类中没有方法的实现就去子类中查找) 用途：1：在设置导航栏的全局背景的时候，只需要设置一次，可以重写该方法设置，最好是在该方法判断子类，若是自己，则实现设置全局导航栏的方法，若不是自己则跳过实现。2：在创建数据库代码的时候，可以在该方法中去创建，保证只初始化一次数据库实例，也可以用dispatch或是懒加载的方法中初始化数据库实例，也能保证只初始化一次数据库实例。其中也可以在+ (void)initialize方法中用dispatch也能保证即使有子类也只会初始化一次
 
 2：交换方法：1：获取某个类的方法：class_getClassMethod：第一个参数：获取哪个类的方法 第二个参数：SEL:获取哪个方法
 
 Method imageNamedMethod = class_getClassMethod(self, @selector(imageNamed:));
 
 // 交互方法:runtime
 method_exchangeImplementations(imageNamedMethod, xmg_imageNamedMethod);
 
 也就是外部调用xmg_imageNamed就相当于调用了imageNamed，调用imageNamed就相当于调用了xmg_imageNamed
 
 3：在分类中,最好不要重写系统方法,一旦重写,把系统方法实现给干掉，因为分类不是继承父类，而是继承NSObject，super没有改类的方法，所以就直接覆盖掉了父类的行为
 
 */
// 把类加载进内存的时候调用,只会调用一次
+ (void)load{
    // self -> UIImage
    // 获取imageNamed
    // 获取哪个类的方法
    // SEL:获取哪个方法
    Method imageNameMethod = class_getClassMethod(self, @selector(imageNamed:));
    // 获取xmg_imageNamed
    Method dx_imageNamedMethod = class_getClassMethod(self, @selector(dx_imageNamed:));
     // 交互方法:runtime
    method_exchangeImplementations(imageNameMethod, dx_imageNamedMethod);
    // 调用imageNamed => xmg_imageNamedMethod
    // 调用xmg_imageNamedMethod => imageNamed
}
// 会调用多次
//+ (void)initialize
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//
//    });
//
//}
// 在分类中,最好不要重写系统方法,一旦重写,把系统方法实现给干掉

//+ (UIImage *)imageNamed:(NSString *)name
//{
//    // super -> 父类NSObject
//
//}
+ (UIImage *)dx_imageNamed:(NSString *)name{
    UIImage *image = [UIImage dx_imageNamed:name];
    if (image) {
        NSLog(@"runtime加载成功");
    }else{
        NSLog(@"runtime加载失败");
    }
    return image;
}
@end
