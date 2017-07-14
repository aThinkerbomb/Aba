
//
//  OtherLoginApi.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/14.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "OtherLoginApi.h"

@implementation OtherLoginApi
{
//    NSString *_userType;
//    NSString *_loginType;
//    NSString *_userAccount;
//    NSString *_username;
//    NSString *_userimg;
//    NSInteger _usergender;
    
    NSDictionary * _dic;
}

//- (id)initWithOtherLoginUsertype:(NSString *)userType loginType:(NSString *)loginType userAccount:(NSString *)userAccount username:(NSString *)username userimg:(NSString *)userimg usergender:(NSInteger)usergender {
//    self = [super init];
//    if (self) {
//        _userType = userType;
//        _loginType = loginType;
//        _userAccount = userAccount;
//        _username = username;
//        _userimg = userimg;
//        _usergender = usergender;
//    }
//    return self;
//}

- (id)initWithInfoDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        _dic = [NSDictionary dictionaryWithDictionary:dic];
    }
    return self;
}


- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return ABA_OTHER_LOGIN_URL;
}

- (id)requestArgument {
    
    return _dic;
//    return @{@"usertype": _userType,
//             @"logintype": _loginType,
//             @"useraccount": _userAccount,
//             @"username": _username,
//             @"userimg": _userimg,
//             @"usergender": @(_usergender)
//             };
}




@end
