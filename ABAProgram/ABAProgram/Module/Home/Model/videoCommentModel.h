//
//  videoCommentModel.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/6.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "BaseModel.h"
#import "HomeSysUserInfoModel.h"


@interface videoCommentModel : BaseModel

@property (nonatomic, copy) NSString *mesId;
@property (nonatomic, copy) NSString *userid;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *liveid;
@property (nonatomic, copy) NSString *topnum;
@property (nonatomic, copy) NSString *parentid;
@property (nonatomic, copy) NSString *creattime;
@property (nonatomic, strong) NSArray *replyUserLiveMsgList;
@property (nonatomic, strong) HomeSysUserInfoModel *sysUserInfo;

// 每个评论的高度
@property (nonatomic, assign) CGFloat height;

@end
