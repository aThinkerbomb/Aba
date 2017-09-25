//
//  RegisterViewController.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/23.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "RegisterViewController.h"
#import "GetRegisterVerCode.h"
#import "ForgotPasswordApi.h"
#import "UpdatePasswordApi.h"
#import "RehisterApi.h"
@interface RegisterViewController ()
{
    int downTime;
}
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *VerificationCode;
@property (weak, nonatomic) IBOutlet UIButton *VerificationCodeButton;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *eye;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
@property (nonatomic, strong) NSTimer * timer;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    downTime = 60;
    
    self.sureButton.layer.cornerRadius = 20;
    self.sureButton.layer.masksToBounds = YES;
    
    if (self.choose == 1) {
        self.title = @"重置密码";
        self.password.placeholder = @"请输入新密码";
        [self.sureButton setTitle:@"修改密码" forState:UIControlStateNormal];
    } else {
        self.title = @"手机号注册";
        self.password.placeholder = @"请输入密码";
        [self.sureButton setTitle:@"注册" forState:UIControlStateNormal];
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}


- (void)setupController
{
    [super setupController];
}

#pragma mark - 立即注册 获取验证码接口
- (void)getVerificationCodeOfRegister
{
    GetRegisterVerCode *verCode = [[GetRegisterVerCode alloc] initWithRegisterPhone:self.phone.text];
    [verCode startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        if ([ABAConfig checkResponseObject:request.responseObject]) {
            NSString * msg = [request.responseObject objectForKey:@"body"];
            if ([msg containsString:@"手机号码已存在"]) {
                [self showTipsMsg:@"该手机号已经注册！"];
            } else {
                //初始化计时器
                [self initTimer];
            }
        }else {
            [self showTipsMsg:@"数据错误！"];
        }
  
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self showTipsMsg:@"请求错误！"];
        NSLog(@"error = %@", request.error);
        
    }];
}

#pragma mark - 立即注册 提交接口
- (void)registerNewAccount
{
    RehisterApi *registerApi = [[RehisterApi alloc] initWithUseraccount:self.phone.text password:self.password.text userType:@"1" loginType:@"3"];
    [registerApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        if ([ABAConfig checkResponseObject:request.responseObject]) {
            NSString *body = [request.responseObject objectForKey:@"body"];
            if ([body containsString:@"注册成功"]) {
                [self showTipsMessageDelayPopBackWithMessage:@"注册成功"];
            }
        } else {
            [self showTipsMsg:@"注册失败"];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self showTipsMsg:@"注册失败"];
        NSLog(@"error = %@", request.error);
    }];
}

#pragma mark - 忘记密码 获取验证码接口
- (void)getVerificationCodeOfForgotPasswd
{
    ForgotPasswordApi *verCode = [[ForgotPasswordApi alloc] initWithForgotPasswordPhone:self.phone.text];
    [verCode startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {

        if ([ABAConfig checkResponseObject:request.responseObject]) {
            NSString * msg = [request.responseObject objectForKey:@"body"];
            if ([msg containsString:@"手机号码不存在"]) {
                [self showTipsMsg:@"手机号码不存在！"];
            } else {
                //初始化计时器
                [self initTimer];
            }
        }else {
            [self showTipsMsg:@"数据错误！"];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self showTipsMsg:@"请求错误！"];
        NSLog(@"error = %@", request.error);
    }];
}

#pragma mark - 修改密码 提交接口
- (void)updateNewPassword
{
    UpdatePasswordApi *update = [[UpdatePasswordApi alloc] initWithUseraccount:self.phone.text passwprd:self.password.text];
    [update startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        if ([ABAConfig checkResponseObject:request.responseObject]) {
            NSString *body = [request.responseObject objectForKey:@"body"];
            if ([body containsString:@"更新密码成功"]) {
                [self showTipsMessageDelayPopBackWithMessage:@"更新密码成功！"];
            }
        }else {
            [self showTipsMsg:@"修改失败"];
        }

    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self showTipsMsg:@"修改失败"];
        NSLog(@" error = %@", request.error);
    }];
}




#pragma mark - private method
// 获取验证码
- (IBAction)GetVerificationCodeAvtion:(UIButton *)sender {
    
    if ([self.phone.text isEqualToString:@""]) {
        [self showTipsMsg:@"请输入手机号"];
        return ;
    }
    
    if (self.phone.text.length != 11) {
        [self showTipsMsg:@"请输入正确的手机号"];
        return ;
    }
    
    if (self.choose == 1) {
        
        // 忘记密码  获取验证码
        [self getVerificationCodeOfForgotPasswd];
        
    } else if (self.choose == 2) {
        
        // 立即注册  获取验证码
        [self getVerificationCodeOfRegister];
        
    }
    
    
}

- (void)initTimer {
    [self.VerificationCodeButton setTitle:@"发送中..." forState:UIControlStateNormal];
    __weak typeof(self)WeakSelf = self;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:WeakSelf selector:@selector(downTime) userInfo:nil repeats:YES];
}


// 眼睛按钮 点击事件
- (IBAction)EyeAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    self.password.secureTextEntry = !self.password.secureTextEntry;
    
}

// 处理相应事件按钮
- (IBAction)SureAction:(id)sender {
    
    if ([self.phone.text isEqualToString:@""]) {
        [self showTipsMsg:@"请输入手机号"];
        return ;
    }
    
    if (self.phone.text.length != 11) {
        [self showTipsMsg:@"请输入正确的手机号"];
        return ;
    }
    
    if ([self.VerificationCode.text isEqualToString:@""]) {
        [self showTipsMsg:@"请输入验证码"];
        return ;
    }
    
    if ([self.password.text isEqualToString:@""]) {
        [self showTipsMsg:@"请输入密码"];
        return ;
    }

    if (self.choose == 1) {
        
        // 修改密码
        [self updateNewPassword];
        
    } else if (self.choose == 2) {
        
        // 立即注册
        [self registerNewAccount];
        
    }
}

- (void)downTime {
    
    if (downTime > 0) {
        downTime--;
        [self.VerificationCodeButton setTitle:[NSString stringWithFormat:@"%ds", downTime] forState:UIControlStateNormal];
        self.VerificationCodeButton.enabled = NO;
        
    } else {
        downTime = 60;
        [self.VerificationCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.VerificationCodeButton.enabled = YES;
        [self.timer invalidate];
        
    }
    
}

- (void)popBack
{
    [super popBack];
    [self.timer invalidate];
    self.timer = nil;
}

-(void)dealloc {
    NSLog(@"time = %d", downTime);
    NSLog(@"释放啦～");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
