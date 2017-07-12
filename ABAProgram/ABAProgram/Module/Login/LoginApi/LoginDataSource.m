//
//  LoginDataSource.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/24.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "LoginDataSource.h"

@implementation LoginDataSource
{
    
    NSString *_phone;
    NSString *_Passwd;
    NSString *_userType;
    NSString *_loginType;
}

- (id)initWithLoginPhone:(NSString *)phone Password:(NSString *)password userType:(NSString *)userType loginType:(NSString *)loginType
{
    self = [super init];
    if (self) {
        _phone = phone;
        _Passwd = password;
        _userType = userType;
        _loginType = loginType;
    }
    return self;
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl
{
    return ABA_IPHONE_LOGIN_URL;
}

- (id)requestArgument
{
    return @{
             @"useraccount": _phone,
             @"userpassword":_Passwd,
             @"usertype":_userType,
             @"logintype":_loginType,
//             @"platform":@"0",
//             @"deviceNum":@"",
//             @"requestId":@"5ae90065366244a6a77c9e1c940d4cbd",
//             @"userId":@"",
//             @"token":@"",
//             @"deviceInfo":@""
             };
}

@end
