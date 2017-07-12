//
//  BabySchoolInfoSectionView.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/2.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "BabySchoolInfoSectionView.h"

@interface BabySchoolInfoSectionView ()


@end


@implementation BabySchoolInfoSectionView

- (IBAction)showInfoAction:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectionIntroduction)]) {
        
        
        self.introductionModel.open = !self.introductionModel.open;
        
        
        [self.delegate didSelectionIntroduction];
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
