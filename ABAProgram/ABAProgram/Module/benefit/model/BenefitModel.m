//
//  BenefitModel.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/28.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "BenefitModel.h"

@implementation uPreGPList

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"preId": @"id"};
}

@end

@implementation userGoodsAttrList


@end

@implementation BenefitModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"benefitId": @"id"};
}
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"uPreGPList": @"uPreGPList",
             @"userGoodsAttrList": @"userGoodsAttrList"
             };
}
@end
