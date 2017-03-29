//
//  NSObject+Property.h
//  SuDaxiStudyPointDemo
//
//  Created by SYQ on 2017/3/29.
//  Copyright © 2017年 SYQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Property)
/**
 * 1:@property分类:只会生成get,set方法声明,不会生成实现,需要自己手动去生成实现方法，也不会生成下划线成员属性，可以用static定义下划线的成员变量在手动实现的get方法中返回，也可以用runtime实现动态添加属性
 2:因为在分类中定义的属性不会生成下划线的成员变量，所以可以省略不写策略方式，只写定义就可以了@property NSString *name;
 */
@property (copy , nonatomic) NSString *name;

@end
