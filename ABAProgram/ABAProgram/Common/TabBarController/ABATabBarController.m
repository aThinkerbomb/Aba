//
//  ABATabBarController.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/22.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "ABATabBarController.h"
#import "BaseNavigationController.h"
#import "HomeViewController.h"
#import "BabyViewController.h"
#import "BenefitViewController.h"
#import "SchoolViewController.h"

@interface ABATabBarController ()

@end

@implementation ABATabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupChildController];
}


- (void)setupChildController
{
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor themeDarkGrayColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor themeColor], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    BabyViewController *babyVC = [[BabyViewController alloc] init];
    BenefitViewController *benefitVC = [[BenefitViewController alloc] init];
    SchoolViewController *schoolVC = [[SchoolViewController alloc] init];
    
    BaseNavigationController *HomeNavi = [self setupChildViewController:homeVC title:@"一天一播" normalImage:[UIImage imageNamed:@"video_normat"] selectedImage:[UIImage imageNamed:@"video_select"]];
    
    BaseNavigationController *BabyNavi = [self setupChildViewController:babyVC title:@"宝宝优选" normalImage:[UIImage imageNamed:@"baby_normat"] selectedImage:[UIImage imageNamed:@"baby_select"]];
    
    BaseNavigationController *BenefitNavi = [self setupChildViewController:benefitVC title:@"一天一惠" normalImage:[UIImage imageNamed:@"privilege_normat"] selectedImage:[UIImage imageNamed:@"privilege_select"]];
    
    BaseNavigationController *SchoolNavi = [self setupChildViewController:schoolVC title:@"亲子学堂" normalImage:[UIImage imageNamed:@"school_normat"] selectedImage:[UIImage imageNamed:@"school_select"]];
    
    self.viewControllers = @[HomeNavi, BabyNavi, BenefitNavi, SchoolNavi];
}


- (BaseNavigationController *)setupChildViewController:(UIViewController *)viewController title:(NSString *)title normalImage:(UIImage *)image selectedImage:(UIImage *)selectImage
{
    viewController.tabBarItem.title = title;
    viewController.tabBarItem.image = image;
    viewController.tabBarItem.selectedImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    BaseNavigationController *baseNavi = [[BaseNavigationController alloc] initWithRootViewController:viewController];
    return baseNavi;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
