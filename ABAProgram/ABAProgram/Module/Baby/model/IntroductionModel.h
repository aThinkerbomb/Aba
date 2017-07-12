//
//  IntroductionModel.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/2.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "BaseModel.h"

@interface IntroductionModel : BaseModel

@property (nonatomic, copy) NSString * introductionId;
@property (nonatomic, copy) NSString * userid;
@property (nonatomic, copy) NSString * institutiontype;
@property (nonatomic, copy) NSString * institutionname;
@property (nonatomic, copy) NSString * institutionlogo;
@property (nonatomic, copy) NSString * pccoin;
@property (nonatomic, copy) NSString * legalperson;
@property (nonatomic, copy) NSString * businesslicenseimages;
@property (nonatomic, copy) NSString * idcardimage;
@property (nonatomic, copy) NSString * phonenumber;
@property (nonatomic, copy) NSString * url;
@property (nonatomic, copy) NSString * address;
@property (nonatomic, copy) NSString * topiccontent;
@property (nonatomic, copy) NSString * profilepicture;
@property (nonatomic, copy) NSString * promotion;
@property (nonatomic, copy) NSString * endorseimage;
@property (nonatomic, copy) NSString * endorsenumber;
@property (nonatomic, copy) NSString * isdelet;
@property (nonatomic, copy) NSString * remark;
@property (nonatomic, copy) NSString * creattime;
@property (nonatomic, copy) NSString * longitude;
@property (nonatomic, copy) NSString * latitude;
@property (nonatomic, copy) NSString * distance;

@property (nonatomic, assign) NSInteger height;
@property (nonatomic, assign) BOOL open;
@end
