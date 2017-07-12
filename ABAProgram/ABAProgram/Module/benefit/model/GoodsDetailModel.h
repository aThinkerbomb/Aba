//
//  GoodsDetailModel.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/4.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "BaseModel.h"


@interface detailuPreGPList : BaseModel

@property (nonatomic, copy) NSString * uPreGPId;
@property (nonatomic, copy) NSString * goodsid;
@property (nonatomic, copy) NSString * photourl;
@property (nonatomic, copy) NSString * creattime;

@end


@interface detailuserGoodsAttrList : BaseModel

@property (nonatomic, copy) NSString * userGoodsAttrId;
@property (nonatomic, copy) NSString * goodsid;
@property (nonatomic, copy) NSString * attrid;
@property (nonatomic, copy) NSString * attrvalue;
@property (nonatomic, copy) NSString * creattime;
@property (nonatomic, copy) NSString * attrname;

@end

typedef NS_ENUM(NSInteger, DetailStyle) {
    
    DetailStyleOfGoods = 1,
    DetailStyleOfService
};

@interface GoodsDetailModel : BaseModel

@property (nonatomic, copy) NSString * goodId;
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


/**
 详情类型  自己添加的字段  1 商品详情   2 服务详情  默认 1；
 */
@property (nonatomic, assign) DetailStyle detailStyle;


@end
