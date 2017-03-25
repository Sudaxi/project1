//
//  Person.m
//  EffectiveRangeBtn
//
//  Created by SYQ on 2017/3/10.
//  Copyright © 2017年 SYQ. All rights reserved.
//

#import "Person.h"
@implementation Person
-(void)run{
    NSLog(@"%s",__func__);
}

//解档
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self == nil) return nil;
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.age = [aDecoder decodeIntegerForKey:@"age"];
    return self;
}

//归档
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInteger:self.age forKey:@"age"];
}

@end
