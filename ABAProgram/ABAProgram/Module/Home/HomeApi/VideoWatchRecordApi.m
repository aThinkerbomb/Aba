//
//  VideoWatchRecordApi.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/6.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "VideoWatchRecordApi.h"

@implementation VideoWatchRecordApi
{
    NSString *_goodsId;
}
- (id)initWithUserWatchRecordGoodsid:(NSString *)goodsId {
    self = [super init];
    if (self) {
        _goodsId = goodsId;
    }
    return self;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (NSString *)requestUrl {
    return ABA_Watch_Record_URL;
}

- (id)requestArgument {
    return @{@"userid": [KZUserDefaults objectForKey:@"userid"],
             @"goodsid": _goodsId};
}


@end
