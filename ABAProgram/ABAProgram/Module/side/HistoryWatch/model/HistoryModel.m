//
//  HistoryModel.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/12.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "HistoryModel.h"

@implementation HistoryModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"videoid": @"id"};
}
@end
