//
//  UserInfo.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/23.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

+ (instancetype)shareUserInfo;

// 判断登录
+ (BOOL)hasLogin;

@end
