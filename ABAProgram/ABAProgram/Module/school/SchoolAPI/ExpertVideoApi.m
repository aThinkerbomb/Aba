//
//  ExpertVideoApi.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/12.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "ExpertVideoApi.h"

@implementation ExpertVideoApi
{
    NSString *_albumid;
}
- (id)initWithAlbumId:(NSString *)albumid {
    self = [super init];
    if (self) {
        _albumid = albumid;
    }
    return self;
}

- (NSString *)requestUrl {
    return ABA_EXPERT_VIDEO_INFO_LIST_URL;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{@"albumid": _albumid};
}

@end
