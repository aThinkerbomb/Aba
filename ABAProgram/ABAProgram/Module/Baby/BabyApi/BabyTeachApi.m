//
//  BabyTeachApi.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/27.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "BabyTeachApi.h"

@implementation BabyTeachApi
{
    NSString *_latitude;
    NSString *_longitude;
}

- (id)initWithInstitutionAllList
{
    self = [super init];
    if (self) {
        
        _latitude = @"39.869963";
        _longitude = @"116.446341";
        
    }
    return self;
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl
{
    return ABA_BABY_GOOD_CLASS_URL;
}

- (id)requestArgument
{
    return @{
             @"longitude": _longitude,
             @"latitude":  _latitude
             };
}

@end
