//
//  UIViewController+DXNavgationBarItem.h
//  SuDaxiStudyPointDemo
//
//  Created by SuDaxi on 2017/3/25.
//  Copyright © 2017年 SYQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (DXNavgationBarItem)
- (UIButton *)buttonWithNavgationGotoBack;
- (UIButton *)buttonWithNavgationGotoBackWithTarget:(id)target sel:(SEL)sel;


- (void)dx_setLeftBarButtonItem;

- (void)dx_setLeftBarButtonItemWithTarget:(id)target sel:(SEL)sel;

- (void)dx_setTitle:(NSString *)title;

// 设置导航栏下面的线是否隐藏
@property (nonatomic, assign) BOOL isHiddenNavBarLine;

@end
