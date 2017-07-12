//
//  HomeVideoSectionView.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/6.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "HomeVideoSectionView.h"

@implementation HomeVideoSectionView


- (IBAction)SectionAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedSection:)]) {
        [self.delegate didSelectedSection:sender.tag - 5000];
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
