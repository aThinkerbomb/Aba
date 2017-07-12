//
//  SchoolAlbumModel.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/28.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "BaseModel.h"

@interface SchoolAlbumModel : BaseModel

@property (nonatomic, copy) NSString * albumId;
@property (nonatomic, copy) NSString * userid;
@property (nonatomic, copy) NSString * albumname;
@property (nonatomic, copy) NSString * imageurl;
@property (nonatomic, copy) NSString * lecturerName;
@property (nonatomic, copy) NSString * introduction;
@property (nonatomic, copy) NSString * isdelet;
@property (nonatomic, copy) NSString * creattime;

@property (nonatomic, assign) float height;

// 判断section 是否展开
@property (nonatomic, assign) BOOL open;
@end
