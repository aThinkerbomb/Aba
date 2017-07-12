//
//  EditViewController.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/11.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "EditViewController.h"
#import "SubmitReceietAdressApi.h"


@interface EditViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextView *adress;
@property (weak, nonatomic) IBOutlet UILabel *placeholder;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"编辑地址";
    
    
}

- (void)setupController {
    [super setupController];
    
    self.submitBtn.layer.cornerRadius = 8;
    self.submitBtn.layer.masksToBounds = YES;
    
    if (self.adressModel) {
        
        self.name.text = self.adressModel.shipname;
        self.phone.text = self.adressModel.shipphone;
        self.adress.text = self.adressModel.shipaddress;
        
    }
    
    if (![self.adress.text isEqualToString:@""]) {
        self.placeholder.hidden = YES;
    }
    
    
//    self.adress.layer.cornerRadius = 4;
//    self.adress.layer.borderWidth = 0.5;
//    self.adress.layer.borderColor = kRGBColor(220, 220, 220).CGColor;
//    self.adress.layer.masksToBounds = YES;
}

#pragma mark - 提交信息 接口
- (void)requestSubmitInfo {
    
    [self showLoadingView:YES];
    SubmitReceietAdressApi *subApi = [[SubmitReceietAdressApi alloc] initWithShipName:self.name.text shipPhone:self.phone.text shipAdress:self.adress.text orderid:self.adressModel.recId];
    [subApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self showLoadingView:NO];
        
        if ([ABAConfig checkResponseObject:request.responseObject]) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reload" object:nil];

            [self showTipsMsg:@"提交成功" delayDo:^{
               
                [self popBack];
                
            }];
        }
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self showLoadingView:NO];
    }];
    
}


- (IBAction)submitAction:(UIButton *)sender {
    
    [self.name resignFirstResponder];
    [self.phone resignFirstResponder];
    [self.adress resignFirstResponder];
    
    if ([self.name.text isEqualToString:@""]) {
        [self showTipsMsg:@"请填写姓名"];
        return;
    }
    if ([self.phone.text isEqualToString:@""]) {
        [self showTipsMsg:@"请输入电话号码"];
        return;
    }
    
    if ([self.adress.text isEqualToString:@""]) {
        [self showTipsMsg:@"请输入收获地址"];
        return;
    }
    
    
    // 提交信息
    [self requestSubmitInfo];
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    if (textView.isFirstResponder) {
        self.placeholder.hidden = YES;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    if ([textView.text isEqualToString:@""]) {
        self.placeholder.hidden = NO;
    } else {
        self.placeholder.hidden = YES;
    }
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
