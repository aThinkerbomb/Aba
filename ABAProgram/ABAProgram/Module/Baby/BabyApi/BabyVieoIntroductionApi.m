//
//  BabyVieoIntroductionApi.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/2.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "BabyVieoIntroductionApi.h"

@implementation BabyVieoIntroductionApi {
    
    NSString *_insId;
}

- (id)initWithInstitutionid:(NSString *)insId {

    self = [super init];
    if (self) {
        
        _insId = insId;
    }
    return self;
}


- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return ABA_BABY_DETAIL_URL;
}

- (id)requestArgument {
    return @{@"institutionid": _insId};
}

@end
