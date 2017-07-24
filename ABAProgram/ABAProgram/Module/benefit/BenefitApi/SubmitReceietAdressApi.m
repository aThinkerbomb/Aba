//
//  SubmitReceietAdressApi.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/12.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "SubmitReceietAdressApi.h"

@implementation SubmitReceietAdressApi
{
    NSString *_shipName;
    NSString *_shipPhone;
    NSString *_shipAdress;
    NSString *_orderid;
}
- (id)initWithShipName:(NSString *)shipName shipPhone:(NSString *)shipPhone shipAdress:(NSString *)shipAdress orderid:(NSString *)orderid{
    self = [super init];
    if (self) {
        
        _shipName = shipName;
        _shipPhone = shipPhone;
        _shipAdress = shipAdress;
        _orderid = orderid;
    }
    return self;
}

- (NSString *)requestUrl {
    return ABA_UPDATE_RECEIPT_DES_URL;
}


- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}


- (id)requestArgument {
    return @{@"userid": [KZUserDefaults objectForKey:@"userid"],
             @"shipname": _shipName,
             @"shipphone": _shipPhone,
             @"shipaddress": _shipAdress,
             @"id": _orderid?:@""
             };
}


@end
