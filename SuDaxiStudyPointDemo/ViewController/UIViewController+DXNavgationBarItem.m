//
//  UIViewController+DXNavgationBarItem.m
//  SuDaxiStudyPointDemo
//
//  Created by SuDaxi on 2017/3/25.
//  Copyright © 2017年 SYQ. All rights reserved.
//

#import "UIViewController+DXNavgationBarItem.h"
//isHiddenNavBarLine是一个指向常字符串的常指针（也就是说，指针指向的整型数是不可修改的，同时指针也是不可修改的）。
#if TARGET_IPHONE_SIMULATOR
#import <objc/objc-runtime.h>
#else
#import <objc/runtime.h>
#import <objc/message.h>
#endif

static char const * const IsHiddenNavBarLine = "isHiddenNavBarLine";


@implementation UIViewController (DXNavgationBarItem)
-(UIButton *)buttonWithNavgationGotoBack{
    UIButton *button = [UIButton new];
    [button setImage:[UIImage imageNamed:@"newperson_back"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, button.currentImage.size.width, button.currentImage.size.height);
    [button addTarget:self action:@selector(dx_static_navNagtionBarGoto:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}
- (void)dx_static_navNagtionBarGoto:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(UIButton *)buttonWithNavgationGotoBackWithTarget:(id)target sel:(SEL)sel{
    UIButton *button = [UIButton new];
    [button setImage:[UIImage imageNamed:@"newperson_back"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, button.currentImage.size.width, button.currentImage.size.height);
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    return button;
}
- (void)dx_setLeftBarButtonItem{
    UIButton *btn = [self buttonWithNavgationGotoBack];
    UIBarButtonItem *left_fixedItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    left_fixedItem.width = 12;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [self.navigationItem setLeftBarButtonItems:@[item,left_fixedItem]];
    
}

- (void)dx_setLeftBarButtonItemWithTarget:(id)target sel:(SEL)sel{
    UIBarButtonItem *left_fixedItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    left_fixedItem.width = 12;
    
    UIButton *btn = [self buttonWithNavgationGotoBackWithTarget:target sel:sel];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [self.navigationItem setLeftBarButtonItems:@[item,left_fixedItem]];
}
#pragma mark 通用的 navgation Bar
- (UINavigationBar *)dx_customNavgationBar{
    UINavigationBar *navigationBar = [UINavigationBar new];
    NSMutableDictionary *norNavTitle = [NSMutableDictionary dictionary];
    norNavTitle[NSForegroundColorAttributeName] = [UIColor blackColor];
    norNavTitle[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    [navigationBar setTitleTextAttributes:norNavTitle];
    [navigationBar setTintColor:[UIColor whiteColor]];
    [navigationBar setBarTintColor:[UIColor whiteColor]];
    return navigationBar;
}
- (void)dx_setTitle:(NSString *)title{
    self.navigationItem.title = title; //if need return a title lable
}

+(void)load{
    Method oldMethod = class_getInstanceMethod([self class], @selector(viewWillAppear:));
    Method newMethod = class_getInstanceMethod([self class], @selector(dxViewWillAppear:));
    method_exchangeImplementations(oldMethod, newMethod);

}

-(void)dxViewWillAppear:(BOOL)animated{
    UINavigationBar *navbar = self.navigationController.navigationBar;
    if (self.isHiddenNavBarLine) {
        [navbar setShadowImage:[UIImage new]];
    }else{
        [navbar setShadowImage:nil];
    }
    [self dxViewWillAppear:animated];
}

-(BOOL)isHiddenNavBarLine{
    NSNumber *number = objc_getAssociatedObject(self, IsHiddenNavBarLine);
    return [number boolValue];
}

-(void)setIsHiddenNavBarLine:(BOOL)isHiddenNavBarLine
{
    NSNumber *number = [NSNumber numberWithBool:isHiddenNavBarLine];
    /*
     bjc_setAssociatedObject 用于给对象添加关联对象，传入 nil 则可以移除已有的关联对象；
     objc_getAssociatedObject 用于获取关联对象；
     objc_removeAssociatedObjects 用于移除一个对象的所有关联对象。
     */
    objc_setAssociatedObject(self, IsHiddenNavBarLine, number, OBJC_ASSOCIATION_ASSIGN);
}
@end
