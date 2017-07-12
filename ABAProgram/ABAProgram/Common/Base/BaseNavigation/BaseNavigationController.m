//
//  BaseNavigationController.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/22.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "BaseNavigationController.h"
@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置navi 的背景，不能使用backGround，backGround是渲染navigationBar 背面的，会被前面的EffectFilterView挡住
    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor themeColor]] forBarMetrics:UIBarMetricsDefault];
    
    // 设置navi title
    NSMutableDictionary *attributesDic = [NSMutableDictionary dictionary];
    [attributesDic setObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    self.navigationBar.titleTextAttributes = attributesDic;
    self.navigationBar.translucent = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
