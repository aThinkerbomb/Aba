//
//  IntroPeopleTableViewCell.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/6.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "IntroPeopleTableViewCell.h"

@interface IntroPeopleTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *pName;
@property (weak, nonatomic) IBOutlet UILabel *perfession;

@end



@implementation IntroPeopleTableViewCell

- (void)setHomePlayModel:(HomePlayModel *)homePlayModel {
    _homePlayModel = homePlayModel;
    if (_homePlayModel) {
        [self.headerImage setImage:[UIImage imageNamed:@"headerImage"]];
        self.pName.text = _homePlayModel.sysUserInfo.username;
        self.perfession.text = _homePlayModel.sysUserInfo.userrank;
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
