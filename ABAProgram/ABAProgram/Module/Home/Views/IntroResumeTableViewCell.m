//
//  IntroResumeTableViewCell.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/6.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "IntroResumeTableViewCell.h"

@interface IntroResumeTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *Resume;


@end


@implementation IntroResumeTableViewCell

- (void)setHomeModel:(HomePlayModel *)homeModel {
    _homeModel = homeModel;
    self.Resume.text = _homeModel.sysUserInfo.userresume;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
