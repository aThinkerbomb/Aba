//
//  BaseViewController.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/21.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

// 初始化UI
- (void)setupController;

// 展示侧边栏
- (void)showLeftSideView;

// 设置navi 左右按钮图标
- (void)setNaviLeftItemNormalImage:(id)normalImage HighlightedIamge:(id)highLightedImage;
- (void)setNaviRightItemNormalImage:(UIImage *)normalImage HighlightedIamge:(UIImage *)highLightedImage;

// navi 左右按钮相应事件
- (void)leftButtonAction:(UIButton *)sender;
- (void)rightButtonAction:(UIButton *)sender;


// push、pop
- (void)pushToNextNavigationController:(UIViewController *)viewcontroller;
- (void)popBack;
- (void)popRootViewController;
- (void)popToViewController:(Class)controller;


// MBProgressHUD
- (void)showLoadingView:(BOOL)isShow;
- (void)showTipsMsg:(NSString *)msg;
- (void)showTipsMsg:(NSString *)msg withDelay:(NSTimeInterval)delay;
- (void)showTipsMessageDelayPopBackWithMessage:(NSString *)message;
- (void)showTipsMsg:(NSString *)msg delayPsuhViewController:(UIViewController *)viewController;
- (void)showTipsMsg:(NSString *)msg delayDo:(void(^)())complete;

@end
