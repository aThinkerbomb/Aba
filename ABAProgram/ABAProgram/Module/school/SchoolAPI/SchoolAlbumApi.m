//
//  SchoolAlbumApi.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/28.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "SchoolAlbumApi.h"

@implementation SchoolAlbumApi

- (id)initWithSchoolAlbum
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSString *)requestUrl {
    return ABA_EXPORT_LIST_URL;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

@end