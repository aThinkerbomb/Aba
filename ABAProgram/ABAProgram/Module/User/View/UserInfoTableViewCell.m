//
//  UserInfoTableViewCell.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/21.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "UserInfoTableViewCell.h"

@interface UserInfoTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (weak, nonatomic) IBOutlet UILabel *userInfo;


@property (nonatomic, strong) NSIndexPath * indexpath;
@property (nonatomic, strong) UserLoginModel * userModel;
@end

@implementation UserInfoTableViewCell

- (void)setUpInfoCell:(UserLoginModel *)userModel indexPath:(NSIndexPath *)indexPath {
    
    _userModel = userModel;
    _indexpath = indexPath;
    if (_userModel) {
        
        if (indexPath.section == 0) {
            
            if (indexPath.row == 0) {
                
                self.titleName.text = @"昵称";
                self.userInfo.text = _userModel.username;
                
            } else if (indexPath.row == 1) {
                
                self.titleName.text = @"联系方式";
                self.userInfo.text = _userModel.userphone;
                
            } else if (indexPath.row == 2) {
                
                self.titleName.text = @"关系";
                self.userInfo.text = _userModel.userrelation;
            }
            
        } else if (indexPath.section == 1) {
            
            if (indexPath.row == 0) {
                
                self.titleName.text = @"宝宝昵称";
                if ([_userModel.usersonname isEqualToString:@""]) {
                    self.userInfo.text = @"宝宝";
                } else {
                    self.userInfo.text = _userModel.usersonname;
                }

            } else if (indexPath.row == 1) {
                
                self.titleName.text = @"宝宝昵称";
                if ([_userModel.usergender intValue] == 0) {
                    self.userInfo.text = @"王子";
                } else {
                    self.userInfo.text = @"公主";
                }
                
            } else if (indexPath.row == 2) {
                
                self.titleName.text = @"宝宝生日";
                self.userInfo.text = _userModel.userbirthday;
            }
        }
        
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
