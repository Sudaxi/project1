//
//  DXPerson+DXSport.h
//  SuDaxiStudyPointDemo
//
//  Created by SYQ on 2017/4/18.
//  Copyright © 2017年 SYQ. All rights reserved.
//

#import "DXPerson.h"
//2.1分类中只能添加“方法”，不能增加成员变量。
//2.2分类中可以访问原来类中的成员变量，但是只能访问@protect和@public形式的变量。如果想要访问本类中的私有变量，分类和子类一样，只能通过方法来访问。
//2.3如果一定要在分类中添加成员变量，可以通过getter，setter手段进行添加
@interface DXPerson (DXSport)
-(void)visitSuperclass;
@property (nonatomic, copy) NSString *sportStr;
-(void)eat;
@end
