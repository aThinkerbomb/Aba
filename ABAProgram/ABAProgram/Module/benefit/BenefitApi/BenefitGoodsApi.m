//
//  BenefitGoodsApi.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/28.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "BenefitGoodsApi.h"

@implementation BenefitGoodsApi

- (id)initWithBenefitGoods
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSString *)requestUrl{
    return ABA_TODAY_GRAY_BUY_URL;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

@end
