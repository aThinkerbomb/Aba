//
//  ZhiFuBaoPayApi.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/18.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "ZhiFuBaoPayApi.h"

@implementation ZhiFuBaoPayApi
{
    NSString *_merchid;
    NSString *_cashnum;
}
- (id)initWithMercid:(NSString *)mercid cashnum:(NSString *)cashnum {
    self = [super init];
    if (self) {
        _merchid = mercid;
        _cashnum = cashnum;
    }
    return self;
}

- (NSString *)requestUrl {
    return ABA_ZFB_PAY_URL;
}
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{@"mercid": _merchid,
             @"cashnum": _cashnum};
}

@end
