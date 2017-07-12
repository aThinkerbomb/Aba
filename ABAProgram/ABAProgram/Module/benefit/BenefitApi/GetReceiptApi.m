//
//  GetReceiptApi.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/10.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "GetReceiptApi.h"

@implementation GetReceiptApi

- (id)initWithReceiptAdress {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSString *)requestUrl {
    return ABA_CHECK_USER_RECEIPT_DES_URL;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{@"userid": [KZUserDefaults objectForKey:@"userid"]?:@"0"};
}

@end
