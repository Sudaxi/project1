//
//  DXDelegateViewController.h
//  SuDaxiStudyPointDemo
//
//  Created by SYQ on 2017/3/13.
//  Copyright © 2017年 SYQ. All rights reserved.
//

#import "BaseViewController.h"

@protocol PassByValueDelegate <NSObject>
@required
-(void)error;
//代理传值方法
@optional
-(void)sendValue:(NSString *)value;
@end

@interface DXDelegateViewController : BaseViewController
//委托代理人，代理一般使用弱引用（weak）
@property (weak, nonatomic) id<PassByValueDelegate> delegate;
@end
