//
//  EditUserBirthdayView.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/22.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserLoginModel.h"


typedef void(^UpdateUserInfoHandle)(NSString * birthday);
typedef void(^closeHandle)(void);

@interface EditUserBirthdayView : UIView

@property (nonatomic, strong) UserLoginModel * userModel;

- (void)ClickedSure:(UpdateUserInfoHandle)handle;
- (void)ClickedCancel:(closeHandle)handle;

@end
