//
//  BenefitModel.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/28.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "BaseModel.h"

@interface uPreGPList : BaseModel

@property (nonatomic, copy)NSString *preId;
@property (nonatomic, copy)NSString *goodsid;
@property (nonatomic, copy)NSString *photourl;
@property (nonatomic, copy)NSString *creattime;

@end


@interface userGoodsAttrList : BaseModel

@end


@interface BenefitModel : BaseModel

@property (nonatomic, copy) NSString * benefitId;
@property (nonatomic, copy) NSString * goodsname;
@property (nonatomic, copy) NSString * oldprice;
@property (nonatomic, copy) NSString * newprice;
@property (nonatomic, copy) NSString * infourl;
@property (nonatomic, copy) NSString * ordernumber;
@property (nonatomic, copy) NSString * starttime;
@property (nonatomic, copy) NSString * endtime;
@property (nonatomic, copy) NSString * creattime;
@property (nonatomic, strong) NSArray * uPreGPList;
@property (nonatomic, strong) NSArray * userGoodsAttrList;

@end


