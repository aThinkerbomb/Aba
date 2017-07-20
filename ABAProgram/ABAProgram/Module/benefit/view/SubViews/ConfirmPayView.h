//
//  ConfirmPayView.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/11.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ConfirmPayDelegate;

@interface ConfirmPayView : UIView

@property (nonatomic, assign)id<ConfirmPayDelegate>delegaet;

@end

@protocol ConfirmPayDelegate <NSObject>

// 确认支付
- (void)confirmPayAction;

@end
