//
//  ExpertVideoModel.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/12.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "BaseModel.h"

@interface ExpertVideoModel : BaseModel

@property (nonatomic, copy) NSString * videoid;
@property (nonatomic, copy) NSString * userid;
@property (nonatomic, copy) NSString * username;
@property (nonatomic, copy) NSString * userimg;
@property (nonatomic, copy) NSString * albumid;
@property (nonatomic, copy) NSString * videoname;
@property (nonatomic, copy) NSString * videotype;
@property (nonatomic, copy) NSString * videolength;
@property (nonatomic, copy) NSString * videolooksum;
@property (nonatomic, copy) NSString * videosharesum;
@property (nonatomic, copy) NSString * videothumupsum;
@property (nonatomic, copy) NSString * videopccoin;
@property (nonatomic, copy) NSString * ispublic;
@property (nonatomic, copy) NSString * isspecial;
@property (nonatomic, copy) NSString * issecret;
@property (nonatomic, copy) NSString * filename;
@property (nonatomic, copy) NSString * videopath;
@property (nonatomic, copy) NSString * isdelet;
@property (nonatomic, copy) NSString * creattime;
@property (nonatomic, copy) NSString * remark;
@property (nonatomic, copy) NSString * isthumup;

@end
