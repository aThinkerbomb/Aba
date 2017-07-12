//
//  HistoryWatchApi.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/12.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "HistoryWatchApi.h"

@implementation HistoryWatchApi

- (id)initWithHistoryWatch {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSString *)requestUrl {
    return ABA_HISTORY_WATCH_URL;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

-(id)requestArgument {
    return @{@"userid": [KZUserDefaults objectForKey:@"userid"]};
}

@end
