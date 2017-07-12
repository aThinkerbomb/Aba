//
//  VideoSendCommendApi.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/8.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "VideoSendCommendApi.h"

@implementation VideoSendCommendApi
{
    NSString *_linveid;
    NSString *_type;
    NSString *_content;
}

- (id)initWithSendCommentLiveid:(NSString *)liveid type:(NSString *)type content:(NSString *)content {
    self = [super init];
    if (self) {
        
        _linveid = liveid;
        _type = type;
        _content = content;
        
    }
    return self;
}

- (NSString *)requestUrl {
    return ABA_ADD_REPLY_URL;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
             @"userid": [KZUserDefaults objectForKey:@"userid"],
             @"liveid": _linveid,
             @"content": _content,
             @"type": _type
             };
}
@end
