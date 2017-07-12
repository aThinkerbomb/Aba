//
//  RehisterApi.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/25.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "RehisterApi.h"

@implementation RehisterApi
{
    NSString *_account;
    NSString *_password;
    NSString *_userType;
    NSString *_LoginType;
}
- (id)initWithUseraccount:(NSString *)useraccount password:(NSString *)password userType:(NSString *)userType loginType:(NSString *)loginType
{
    self = [super init];
    if (self) {
        
        _account = useraccount;
        _password = password;
        _userType = userType;
        _LoginType = loginType;
    }
    return self;
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl
{
    return ABA_UPDATE_USER_PASSWORD_URL;
}

- (id)requestArgument
{
    return @{@"useraccount": _account,
             @"userpassword": _password,
             @"usertype": _userType,
             @"logintype": _LoginType
             };
}



@end
