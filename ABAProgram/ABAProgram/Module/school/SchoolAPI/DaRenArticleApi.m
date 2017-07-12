//
//  DaRenArticleApi.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/1.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "DaRenArticleApi.h"

@implementation DaRenArticleApi
{
    NSString *_daRenid;
}
- (id)initWithDaRenid:(NSString *)darenid
{
    self = [super init];
    if (self) {
        _daRenid = darenid;
    }
    return self;
}

- (NSString *)requestUrl {
    return ABA_DA_REN_INFO_URL;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{@"darenid": _daRenid};
    
}

@end
