

//
//  UpdateUserInfoApi.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/22.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "UpdateUserInfoApi.h"

@implementation UpdateUserInfoApi
{
    NSDictionary *_dic;
}
- (id)initWithUserInfo:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        
        _dic = [NSDictionary dictionaryWithDictionary:dictionary];
        
    }
    return self;
}


- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}


- (NSString *)requestUrl {
    return ABA_USER_INFO_EDIT_URL;
}

- (id)requestArgument {
    return _dic;
}

@end
