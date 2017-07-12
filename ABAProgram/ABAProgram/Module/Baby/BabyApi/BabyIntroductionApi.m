//
//  BabyIntroductionApi.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/2.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "BabyIntroductionApi.h"

@implementation BabyIntroductionApi
{
    NSString *_introId;
}
- (id)initWithIntroductionid:(NSString *)introId {
    
    self = [super init];
    if (self) {
        
        _introId = introId;
        
    }
    return self;
}


- (NSString *)requestUrl {
    return ABA_BABY_DETAIL_INTRODUCTION_URL;
}


- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{@"institutionId": _introId};
}

@end
