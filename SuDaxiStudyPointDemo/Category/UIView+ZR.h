//
//  UIView+ZR.h
//  ZiroomerProject
//
//  Created by SYQ on 15/8/25.
//  Copyright (c) 2015年 Chris. All rights reserved.
//可以直接使用某个控件的xy以及宽高等属性，列如直接self.x，就是该控件的x值。

#import <UIKit/UIKit.h>

@interface UIView (ZR)
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;

@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGPoint origin;

- (void)addDashLineWithWidth:(CGFloat)width andColor:(UIColor *)color startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;
@end
