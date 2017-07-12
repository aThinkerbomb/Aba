//
//  VersionAPI.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/26.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "VersionAPI.h"

@implementation VersionAPI
- (id)initWithGetVersion
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
}

- (NSString *)requestUrl
{
    return ABA_GET_NEW_VERSION_URL;
}

@end
