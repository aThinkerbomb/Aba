//
//  ABAConfig.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/23.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "ABAConfig.h"
#import "BaseNavigationController.h"
#import "LoginViewController.h"
#import "ABATabBarController.h"
@implementation ABAConfig

+(instancetype)shareConfig
{
    static ABAConfig *config = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        config = [[ABAConfig alloc] init];
    });
    return config;
    
}


+ (UINavigationController *)creatLoginViewController
{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    BaseNavigationController *baseNV = [[BaseNavigationController alloc] initWithRootViewController:loginVC];
    return baseNV;
}

+ (UITabBarController *)initTabBarViewController{
    return [[ABATabBarController alloc] init];
}

+ (void)creatRootViewController:(UIViewController *)viewController
{
    [kAppDelegate.window setRootViewController:viewController];
    [kAppDelegate.window reloadInputViews];
}

+ (NSString *)getCurrentVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

+ (BOOL)isEmptyOfObj:(id)obj
{
    if (obj == nil || [obj isEqual:[NSNull null]]) {
        return YES;
    }
    if ([obj isKindOfClass:[NSString class]]) {
        if ([obj isEqualToString:@""] || [obj isEqualToString:@"null"] || [obj isEqualToString:@"(null)"]||[obj isEqualToString:@" "]) {
            return YES;
        }
    }
    if ([obj isKindOfClass:[NSArray class]]) {
        if ([obj count] == 0) {
            return YES;
        }
    }
    if ([obj isKindOfClass:[NSDictionary class]]) {
        if ([obj count] == 0) {
            return YES;
        }
    }
    return NO;
}

+ (BOOL)checkResponseObject:(id)responseObject
{
    NSInteger status = [[responseObject objectForKey:@"status"] integerValue];
    NSString *msg = [responseObject objectForKey:@"msg"];
    id body = [responseObject objectForKey:@"body"];
    if (status == 200 && [msg isEqualToString:@"SUCCESS"] && ![ABAConfig isEmptyOfObj:body]) {
        return YES;
    }
    return NO;
    
}

+ (BOOL)IsChinese:(NSString *)str {
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        {
            return YES;
        }
        
    }
    return NO;
    
}

@end
