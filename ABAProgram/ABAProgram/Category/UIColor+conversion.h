//
//  UIColor+conversion.h
//  KZW_iPhone2
//
//  Created by yuxuan on 15/7/24.
//  Copyright (c) 2015年 kezhanwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (conversion)

/// 二进制颜色转换
+(UIColor *)colorWithHexString:(NSString *)hexStr;

/// 主题颜色 （粉色）
+(UIColor *)themeColor;

/// 主题黑色字体颜色
+(UIColor *)themeBlackColor;

/// 灰色字体颜色
+(UIColor *)themeDarkGrayColor;
@end
