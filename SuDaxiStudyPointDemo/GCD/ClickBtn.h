//
//  ClickBtn.h
//  EffectiveRangeBtn
//
//  Created by SYQ on 2017/3/1.
//  Copyright © 2017年 SYQ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,DXUserGender)
{
    DXUserGenderUndefined,
    DXUserGenderMale,
    DXUserGenderFemale
};

@interface ClickBtn : UIButton

@property (nonatomic, assign) DXUserGender sex;

@end
