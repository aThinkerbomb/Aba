//
//  UserHeaderView.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/21.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "UserHeaderView.h"

@interface UserHeaderView ()

@end


@implementation UserHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.headerImage.layer.cornerRadius = 50.0/2;
    self.headerImage.layer.masksToBounds = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
