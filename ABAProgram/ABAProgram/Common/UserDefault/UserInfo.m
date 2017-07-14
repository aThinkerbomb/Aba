//
//  UserInfo.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/23.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

+ (instancetype)shareUserInfo
{
    static UserInfo *info = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        info = [[UserInfo alloc] init];
        
    });
    return info;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (BOOL)hasLogin
{
//    if ([KZUserDefaults objectForKey:@"userid"]) {
//        return YES;
//    }
    return NO;
}


@end
