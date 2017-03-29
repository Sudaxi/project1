//
//  DXImage.m
//  SuDaxiStudyPointDemo
//
//  Created by SYQ on 2017/3/29.
//  Copyright © 2017年 SYQ. All rights reserved.
//

#import "DXImage.h"

@implementation DXImage
// 重写方法:想给系统的方法添加额外功能
+ (DXImage *)dx1_imageNamed:(NSString *)name{
    // 真正加载图片：调用super初始化一张图片
    DXImage *image = (DXImage *)[super imageNamed:name];
    if (image) {
        NSLog(@"继承——加载成功");
    } else {
        NSLog(@"继承——加载失败");
    }
    return image;
}

@end
