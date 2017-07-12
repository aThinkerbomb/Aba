//
//  SubmitReceietAdressApi.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/12.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "BaseApi.h"

@interface SubmitReceietAdressApi : BaseApi

- (id)initWithShipName:(NSString *)shipName shipPhone:(NSString *)shipPhone shipAdress:(NSString *)shipAdress orderid:(NSString *)orderid;

@end
