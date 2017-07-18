//
//  NSDate+Calender.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/27.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "NSDate+Calender.h"

@implementation NSDate (Calender)

+ (NSString *)getDateFromDateString:(NSString *)dateString withDateFormatter:(NSString *)dataFormatter
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[dateString floatValue]/1000];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dataFormatter];
    NSString *DateStr = [dateFormatter stringFromDate:date];
    return DateStr;
}

+ (NSString *)getDateFromDateString:(NSString *)dateString
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[dateString floatValue]/1000];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *DateStr = [dateFormatter stringFromDate:date];
    return DateStr;
}

+ (NSString *)currentPreciseTime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [NSDate date];
    NSString *currentTime = [dateFormatter stringFromDate:date];
    return currentTime;
}


+ (NSString *)getCurrentTimestamp
{
    NSDate *date = [NSDate date];
    NSTimeInterval timeInterval = [date timeIntervalSince1970];
    return [NSString stringWithFormat:@"%d", (int)timeInterval];
}
@end
