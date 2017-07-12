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
@end
