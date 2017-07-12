//
//  NSDate+Calender.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/27.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Calender)
+ (NSString *)getDateFromDateString:(NSString *)dateString withDateFormatter:(NSString *)dataFormatter;
+ (NSString *)getDateFromDateString:(NSString *)dateString;

+ (NSString *)currentPreciseTime;
@end
