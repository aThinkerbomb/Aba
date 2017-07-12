//
//  UIColor+conversion.m
//  KZW_iPhone2
//
//  Created by yuxuan on 15/7/24.
//  Copyright (c) 2015年 kezhanwang. All rights reserved.
//

#import "UIColor+conversion.h"

@implementation UIColor (conversion)
+(UIColor *)colorWithHexString:(NSString *)hexStr{
    
    NSMutableString *color = [[NSMutableString alloc]initWithString:hexStr];
    if([color rangeOfString:@"#"].location !=NSNotFound)
    {
        // 转换成标准16进制数
        [color replaceCharactersInRange:[color rangeOfString:@"#" ] withString:@"0x"];
    }
    
    // 十六进制字符串转成整形。
    long colorLong = strtoul([color cStringUsingEncoding:NSUTF8StringEncoding], 0, 16);
    // 通过位与方法获取三色值
    int R = (colorLong & 0xFF0000 )>>16;
    int G = (colorLong & 0x00FF00 )>>8;
    int B = colorLong & 0x0000FF;
    
    //string转color
    UIColor *wordColor = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0];
    color=nil;
    return wordColor;

}

+ (UIColor *)themeColor
{
    return [self colorWithHexString:@"fdaa9d"];
}

+ (UIColor *)themeBlackColor
{
    return [self colorWithHexString:@"353535"];
}

+ (UIColor *)themeDarkGrayColor
{
    return [self colorWithHexString:@"969999"];
}







@end
