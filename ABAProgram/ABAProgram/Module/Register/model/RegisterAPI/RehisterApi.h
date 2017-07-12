//
//  RehisterApi.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/25.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "BaseApi.h"

@interface RehisterApi : BaseApi

/**
 注册接口

 @param useraccount 账号
 @param password 密码
 @param userType 1-普通用户，2：机构，3：专家
 @param loginType 1-QQ；2-微信；3-手机;4-微博
 @return self
 */
- (id)initWithUseraccount:(NSString *)useraccount password:(NSString *)password userType:(NSString *)userType loginType:(NSString *)loginType;

@end
