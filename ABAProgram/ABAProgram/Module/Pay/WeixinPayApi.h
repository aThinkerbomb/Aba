//
//  WeixinPayApi.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/18.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "BaseApi.h"

@interface WeixinPayApi : BaseApi

- (id)initWithCommodityName:(NSString *)commodityName totalPrice:(NSString *)totalPrice;

@end
