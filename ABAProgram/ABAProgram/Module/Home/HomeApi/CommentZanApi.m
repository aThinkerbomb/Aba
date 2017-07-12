//
//  CommentZanApi.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/7.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "CommentZanApi.h"

@implementation CommentZanApi
{
    NSString *_mesid;
}
- (id)initWithMesId:(NSString *)mesid {
    self = [super init];
    if (self) {
        
        _mesid = mesid;
        
    }
    return self;
}

- (NSString *)requestUrl {
    return ABA_TO_ZAN_URL;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{@"id": _mesid,
             @"userid": [KZUserDefaults objectForKey:@"userid"]
             };
}

@end
