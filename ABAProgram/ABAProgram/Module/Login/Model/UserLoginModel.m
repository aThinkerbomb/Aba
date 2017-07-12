//
//  UserLoginModel.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/24.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "UserLoginModel.h"

@implementation UserLoginModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"userId": @"id"};
}

@end
