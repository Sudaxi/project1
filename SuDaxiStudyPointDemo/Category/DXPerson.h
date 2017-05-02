//
//  DXPerson.h
//  SuDaxiStudyPointDemo
//
//  Created by SYQ on 2017/4/18.
//  Copyright © 2017年 SYQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXPerson : NSObject
{
    @public
    NSString *publicStr;
    @private
    NSString *privateStr;
}
@property (nonatomic,strong) NSString *propertyStr;
-(void)eat;
@end
