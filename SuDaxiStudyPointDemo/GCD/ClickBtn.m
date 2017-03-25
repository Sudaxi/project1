//
//  ClickBtn.m
//  EffectiveRangeBtn
//
//  Created by SYQ on 2017/3/1.
//  Copyright © 2017年 SYQ. All rights reserved.
//

#import "ClickBtn.h"

@implementation ClickBtn

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    [self commonInit];
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (!self) return nil;
    [self commonInit];
    return self;
}

-(void)commonInit{
    self.backgroundColor = [UIColor greenColor];
    self.layer.borderWidth = 0.5;
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [UIColor grayColor].CGColor;
}

//-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
//{
//    BOOL res = [super pointInside:point withEvent:event];
//    if (res) {
//        //绘制一个path
//        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.frame.size.width*0.5, self.frame.size.height)];
//        if ([path containsPoint:point]) {
//            //如果在path区域内，返回YES
//            return YES;
//        }
//        return NO;
//    }
//    return NO;
//}
@end
