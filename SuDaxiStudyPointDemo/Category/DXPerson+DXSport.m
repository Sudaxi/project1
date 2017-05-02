//
//  DXPerson+DXSport.m
//  SuDaxiStudyPointDemo
//
//  Created by SYQ on 2017/4/18.
//  Copyright © 2017年 SYQ. All rights reserved.
//

#import "DXPerson+DXSport.h"
#import <objc/runtime.h>

//在分类中@property不会生成_变量，也不会实现getter和setter方法,我们可以手动实现如下
//但是这样是没什么意义的，而且分类中不允许定义变量，所以只能用runtime类实现
//Category在ios开发中使用非常频繁。尤其是在为系统类进行扩展的时候，我们可以不用继承系统类，直接给系统类添加方法，最大程度体现了Objective-C的动态语言特性。

@implementation DXPerson (DXSport)

static char *SportKey = "SportKey";
-(void)setSportStr:(NSString *)sportStr
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
    
    objc_setAssociatedObject(self, SportKey, sportStr, OBJC_ASSOCIATION_COPY);
}
-(NSString *)sportStr{
    return objc_getAssociatedObject(self, SportKey);
}


-(void)eat{
    NSLog(@"子类方法eat");
}
-(void)visitSuperclass{
//    2.2分类中可以访问原来类中的成员变量，但是只能访问@protect和@public形式的变量。如果想要访问本类中的私有变量，分类和子类一样，只能通过方法来访问。
    self.propertyStr = @"哈哈哈哈";
    self->publicStr = @"呵呵呵呵";
    NSLog(@"***propertyStr*** %@",self.propertyStr);
    NSLog(@"***publicStr*** %@",self->publicStr);   
}
@end
