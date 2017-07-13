//
//  ABAShareManager.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/13.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "ABAShareManager.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaHandler.h"
#import <UShareUI/UShareUI.h>

#define UMengShareKey @"596706f6c62dca478c0007ee"

#define redirect @"www.yccit.com"


#define QQAPPID @"1106287210"
#define QQAPPKEY  @"c0xNR14XeY4mFwCu"

#define WeiXinAppKey @"wx909f8c29eb7ddae2"
#define WeiXinAppSecret @""


#define SinaAppKey @"1829343188"
#define SinaSecret @"df3be1e33e9b16bde6db57467cce9c48"




@implementation ABAShareManager

+(void)registerShare {
    
    [[UMSocialManager defaultManager] openLog:YES];
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMengShareKey];
    

    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:SinaAppKey appSecret:SinaSecret redirectURL:redirect];
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQAPPID appSecret:QQAPPKEY redirectURL:redirect];
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Qzone appKey:QQAPPID appSecret:QQAPPKEY redirectURL:redirect];
    
    
}

+ (BOOL)HandleCallBackOpenurl:(NSURL *)url {
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}


+ (void)shareToPlatform:(UMSocialPlatformType)platform title:(NSString *)title content:(NSString *)content image:(id)image url:(NSString *)url presentedController:(UIViewController *)presentedController complete:(void (^)(BOOL, NSString *))complete {
    
    UMSocialPlatformType sharePlatform = platform;
   
    // 对图片进行异常处理
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    if ( !image || ([image isKindOfClass:[NSString class]] && ((NSString *)image).length == 0)) {
        image = [UIImage imageNamed:@"ic_launcher"];//本地图片
    }
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:content thumImage:image];
    //设置网页地址
    shareObject.webpageUrl = url;
    messageObject.shareObject = shareObject;
  
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:sharePlatform messageObject:messageObject currentViewController:presentedController completion:^(UMSocialShareResponse * data, NSError *error) {
        if (error) {
            complete(NO,[self errorMessageWithCode:error.code]);
        }else{
            complete(YES,data.message);
        }
    }];
    
    
}
+ (NSString *)errorMessageWithCode:(UMSocialPlatformErrorType)responseCode {
    switch (responseCode) {
        case UMSocialPlatformErrorType_Unknow:
            return @"未知错误";
            break;
        case UMSocialPlatformErrorType_NotSupport:
            return @"不支持";
            break;
        case UMSocialPlatformErrorType_AuthorizeFailed:
            return @"授权失败";
            break;
        case UMSocialPlatformErrorType_ShareFailed:
            return @"分享失败";
            break;
        case  UMSocialPlatformErrorType_ShareDataNil:
            return @"分享内容为空";
            break;
        case  UMSocialPlatformErrorType_ShareDataTypeIllegal:
            return @"分享内容不支持";
            break;
        case  UMSocialPlatformErrorType_CheckUrlSchemaFail:
            return @"schemaurl fail";
            break;
        case  UMSocialPlatformErrorType_NotInstall:
            return @"应用未安装";
            break;
        case UMSocialPlatformErrorType_Cancel:
            return @"已取消";
            break;
        case UMSocialPlatformErrorType_NotNetWork:
            return @"网络异常";
            break;
        case UMSocialPlatformErrorType_SourceError:
            return @"第三方错误";
            break;
        case UMSocialPlatformErrorType_ProtocolNotOverride:
            return @"对应的	UMSocialPlatformProvider的方法没有实现";
            break;
        default:
            return @"请求发生未知错误";
            break;
    }
}






@end
