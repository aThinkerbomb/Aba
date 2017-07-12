//
//  IntroGoodAtTableViewCell.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/6.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "IntroGoodAtTableViewCell.h"

@interface IntroGoodAtTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *IntroGoodAt;

@end


@implementation IntroGoodAtTableViewCell


- (void)setHomePlayModel:(HomePlayModel *)homePlayModel {
    _homePlayModel = homePlayModel;
    if (_homePlayModel) {
        self.IntroGoodAt.text = _homePlayModel.sysUserInfo.userbegood;
    }
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
