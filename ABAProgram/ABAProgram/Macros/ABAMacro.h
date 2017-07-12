//
//  ABAMacro.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/20.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#ifndef ABAMacro_h
#define ABAMacro_h

#pragma mark - 只存放 自定义的 宏


#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH  [UIScreen mainScreen].bounds.size.height

/** 开发的时候打印，但是发布的时候不打印的NSLog*/
#ifdef DEBUG
#define NSLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define NSLog(...)
#endif

/** 颜色*/
#define kRGBColor(r, g, b)     [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define kRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]

/// 主题颜色
#define ABAThemeColor kRGBColor(251, 170, 159)

#define kKeyWindow          [UIApplication sharedApplication].keyWindow
#define kAppDelegate        [UIApplication sharedApplication].delegate


/** 弱指针*/
#define KZWeakSelf(weakSelf)     __weak __typeof(self) weakSelf = self;
//    __weak __typeof(&*self)weakSelf =self;
//    __strong __typeof(self)strong = weakSelf;
/** 数据存储*/
#define KZUserDefaults [NSUserDefaults standardUserDefaults]
/** 适配*/
#define KZiPhone4_OR_4s    (SCREEN_HEIGHT == 480)
#define KZiPhone5_OR_5c_OR_5s   (SCREEN_HEIGHT == 568)
#define KZiPhone6_OR_6s   (SCREEN_HEIGHT == 667)
#define KZiPhone6Plus_OR_6sPlus   (SCREEN_HEIGHT == 736)

#endif /* ABAMacro_h */
