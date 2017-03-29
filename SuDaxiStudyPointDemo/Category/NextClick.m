//
//  nextClick.m
//  SuDaxiStudyPointDemo
//
//  Created by SuDaxi on 2017/3/28.
//  Copyright © 2017年 SYQ. All rights reserved.
//

#import "NextClick.h"

@implementation NextClick

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *btn = [UIButton new];
        btn.frame  = CGRectMake(100, 100, 100, 100);
        btn.backgroundColor = [UIColor orangeColor];
        btn.layer.cornerRadius = 5.0;
        btn.layer.masksToBounds = YES;
        [btn setTitle:@"点我" forState:UIControlStateNormal];
        [self addSubview:btn];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
