//
//  UIColor+image.m
//  SuDaxiStudyPointDemo
//
//  Created by SYQ on 2017/3/28.
//  Copyright © 2017年 SYQ. All rights reserved.
//

#import "UIColor+image.h"

@implementation UIColor (image)
//UIColor 转UIImage
+ (UIImage *)createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0,0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end
