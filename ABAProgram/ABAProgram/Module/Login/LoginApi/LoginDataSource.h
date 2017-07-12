//
//  LoginDataSource.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/24.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "BaseApi.h"

@interface LoginDataSource : BaseApi

/**
 用户手机号登录

 @param phone 手机号
 @param password 密码
 @param userType 用户类型
 @param loginType 登录类型
 @return self
 */
- (id)initWithLoginPhone:(NSString *)phone Password:(NSString *)password userType:(NSString *)userType loginType:(NSString *)loginType;


@end
