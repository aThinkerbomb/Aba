//
//  ForgotPasswordApi.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/24.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "ForgotPasswordApi.h"

@implementation ForgotPasswordApi
{
    NSString * _phone;
}


- (id)initWithForgotPasswordPhone:(NSString *)phone
{
    self = [super init];
    if (self) {
        _phone = phone;
    }
    return self;
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl
{
    return [ABA_GET_VERCODE_FORGET_PASSWORD_URL stringByAppendingPathComponent:_phone];
}

- (id)requestArgument
{
    return @{@"phone": _phone,
             @"serviceType":@"resetLoginPwd"
             };
}



@end
