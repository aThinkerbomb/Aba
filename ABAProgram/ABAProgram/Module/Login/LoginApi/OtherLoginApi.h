//
//  OtherLoginApi.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/14.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "BaseApi.h"

@interface OtherLoginApi : BaseApi


/**
 三方登录

 @param userType 1-普通用户，2：机构，3：专家
 @param loginType 1-QQ；2-微信；3-手机;4-微博
 @param userAccount 账号
 @param username 名字
 @param userimg 图片头像
 @param usergender 性别：0-男；1-女
 @return 回调self
 */
//- (id)initWithOtherLoginUsertype:(NSString *)userType loginType:(NSString *)loginType userAccount:(NSString *)userAccount username:(NSString *)username userimg:(NSString *)userimg usergender:(NSInteger)usergender;



/**
 三方登录

 @param dic 登录信息
 @return 回调self
 */
- (id)initWithInfoDictionary:(NSDictionary *)dic;


@end
