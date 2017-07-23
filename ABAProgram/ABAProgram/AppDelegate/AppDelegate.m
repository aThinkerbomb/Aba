//
//  AppDelegate.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/20.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "AppDelegate.h"
#import "ABATabBarController.h"
#import "LoginViewController.h"
#import "UserInfo.h"
#import "YTKNetwork.h"
#import "VersionManager.h"
#import "SchoolViewController.h"
#import "ABAShareManager.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import "LocationManager.h"

@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 程序刚一启动的时候 设置YTK的BaseUrl
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.baseUrl = @"http://www.abashow.com";
    
    
    // 键盘设置
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES; // 打开键盘自动相应，默认NO
    manager.shouldResignOnTouchOutside = YES; // 点击背景收起键盘，默认NO
    manager.enableAutoToolbar = YES; // IQKeyboardManager提供的键盘上面默认会有“前一个”“后一个”“完成”这样的辅助按钮。如果你不需要，可以将这个enableAutoToolbar属性设置为NO，这样就不会显示了。默认YES
    
    // 版本检测
    [[VersionManager shareInstance] startCheckVersion];
    
    // 注册分享功能
    [ABAShareManager registerShare];
    
    // 开启定位服务
    [LocationManager ShareLocation];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    ABATabBarController *tabBar = [[ABATabBarController alloc] init];
    
    if ([UserInfo hasLogin]) {
        self.window.rootViewController = tabBar;
    } else {
        
        self.window.rootViewController = [ABAConfig creatLoginViewController];
    }
    
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

// 其他应用回掉
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    NSLog(@"回调url=%@", url);
    NSString *urlStr = [NSString stringWithFormat:@"%@", url];
    
    // 微信支付回调
    if ([urlStr containsString:@"wx909f8c29eb7ddae2://pay"]) {
        return [WXApi handleOpenURL:url delegate:self];
    }
    
    // 支付支付回调
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }
    
    // 友盟分享回调
    return [ABAShareManager HandleCallBackOpenurl:url];
    
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    NSString *urlStr = [NSString stringWithFormat:@"%@", url];
    if ([urlStr containsString:@"wx909f8c29eb7ddae2://pay"]) {
        return [WXApi handleOpenURL:url delegate:self];
    }
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }
    return [ABAShareManager HandleCallBackOpenurl:url];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



- (void)onResp:(BaseResp*)resp{
    if ([resp isKindOfClass:[PayResp class]]){
        PayResp *response = (PayResp*)resp;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"WXpayResult" object:nil userInfo:@{@"errorCode": @(response.errCode)}];
    }
}

@end
