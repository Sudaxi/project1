//
//  UIButton+DXNextButton.m
//  SuDaxiStudyPointDemo
//
//  Created by SYQ on 2017/3/30.
//  Copyright © 2017年 SYQ. All rights reserved.
//

#import "UIButton+DXNextButton.h"

@implementation UIButton (DXNextButton)
-(void)DX_setUpCustomBtn{
    [self setTitle:@"跳下一步" forState:UIControlStateNormal];
    self.backgroundColor = [UIColor orangeColor];
    self.layer.cornerRadius = 5.0;
    self.layer.masksToBounds = YES;
}
@end
