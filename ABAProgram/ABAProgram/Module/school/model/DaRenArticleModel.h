//
//  DaRenArticleModel.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/1.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "BaseModel.h"

@interface DaRenArticleModel : BaseModel

@property (nonatomic, copy) NSString *articleId;
@property (nonatomic, copy) NSString *articletitle;
@property (nonatomic, copy) NSString *articleurl;
@property (nonatomic, copy) NSString *imgurl;
@property (nonatomic, copy) NSString *darenid;
@property (nonatomic, copy) NSString *creattime;


@end
