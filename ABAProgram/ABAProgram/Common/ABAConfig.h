//
//  ABAConfig.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/23.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABAConfig : NSObject

+ (instancetype)shareConfig;

// 登录页面
+ (UINavigationController *)creatLoginViewController;
// 主页面
+ (UITabBarController *)initTabBarViewController;

// 设置根视图
+ (void)creatRootViewController:(UIViewController *)viewController;

// 得到当前版本
+ (NSString *)getCurrentVersion;

// 判断是否是空
+ (BOOL)isEmptyOfObj:(id)obj;

// 判断接口返回数据是否正确
+ (BOOL)checkResponseObject:(id)responseObject;

// 判断是否包含中文字符
+ (BOOL)IsChinese:(NSString *)str;

/**
 生成sign

 @param dictionary 需要字段
 @return 得到sign
 */
+ (NSString *)getSignFieldFromRequestDictionary:(NSDictionary *)dictionary;


/**
 MD5加密 并转为大写

 @param string 需要加密的字符串
 @return 加密结果
 */
+ (NSString *)creatMD5StringWithString:(NSString *)string;


/**
 生成随机数

 @return 返回随机数
 */
+ (NSString *)acrRandow;
@end
