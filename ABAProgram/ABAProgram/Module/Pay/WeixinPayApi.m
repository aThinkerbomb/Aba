//
//  WeixinPayApi.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/18.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "WeixinPayApi.h"

@implementation WeixinPayApi
{
    NSString *_commodityName;
    NSString *_totalPrice;
}


- (id)initWithCommodityName:(NSString *)commodityName totalPrice:(NSString *)totalPrice {
    self = [super init];
    if (self) {
        _commodityName = commodityName;
        _totalPrice = totalPrice;
    }
    return self;
}

- (NSString *)requestUrl {
    return ABA_WX_PAY_URL;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{@"commodityName": _commodityName,
             @"totalPrice": _totalPrice};
}

@end
