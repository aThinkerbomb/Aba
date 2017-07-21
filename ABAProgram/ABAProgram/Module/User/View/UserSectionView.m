//
//  UserSectionView.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/21.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "UserSectionView.h"

@interface UserSectionView ()

@property (weak, nonatomic) IBOutlet UIView *icon;

@end


@implementation UserSectionView


- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.icon.layer.cornerRadius = 6;
    self.icon.layer.masksToBounds = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
