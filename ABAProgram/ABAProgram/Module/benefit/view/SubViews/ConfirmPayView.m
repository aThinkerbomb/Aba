//
//  ConfirmPayView.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/11.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "ConfirmPayView.h"


@interface ConfirmPayView ()

@property (weak, nonatomic) IBOutlet UILabel *newaPrice;
@property (weak, nonatomic) IBOutlet UILabel *oldPrice;


@end


@implementation ConfirmPayView
- (IBAction)ConfirmPayAction:(UIButton *)sender {
    
    if (self.delegaet && [self.delegaet respondsToSelector:@selector(confirmPayAction)]) {
        [self.delegaet confirmPayAction];
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
