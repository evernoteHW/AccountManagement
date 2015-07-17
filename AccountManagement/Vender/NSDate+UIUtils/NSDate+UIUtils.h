//
//  NSDate+UIUtils.h
//  AccountManagement
//
//  Created by WeiHu on 15/7/6.
//  Copyright (c) 2015年 WeiHu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (UIUtils)

+ (NSString *)getTimeStr1:(NSTimeInterval)time;
+ (NSString *) getTimeStrStyle1:(NSTimeInterval)time;

+ (NSString *)getTimeStr1Short:(NSTimeInterval)time;
+ (NSString *)getTimeStr2Short:(NSTimeInterval)time;
+ (NSString *)getTimeStr3Short:(NSTimeInterval)time;

+ (NSString *) getTimeStrStyle2:(NSTimeInterval)time;
+ (NSInteger) getCureentMonth;

+ (NSInteger)dayCountForMonth:(NSInteger)month andYear:(NSInteger)year;
+ (BOOL)isLeapYear:(NSInteger)year;

@end
