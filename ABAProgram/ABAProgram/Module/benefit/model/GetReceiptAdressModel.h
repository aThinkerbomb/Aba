//
//  GetReceiptAdressModel.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/10.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "BaseModel.h"

@interface GetReceiptAdressModel : BaseModel

@property (nonatomic, copy) NSString * recId;
@property (nonatomic, copy) NSString * userid;
@property (nonatomic, copy) NSString * shipname;
@property (nonatomic, copy) NSString * shipphone;
@property (nonatomic, copy) NSString * shipaddress;
@property (nonatomic, copy) NSString * creattime;
@end
