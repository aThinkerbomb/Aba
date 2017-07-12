//
//  GoodsDetailModel.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/4.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "GoodsDetailModel.h"

@implementation detailuPreGPList

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"uPreGPId": @"id"};
}

@end


@implementation detailuserGoodsAttrList

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"userGoodsAttrId": @"id"};
}

@end



@implementation GoodsDetailModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"goodId": @"id"};
}


+ (NSDictionary *)mj_objectClassInArray {
    return @{@"uPreGPList": @"detailuPreGPList",
             @"userGoodsAttrList": @"detailuserGoodsAttrList"};
    
}






@end
