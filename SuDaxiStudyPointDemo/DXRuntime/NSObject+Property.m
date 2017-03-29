//
//  NSObject+Property.m
//  SuDaxiStudyPointDemo
//
//  Created by SYQ on 2017/3/29.
//  Copyright © 2017年 SYQ. All rights reserved.
//

#import "NSObject+Property.h"
#import <objc/runtime.h>

//在分类中@property不会生成_变量，也不会实现getter和setter方法,我们可以手动实现如下
//但是这样是没什么意义的，而且分类中不允许定义变量，所以只能用runtime类实现
//Category在ios开发中使用非常频繁。尤其是在为系统类进行扩展的时候，我们可以不用继承系统类，直接给系统类添加方法，最大程度体现了Objective-C的动态语言特性。
//定义常量，必须是C语言字符串
static char *NameKey = "NameKey";

@implementation NSObject (Property)
/**
 *    1:runtime动态添加属性： 1：为系统的类写分类，并属性定义变量，可以不写策略，并手动实现set和get方法
 2：在set方法中可以利用runtime实现动态添加属性
 objc_setAssociatedObject(self, @"name", name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
 object:给哪个对象添加属性
 key:属性名称
 value:属性值
 policy:保存策略
 
 2：在set方法中可以将该值取出来：objc_getAssociatedObject(self, @"name");
 
 */
-(void)setName:(NSString *)name
{
    /*
     OBJC_ASSOCIATION_ASSIGN;            //assign策略
     OBJC_ASSOCIATION_COPY_NONATOMIC;    //copy策略
     OBJC_ASSOCIATION_RETAIN_NONATOMIC;  // retain策略
     
     OBJC_ASSOCIATION_RETAIN;
     OBJC_ASSOCIATION_COPY;
     */
    
    /*
     * id object 给哪个对象的属性赋值
     const void *key 属性对应的key
     id value  设置属性值为value
     objc_AssociationPolicy policy  使用的策略，是一个枚举值，和copy，retain，assign是一样的，手机开发一般都选择NONATOMIC
     objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy);
     */
    
    objc_setAssociatedObject(self, NameKey, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString *)name{
    
     return objc_getAssociatedObject(self, NameKey);
}
@end
