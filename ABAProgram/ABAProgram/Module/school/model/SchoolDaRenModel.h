//
//  SchoolDaRenModel.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/28.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "BaseModel.h"

@interface SchoolDaRenModel : BaseModel

@property (nonatomic, copy) NSString * DaRenid;
@property (nonatomic, copy) NSString * userid;
@property (nonatomic, copy) NSString * darenname;
@property (nonatomic, copy) NSString * imageurl;
@property (nonatomic, copy) NSString * isdelet;
@property (nonatomic, copy) NSString * creattime;

// 目前没有简介这个字段  height这个字段待以后扩展用
@property (nonatomic, assign) float height;

// 判断section 是否展开
@property (nonatomic, assign) BOOL open;

@end
