//
//  GoodsDetailApi.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/4.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "GoodsDetailApi.h"

@implementation GoodsDetailApi
{
    NSString *_goodid;
}
- (id)initWithGoodsDetailId:(NSString *)goodId {
    self = [super init];
    if (self) {
        
        _goodid = goodId;
    }
    return self;
}


- (NSString *)requestUrl {
    return ABA_TODAY_GRAY_BUY_INFO_URL;
}


- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{@"id": _goodid};
}

@end
