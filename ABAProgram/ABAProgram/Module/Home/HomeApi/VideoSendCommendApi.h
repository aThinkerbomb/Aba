//
//  VideoSendCommendApi.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/8.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "BaseApi.h"

@interface VideoSendCommendApi : BaseApi

- (id)initWithSendCommentLiveid:(NSString *)liveid type:(NSString *)type content:(NSString *)content;

@end
