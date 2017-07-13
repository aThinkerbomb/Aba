//
//  ABAShareManager.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/13.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum sharePlatform {
    SharePlatformSina = 0,        //新浪微博
    SharePlatformWXSession = 1,   //微信好友
    SharePlatformWXTimeline  =2,  //朋友圈
    SharePlatformQQ = 3,          //QQ好友
    SharePlatformQQZone = 4,      //QQ空间
}SharePlatform;


@interface ABAShareManager : NSObject

// 注册分享
+ (void)registerShare;

// 处理 应用平台回掉
+ (BOOL)HandleCallBackOpenurl:(NSURL *)url;

/**
 分享的平台
 
 @param platform            平台
 @param title               标题
 @param content             内容
 @param image               图片 （UIImage或者NSDdta）
 @param url                 url
 @param presentedController 从哪个界面跳转（仅新浪微博需要传）
 @param complete            请求回调
 */
+ (void)shareToPlatform:(SharePlatform)platform
                  title:(NSString *)title
                content:(NSString *)content
                  image:(id)image url:(NSString *)url
    presentedController:(UIViewController *)presentedController
               complete:(void(^)(BOOL isSuccess,NSString * errorMsg))complete;

@end
