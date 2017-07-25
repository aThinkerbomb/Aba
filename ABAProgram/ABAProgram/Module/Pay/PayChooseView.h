//
//  PayChooseView.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/16.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import <UIKit/UIKit.h>

// index 1--微信   2--支付宝
typedef void(^PayHandle)(NSInteger index);
typedef void(^CloseAction)(void);
@interface PayChooseView : UIView

@property (weak, nonatomic) IBOutlet UIButton *WxBtn;
@property (weak, nonatomic) IBOutlet UIButton *zfbBtn;

- (void)closePayView:(CloseAction)close;
- (void)SurePay:(PayHandle)handle;

@end
