//
//  VideoBrowHistoryApi.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/6.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "VideoBrowNumberApi.h"

@implementation VideoBrowNumberApi
{
    NSString *_goodsId;
}

- (id)initWithBrowHistoryGoodsId:(NSString *)goodsId {
    self = [super init];
    if (self) {
        _goodsId = goodsId;
    }
    return self;
}

- (NSString *)requestUrl {
    return ABA_Brow_Number_URL;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

-(id)requestArgument {
    return @{@"id": _goodsId};
}
@end
