//
//  VersionManager.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/26.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VersionManager : NSObject

+ (instancetype)shareInstance;

// 开启版本检测
+ (void)startCheckVersion;

@end
