//
//  SchoolDaRenApi.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/28.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "SchoolDaRenApi.h"

@implementation SchoolDaRenApi

- (id)initWithSchoolDaRen
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (NSString *)requestUrl {
    return ABA_DA_REN_LIST_URL;
}

@end
