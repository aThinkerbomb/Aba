//
//  FeedBackApi.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/18.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "FeedBackApi.h"

@implementation FeedBackApi
{
    NSString *_content;
}
- (id)initWithFeedBack:(NSString *)content {
    self = [super init];
    if (self) {
        _content = content;
    }
    return self;
}

- (NSString *)requestUrl {
    return ABA_FEED_BACK_URL;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{@"feedbackcontent": _content,
             @"userid": [KZUserDefaults objectForKey:@"userid"]};
}


@end
