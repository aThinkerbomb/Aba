//
//  SchoolArticleModel.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/28.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "SchoolArticleModel.h"

@implementation SchoolArticleModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"articleId": @"id"};
}

@end
