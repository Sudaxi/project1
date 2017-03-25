//
//  Person+PersonExtention.m
//  EffectiveRangeBtn
//
//  Created by SYQ on 2017/3/13.
//  Copyright © 2017年 SYQ. All rights reserved.
//

#import "Person+PersonExtention.h"
#import <objc/runtime.h>
//在分类中@property不会生成_变量，也不会实现getter和setter方法,我们可以手动实现如下
//但是这样是没什么意义的，而且分类中不允许定义变量，所以只能用runtime类实现
//Category在ios开发中使用非常频繁。尤其是在为系统类进行扩展的时候，我们可以不用继承系统类，直接给系统类添加方法，最大程度体现了Objective-C的动态语言特性。
@implementation Person (PersonExtention)
//定义常量，必须是C语言字符串
static char *PersonNameKey = "PersonNameKey";
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
    objc_setAssociatedObject(self, PersonNameKey, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)name{
    return objc_getAssociatedObject(self, PersonNameKey);
    
}
-(void)saySex{
    NSLog(@"方法%s-------属性%@",__func__,self);
}
@end
