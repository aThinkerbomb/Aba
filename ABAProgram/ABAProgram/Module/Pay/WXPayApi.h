//
//  WXPayApi.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/16.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "BaseApi.h"

@interface WXPayApi : BaseApi

- (id)initWithGoodsid:(NSString *)goodsid isPre:(NSString *)isPre totalPrice:(NSString *)totalPrice goodsname:(NSString *)goodsName;


@end
