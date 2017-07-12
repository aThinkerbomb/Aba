//
//  LoginViewController.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/22.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "LoginDataSource.h"
#import "UserLoginModel.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
@property (weak, nonatomic) IBOutlet UIButton *LoginBtn;

@property (nonatomic, strong) UserLoginModel *userModel;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.agreeBtn.selected = YES;
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)setupController
{
    
}

# pragma mark - 登录的网络请求
- (void)LoginRequestWihtPhone:(NSString *)phone pwd:(NSString *)pwd
{
    [self showLoadingView:YES];
    LoginDataSource *dataSource = [[LoginDataSource alloc] initWithLoginPhone:phone Password:pwd userType:@"1" loginType:@"3"];
    [dataSource startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self showLoadingView:NO];
        
        if ([ABAConfig checkResponseObject:request.responseObject]) {
            
            self.userModel = [UserLoginModel mj_objectWithKeyValues:[request.responseObject objectForKey:@"body"]];
            
            [KZUserDefaults setObject:self.userModel.userId forKey:@"userid"];
            
            [self showTipsMsg:@"登录成功" delayDo:^{
                // 设置根视图
                [ABAConfig creatRootViewController:[ABAConfig initTabBarViewController]];
            }];

        } else {
            [self showTipsMsg:@"登录失败"];
        }

    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self showLoadingView:NO];
        [self showTipsMsg:@"网络请求错误"];
        
    }];
}



/**
 忘记密码、立即注册

 @param sender 1 忘记密码    2 立即注册
 */
- (IBAction)ForgotPasswordAction:(UIButton *)sender {
    
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    registerVC.choose = sender.tag-100;
    [self pushToNextNavigationController:registerVC];
    
}



// 登录
- (IBAction)LoginAction:(UIButton *)sender {
    
    if ([self.phone.text isEqualToString:@""]) {
        
        [self showTipsMsg:@"请输入手机号" withDelay:1];
        return ;
    }
    
    if ([self.password.text isEqualToString:@""]) {
        [self showTipsMsg:@"请输入密码" withDelay:1];
        return;
    }
    
    if (self.phone.text.length != 11) {
        [self showTipsMsg:@"请输入正确的手机号" withDelay:1];
        return;
    }
    if (!self.agreeBtn.selected) {
        [self showTipsMsg:@"请同意啊八的协议" withDelay:1];
        return;
    }
    
    [self LoginRequestWihtPhone:self.phone.text pwd:self.password.text];
    
}

// 是否同意按钮
- (IBAction)agreeAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
}

// 协议跳转
- (IBAction)ABAProtocol:(UIButton *)sender {
    
    
    
}

/**
 其他三方框架登录方法

 @param sender tag值为 1、2、3 分别对应 微信、QQ、微博
 */
- (IBAction)OtherLoginAction:(UIButton *)sender {
    
    
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
