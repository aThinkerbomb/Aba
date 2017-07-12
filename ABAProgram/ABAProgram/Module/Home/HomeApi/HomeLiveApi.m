//
//  HomeLiveApi.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/1.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "HomeLiveApi.h"

@implementation HomeLiveApi

- (id)initWithHomeLive
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSString *)requestUrl {
    return  ABA_NOW_LIVE_URL;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

@end
