//
//  nextClick.m
//  SuDaxiStudyPointDemo
//
//  Created by SuDaxi on 2017/3/28.
//  Copyright © 2017年 SYQ. All rights reserved.
//

#import "NextClickView.h"

@implementation NextClickView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        self.frame = frame;
        UIButton *btn = [[UIButton alloc] initWithFrame:self.bounds];
        btn.backgroundColor = [UIColor orangeColor];
        btn.layer.cornerRadius = 5.0;
        btn.layer.masksToBounds = YES;
        [btn setTitle:@"点我" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    return self;
}
-(void)click{
    if (self.clickBlock) {
        self.clickBlock();
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
