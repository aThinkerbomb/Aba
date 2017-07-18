//
//  ZhiFuBaoPayApi.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/18.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "BaseApi.h"

@interface ZhiFuBaoPayApi : BaseApi

- (id)initWithMercid:(NSString *)mercid cashnum:(NSString *)cashnum;

@end
