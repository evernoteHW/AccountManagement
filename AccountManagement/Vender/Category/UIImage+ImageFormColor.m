//
//  UIImage+ImageFormColor.m
//  AccountManagement
//
//  Created by WeiHu on 15/6/9.
//  Copyright (c) 2015年 WeiHu. All rights reserved.
//

#import "UIImage+ImageFormColor.h"

@implementation UIImage (ImageFormColor)

+ (UIImage *)imageFormColor:(UIColor *)color size:(CGSize)size{
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}
@end
