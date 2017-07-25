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


+ (NSDate *)getCurrentDateWithDateString:(NSString *)dateString {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDate *date = [formatter dateFromString:dateString];
    return date;
}

+ (NSString *)getTimeWithdate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *time = [dateFormatter stringFromDate:date];
    return time;
}

+ (NSTimeInterval)getSecondswithDate:(NSDate *)date {
    NSTimeInterval dateDiff = [date timeIntervalSinceNow];
    return dateDiff;
}

+ (NSTimeInterval)getSecondsFromDate:(NSDate *)fromDate toDate:(NSDate *)date {
    NSTimeInterval dateDiff = [fromDate timeIntervalSinceDate:date];
    return dateDiff;
}

+ (NSString *)getYearWitDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy"];
    NSString *year = [dateFormatter stringFromDate:date];
    return year;
}

+ (NSString *)getMonthWithDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM"];
    NSString *month = [dateFormatter stringFromDate:date];
    return month;
}

+ (NSString *)getDayWithDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd"];
    NSString *day = [dateFormatter stringFromDate:date];
    return day;
}

+ (NSString *)getCurrentDateWithFormatter:(NSString *)formatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    NSDate * date = [[NSDate alloc] init];
    NSString * time = [dateFormatter stringFromDate:date];
    return time;
}
@end
