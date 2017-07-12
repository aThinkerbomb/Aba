//
//  VideoMessageApi.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/6.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "VideoMessageApi.h"

@implementation VideoMessageApi
{
    NSString *_liveid;
    NSString *_type;
}
- (id)initWithVideMessageLiveid:(NSString *)liveid type:(NSString *)type {
    self = [super init];
    if (self) {
        
        _liveid = liveid;
        _type = type;
        
    }
    return self;
}

- (NSString *)requestUrl {
    return ABA_GET_REPLY_URL;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (id)requestArgument {
    return @{@"liveid": _liveid,
             @"type": _type};
}
@end
