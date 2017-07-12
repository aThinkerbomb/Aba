//
//  VersionModel.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/26.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "BaseModel.h"

@interface VersionModel : BaseModel

@property (nonatomic, copy) NSString *versionId;
@property (nonatomic, copy) NSString *appname;
@property (nonatomic, copy) NSString *versoncode;
@property (nonatomic, copy) NSString *versonname;
@property (nonatomic, copy) NSString *versionDes;
@property (nonatomic, copy) NSString *time;

@end
