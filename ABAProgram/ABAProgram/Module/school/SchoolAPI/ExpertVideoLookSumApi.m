
//
//  ExpertVideoLookSumApi.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/20.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "ExpertVideoLookSumApi.h"

@implementation ExpertVideoLookSumApi
{
    NSString *_videoId;
}
- (id)initWithLookSum:(NSString *)videoId {
    self = [super init];
    if (self) {
        
        _videoId = videoId;
        
    }
    return self;
}

- (NSString *)requestUrl {
    return ABA_EXPERT_LOOK_URL;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{@"id": _videoId,
             @"userid": [KZUserDefaults objectForKey:@"userid"]
             };
}

@end
