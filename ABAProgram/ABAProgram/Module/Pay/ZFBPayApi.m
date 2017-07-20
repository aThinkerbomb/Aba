//
//  ZFBPayApi.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/16.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "ZFBPayApi.h"

@implementation ZFBPayApi
{
    NSString *_goodsid;
    NSString *_isPre;
    NSString *_totalPrice;
    NSString *_goodsname;
}
- (id)initWithGoodsid:(NSString *)goodsid isPre:(NSString *)isPre totalPrice:(NSString *)totalPrice goodsname:(NSString *)goodsName{
    self = [super init];
    if (self) {
        
        _goodsid = goodsid;
        _isPre = isPre;
        _totalPrice = totalPrice;;
        _goodsname = goodsName;
        
    }
    return self;
}

- (NSString *)requestUrl {
    return ABA_ZFB_PAY_URL;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{@"goodsId": _goodsid,
             @"userId": [KZUserDefaults objectForKey:@"userid"]?:@"0",
             @"isPre": _isPre,
             @"goodsName": _goodsname,
             @"totalPrice": _totalPrice
             };
}
@end
