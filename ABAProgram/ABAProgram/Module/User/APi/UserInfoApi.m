//
//  UserInfoApi.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/21.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "UserInfoApi.h"

@implementation UserInfoApi


- (id)initWithUserInfo {
    self = [super init];
    if (self) {
        

    }
    return self;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return ABA_GET_USER_INFO_URL;
}

- (id)requestArgument {
    return @{@"userid": [KZUserDefaults objectForKey:@"userid"]};
}

@end
