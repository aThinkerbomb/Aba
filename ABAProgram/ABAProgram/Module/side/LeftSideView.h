//
//  LeftSideView.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/5.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FunctionType) {
    FunctionTypeMyVideo = 1,
    FunctionTypeHistoryRecord,
    FunctionTypeAboutOurs,
    FunctionTypeExit
};


typedef void(^LeftSideHandle)(FunctionType funtion);
typedef void(^UserInfoHandle)(void);

@interface LeftSideView : UIView

- (void)didSelectedSideFunction:(LeftSideHandle)handle;
- (void)gotoUserInfo:(UserInfoHandle)handle;

@end
