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
#import "CheckBindPhone.h"
#import "OtherLoginApi.h"
#import "AbaAlertView.h"


@interface LoginViewController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
@property (weak, nonatomic) IBOutlet UIButton *LoginBtn;

@property (nonatomic, strong) UserLoginModel *userModel;
@property (nonatomic, strong) AbaAlertView *alertView;

@property (nonatomic, strong) NSMutableDictionary *infoDic;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.agreeBtn.selected = YES;
    self.infoDic = [NSMutableDictionary dictionary];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
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
            [KZUserDefaults setObject:self.userModel.userimg forKey:@"userimg"];
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
    
    NSInteger tag = sender.tag - 200;
    if (tag == 1) {
        [self WeiXinLogin];
    } else if (tag == 2) {
        [self QQLogin];
    } else {
        [self SinaLogin];
    }
    
}

#pragma mark - 检查是否绑定手机
- (void)checkBingPhoneInfoDic:(NSDictionary *)dic {
    
    [self showLoadingView:YES];
    NSString *openid = [dic objectForKey:@"useraccount"];
    CheckBindPhone *bindApi = [[CheckBindPhone alloc] initWithBindPhoneOpenid:openid];
    [bindApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        [self showLoadingView:NO];
        
        self.userModel = [UserLoginModel mj_objectWithKeyValues:[request.responseObject objectForKey:@"body"]];
        
        if ([ABAConfig checkResponseObject:request.responseObject] && ![self.userModel.userphone isEqualToString:@""]) {
            
            // 已经绑定，就直接登录
            [self OtherLoginWithInfoDic:dic];
            
            
        } else {
            
            // 需要弹出框，绑定手机号
            self.alertView = [[AbaAlertView alloc] initWithTitle:@"请绑定手机号" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [self.alertView setAlertViewStyle:UIAlertViewStyleSecureTextInput];
            UITextField *phoneTextField = [self.alertView textFieldAtIndex:0];
            phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
            phoneTextField.placeholder = @"请输入手机号";
            [self.alertView show];
            
        }
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self showLoadingView:NO];
    }];
    
}


#pragma mark - 三方登录

- (void)OtherLoginWithInfoDic:(NSDictionary *)dic {
    
    [self showLoadingView:YES];
    
    OtherLoginApi *loginApi = [[OtherLoginApi alloc] initWithInfoDictionary:dic];
    [loginApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
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


#pragma mark - 三方授权

- (void)WeiXinLogin {
    
    [[UMSocialManager defaultManager] cancelAuthWithPlatform:UMSocialPlatformType_WechatSession completion:^(id result, NSError *error) {//先取消以前的授权 否则 如果授权过 他会直接获取信息 而不跳微信页授权
        
        
        //获取用户信息
        [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:self completion:^(UMSocialUserInfoResponse * result, NSError *error) {
            if (error) {
                
                [self showTipsMsg:@"授权失败"];
            } else {
                
                UMSocialUserInfoResponse *resp = result;
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                [dic setObject:@"1" forKey:@"usertype"];
                [dic setObject:@"2" forKey:@"logintype"];
                [dic setObject:resp.openid forKey:@"useraccount"];
                [dic setObject:resp.name forKey:@"username"];
                [dic setObject:resp.iconurl forKey:@"userimg"];
                [dic setObject:resp.unionGender?@"0":@"1" forKey:@"usergender"];
                
                // 设置一个全局的信息，方便绑定手机时候用
                self.infoDic = [NSMutableDictionary dictionaryWithDictionary:dic];
                
                [KZUserDefaults setObject:resp.iconurl forKey:@"userimg"];
                
                // 检查是否绑定手机号
                [self checkBingPhoneInfoDic:dic];

            }
            
        }];
        
    }];
}

- (void)QQLogin {
    [[UMSocialManager defaultManager] cancelAuthWithPlatform:UMSocialPlatformType_QQ completion:^(id result, NSError *error) {//先取消以前的授权 否则 如果授权过 他会直接获取信息 而不跳微信页授权
        [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:self completion:^(id result, NSError *error) {
            if (error) {
                [self showTipsMsg:@"授权失败"];
                
            } else {
               
                UMSocialUserInfoResponse *resp = result;
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                [dic setObject:@"1" forKey:@"usertype"];
                [dic setObject:@"1" forKey:@"logintype"];
                [dic setObject:resp.openid forKey:@"useraccount"];
                [dic setObject:resp.name forKey:@"username"];
                [dic setObject:resp.iconurl forKey:@"userimg"];
                [dic setObject:resp.unionGender?@"0":@"1" forKey:@"usergender"];
                
                // 设置一个全局的信息，方便绑定手机时候用
                self.infoDic = [NSMutableDictionary dictionaryWithDictionary:dic];
                
                [KZUserDefaults setObject:resp.iconurl forKey:@"userimg"];
                
                // 检查是否绑定手机号
                [self checkBingPhoneInfoDic:dic];
            }
        }];
        
        
    }];
    
}


- (void)SinaLogin {
    [[UMSocialManager defaultManager] cancelAuthWithPlatform:UMSocialPlatformType_Sina completion:^(id result, NSError *error) {//先取消以前的授权 否则 如果授权过 他会直接获取信息 而不跳微信页授权
        [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_Sina currentViewController:self completion:^(id result, NSError *error) {
            if (error) {
                
            } else {
                UMSocialUserInfoResponse *resp = result;
                
                // 授权信息
                NSLog(@"Sina uid: %@", resp.uid);
                NSLog(@"Sina accessToken: %@", resp.accessToken);
                NSLog(@"Sina refreshToken: %@", resp.refreshToken);
                NSLog(@"Sina expiration: %@", resp.expiration);
                
                // 用户信息
                NSLog(@"Sina name: %@", resp.name);
                NSLog(@"Sina iconurl: %@", resp.iconurl);
                NSLog(@"Sina gender: %@", resp.unionGender);
                
                // 第三方平台SDK源数据
                NSLog(@"Sina originalResponse: %@", resp.originalResponse);
            }
        }];
        
        
    }];
}


#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        UITextField *textField = [alertView textFieldAtIndex:0];
        self.alertView.phone = textField.text;
        if ([textField.text isEqualToString:@""]) {
            [self showTipsMsg:@"请输入手机号"];
            return;
        }
        if (textField.text.length != 11) {
            [self showTipsMsg:@"请输入正确的手机号"];
            return;
        }
        
        // 绑定手机 传手机号
        [self.infoDic setObject:textField.text forKey:@"userphone"];
        
        // 绑定手机号后 直接登录
        [self OtherLoginWithInfoDic:self.infoDic];
        
        [self showTipsMsg:@"绑定成功"];
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
