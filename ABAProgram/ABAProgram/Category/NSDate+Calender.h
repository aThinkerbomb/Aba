//
//  NSDate+Calender.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/27.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Calender)

// 自定义格式 根据时间戳 转时间
+ (NSString *)getDateFromDateString:(NSString *)dateString withDateFormatter:(NSString *)dataFormatter;

// 根据时间戳 转时间
+ (NSString *)getDateFromDateString:(NSString *)dateString;

// 当前 时间
+ (NSString *)currentPreciseTime;

/// 得到当前时间戳 精确到秒
+ (NSString *)getCurrentTimestamp;
// 时间字符串 转 date
+ (NSDate *)getCurrentDateWithDateString:(NSString *)dateString;
// date 转 字符串
+ (NSString *)getTimeWithdate:(NSDate *)date;

// 根据date  转秒
+ (NSTimeInterval)getSecondswithDate:(NSDate *)date;
@end
