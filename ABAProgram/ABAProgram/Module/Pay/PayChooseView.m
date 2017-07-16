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
@property (weak, nonatomic) IBOutlet UIButton *WxBtn;
@property (weak, nonatomic) IBOutlet UIButton *zfbBtn;


@end

@implementation PayChooseView
- (IBAction)closeAction:(UIButton *)sender {
    
}
- (IBAction)PayAction:(UIButton *)sender {
    
}

- (IBAction)ChooseWxPay:(UIButton *)sender {
    
    sender.selected = YES;
    self.zfbBtn.selected = NO;
    
}
- (IBAction)ChooseZfbPay:(UIButton *)sender {
    
    sender.selected = YES;
    self.WxBtn.selected = NO;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
