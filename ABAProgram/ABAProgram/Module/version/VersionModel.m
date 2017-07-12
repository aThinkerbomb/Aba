//
//  VersionModel.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/26.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "VersionModel.h"

@implementation VersionModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"versionId": @"id",
             @"versionDes": @"description"
             };
}

@end
