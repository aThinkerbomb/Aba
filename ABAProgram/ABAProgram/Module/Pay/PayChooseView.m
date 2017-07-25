//
//  PayChooseView.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/16.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "PayChooseView.h"

@interface PayChooseView ()

@property (weak, nonatomic) IBOutlet UILabel *price;

@property (weak, nonatomic) IBOutlet UIButton *PayBtn;

@property (nonatomic, copy) PayHandle payhandle;
@property (nonatomic, copy) CloseAction close;
@end

@implementation PayChooseView
{
    NSInteger _index;
}





- (IBAction)closeAction:(UIButton *)sender {
    
    if (self.close) {
        self.close();
    }
    
}
- (IBAction)PayAction:(UIButton *)sender {
    
    if (self.payhandle) {
        self.payhandle(_index);
    }
    
}

- (IBAction)ChooseWxPay:(UIButton *)sender {
    
    _index = 1;
    sender.selected = YES;
    self.zfbBtn.selected = NO;
    
}
- (IBAction)ChooseZfbPay:(UIButton *)sender {
    
    _index = 2;
    sender.selected = YES;
    self.WxBtn.selected = NO;
}

- (void)SurePay:(PayHandle)handle {
    if (handle) {
        self.payhandle = handle;
    }
}

- (void)closePayView:(CloseAction)close {
    if (close) {
        self.close = close;
    }
}




- (void)awakeFromNib {
    [super awakeFromNib];
    self.PayBtn.layer.cornerRadius = 6;
    self.PayBtn.layer.masksToBounds = YES;
    _index = 1;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
