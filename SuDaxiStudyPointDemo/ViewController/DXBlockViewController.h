//
//  DXBViewController.h
//  SuDaxiStudyPointDemo
//
//  Created by SYQ on 2017/3/13.
//  Copyright © 2017年 SYQ. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^ByValueBlock)(NSString *str);

@interface DXBlockViewController : BaseViewController

@property (nonatomic, copy) ByValueBlock byValueBlock;

@end
