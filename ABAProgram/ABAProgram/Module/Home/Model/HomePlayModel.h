//
//  HomePlayModel.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/26.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "BaseModel.h"
#import "HomeSysUserInfoModel.h"
@interface HomePlayModel : BaseModel

@property (nonatomic, copy) NSString *liveId;
@property (nonatomic, copy) NSString *userid;
@property (nonatomic, copy) NSString *streamname;
@property (nonatomic, copy) NSString *bannerurl;
@property (nonatomic, copy) NSString *recordurl;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *livetime;
@property (nonatomic, copy) NSString *looknum;
@property (nonatomic, copy) NSString *creattime;
@property (nonatomic, strong) HomeSysUserInfoModel *sysUserInfo;

@end
