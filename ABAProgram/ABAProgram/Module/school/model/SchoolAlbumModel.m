//
//  SchoolAlbumModel.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/28.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "SchoolAlbumModel.h"

@implementation SchoolAlbumModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"albumId": @"id"};
}

@end
