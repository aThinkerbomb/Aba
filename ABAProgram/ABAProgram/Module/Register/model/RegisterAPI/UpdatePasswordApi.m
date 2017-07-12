//
//  UpdatePasswordApi.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/25.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "UpdatePasswordApi.h"

@implementation UpdatePasswordApi
{
    NSString *_useraccount;
    NSString *_password;
}
- (id)initWithUseraccount:(NSString *)useraccount passwprd:(NSString *)password
{
    self = [super init];
    if (self) {
    
        _useraccount = useraccount;
        _password = password;
        
    }
    
    return self;
}

- (NSString *)requestUrl
{
    return ABA_MODIFY_PASSWORD_URL;
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}

- (id)requestArgument
{
    return @{
             @"useraccount": _useraccount,
             @"userpassword": _password
             };
}

@end
