//
//  VideoMessageApi.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/6.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "BaseApi.h"

@interface VideoMessageApi : BaseApi

- (id)initWithVideMessageLiveid:(NSString *)liveid type:(NSString *)type;
@end