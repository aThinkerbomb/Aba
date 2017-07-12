//
//  UpdatePasswordApi.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/25.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "BaseApi.h"

@interface UpdatePasswordApi : BaseApi

- (id)initWithUseraccount:(NSString *)useraccount passwprd:(NSString *)password;

@end
