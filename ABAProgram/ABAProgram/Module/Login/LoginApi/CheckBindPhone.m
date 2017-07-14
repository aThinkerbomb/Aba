//
//  CheckBindPhone.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/14.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "CheckBindPhone.h"

@implementation CheckBindPhone
{
    NSString *_openid;
}
- (id)initWithBindPhoneOpenid:(NSString *)openid {
    self = [super init];
    if (self) {
        _openid = openid;
    }
    return self;
}

- (NSString *)requestUrl {
    return ABA_BANDING_PHONE_URL;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{@"useraccount": _openid};
}

@end
