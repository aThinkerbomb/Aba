//
//  GetRegisterVerCode.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/24.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "GetRegisterVerCode.h"

@implementation GetRegisterVerCode
{
    NSString * _phone;
    
}
- (id)initWithRegisterPhone:(NSString *)phone
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
    return [ABA_GET_VERIFICATION_CODE_URL stringByAppendingPathComponent:_phone];
}

- (id)requestArgument
{
    return @{
             @"phoneNum": _phone,
             @"serviceType":@"register"
             };
}


@end
