//
//  LeftSideView.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/5.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "LeftSideView.h"

@interface LeftSideView ()

@property (nonatomic, copy) LeftSideHandle handle;

@end


@implementation LeftSideView

- (IBAction)functionAction:(UIButton *)sender {
    
    NSInteger tag = sender.tag - 3000;
    if (0 == tag) {
        
        if (self.handle) {
            self.handle(FunctionTypeMyVideo);
        }
        
    } else if (1 == tag) {
        
        if (self.handle) {
            self.handle(FunctionTypeHistoryRecord);
        }
        
    } else if (2 == tag) {
        
        if (self.handle) {
            self.handle(FunctionTypeAboutOurs);
        }
        
    } else {
        if (self.handle) {
            self.handle(FunctionTypeExit);
        }
    }
    
}


- (void)didSelectedSideFunction:(LeftSideHandle)handle {
    if (handle) {
        self.handle = handle;
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
