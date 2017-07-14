//
//  AbaAlertView.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/14.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "AbaAlertView.h"

@implementation AbaAlertView


- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated {
    if (buttonIndex == 0) {
        [super dismissWithClickedButtonIndex:buttonIndex animated:animated];
    } else {
        if (self.phone.length == 11) {
            [super dismissWithClickedButtonIndex:buttonIndex animated:animated];
        }
        return;
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
