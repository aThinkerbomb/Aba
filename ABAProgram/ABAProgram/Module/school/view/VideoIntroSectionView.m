//
//  VideoIntroSectionView.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/12.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "VideoIntroSectionView.h"

@interface VideoIntroSectionView ()

@property (nonatomic, copy) VideoIntroHandle videoIntro;

@end


@implementation VideoIntroSectionView

- (void)didClickedVideoIntro:(VideoIntroHandle)handle {
    if (handle) {
        self.videoIntro = handle;
    }
    
}

- (IBAction)didselectedaction:(UIButton *)sender {
    
    if (self.videoIntro) {
        self.videoIntro();
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
