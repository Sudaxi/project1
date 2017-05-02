//
//  DXCountViewController.m
//  SuDaxiStudyPointDemo
//
//  Created by SYQ on 2017/4/17.
//  Copyright © 2017年 SYQ. All rights reserved.
//

#import "DXCountViewController.h"
#import "DXPerson.h"
#import <objc/runtime.h>
@interface DXCountViewController ()

@end

@implementation DXCountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dx_setLeftBarButtonItem];
    self.title = @"leetcode";
    
    NSString *rever = [self reverseWordsWithStr:@"Let's take LeetCode contest"];
    NSLog(@"-%@-",rever);
//    NSArray *nums = @[@2,@6,@7,@11,@15,@20,@35,@49];
//    [self twoSumWithNums:nums numSize:nums.count target:26];
}

-(NSMutableString *)reverseWordsWithStr:(NSString *)str{
    NSMutableString *newStr = [[NSMutableString alloc] initWithCapacity:str.length];
    for (int i = str.length -1; i >= 0; i--) {
        unichar ch = [str characterAtIndex:i];
        [newStr appendFormat:@"%c",ch];
    }
    return newStr;
}
//nums = [2, 7, 11, 15], target = 9,因为nums[0] + nums[1] = 2 + 7 = 9,返回[0,1]
-(void)twoSumWithNums:(NSArray *)nums numSize:(NSUInteger)numSize target:(int)target{
    NSLog(@"--开始时间--");
    NSMutableArray *arr = [@[] mutableCopy];
    int *a = (int*)malloc(2*sizeof(int));
    for (int i = 0; i < numSize; i++) {
        for (int j = i + 1; (j < numSize && j != i); j++) {
            if ([nums[i] intValue] + [nums[j] intValue] == target) {
                a[0] = i;
                a[1] = j;
                [arr addObject:[NSNumber numberWithInt:i]];
                [arr addObject:[NSNumber numberWithInt:j]];
            }
        }
    }
    NSLog(@"--结束时间--");
    NSLog(@"----输出--%@",arr);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 
 
 DXPerson *p = [DXPerson new];
 [p eat];
 //    DXSport分类中可以访问原来类DXPerson中的成员变量(publicStr/)，但是只能访问@protect和@public形式的变量。
 p.propertyStr = @"propertyStr";
 //    如果想要访问本类中的私有变量，分类和子类一样，只能通过方法来访问。
 //如何访问类的私有成员变量,有两种方法:KVC和RunTime机制,
 //    p1->privateStr = @"privateStr";
 //1/通过RunTime来设置:
 Ivar ivar = class_getInstanceVariable([p class], [@"privateStr" UTF8String]);
 const char *ivarType = ivar_getTypeEncoding(ivar);
 NSLog(@"*** ivar type:%@",[[NSString alloc] initWithCString:ivarType encoding:NSUTF8StringEncoding]);
 
 object_setIvar(p, ivar, @"changePrivateStr");
 NSString *ivarValue = object_getIvar(p, ivar);
 NSLog(@"*** ivar value:%@", ivarValue);
 
 //通过KVC来设置:
 [p setValue:@"kvc-privateStr" forKey:@"privateStr"];
 NSLog(@"*** ivar value:%@", [p valueForKey:@"privateStr"]);
 
 
 */
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
