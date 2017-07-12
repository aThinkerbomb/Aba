//
//  HomePlayListApi.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/26.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "HomePlayListApi.h"

@implementation HomePlayListApi

- (id)initWithOneDayOnePlay
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSString *)requestUrl
{
    return ABA_LIVE_PLAY_BACK_URL;
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
}


@end
