//
//  Person.h
//  EffectiveRangeBtn
//
//  Created by SYQ on 2017/3/10.
//  Copyright © 2017年 SYQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject<NSCoding>
//kvc就是键值编码（key－value），说白了就是通过指定的key获得想要的值value。而不是通过调用Setter、Getter方法访问。
//这里的私有变量 height ,假如直接使用Setter、Getter方法访问，就会出现下面的错误。
{
    @private
    NSString *skinColor;
}
//1.遵循NSCoding协议
//设置属性
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger num;


@property (nonatomic, assign) NSInteger age;
-(void)run;


@end
