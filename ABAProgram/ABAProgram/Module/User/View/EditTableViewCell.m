//
//  EditTableViewCell.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/22.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "EditTableViewCell.h"

@interface EditTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titlename;



@property (nonatomic, strong) NSIndexPath * indexpath;
@property (nonatomic, strong) UserLoginModel * userModel;
@end



@implementation EditTableViewCell

- (void)setUpInfoCell:(UserLoginModel *)userModel indexPath:(NSIndexPath *)indexPath {
    
    _userModel = userModel;
    _indexpath = indexPath;
    if (_userModel) {
        
        if (indexPath.section == 0) {
            
            if (indexPath.row == 0) {
                
                self.titlename.text = @"昵称";
                self.info.text = _userModel.username;
                
            } else if (indexPath.row == 1) {
                
                self.titlename.text = @"联系方式";
                self.info.text = _userModel.userphone;
                
            } else if (indexPath.row == 2) {
                
                self.titlename.text = @"关系";
                self.info.text = _userModel.userrelation;
                self.info.enabled = NO;
                
            }
            
        } else if (indexPath.section == 1) {
            
            if (indexPath.row == 0) {
                
                self.titlename.text = @"宝宝昵称";
                if ([_userModel.usersonname isEqualToString:@""]) {
                    self.info.text = @"宝宝";
                } else {
                    self.info.text = _userModel.usersonname;
                }
                
            } else if (indexPath.row == 1) {
                
                self.titlename.text = @"宝宝性别";
                self.info.enabled = NO;
                if ([_userModel.usergender intValue] == 0) {
                    self.info.text = @"王子";
                } else {
                    self.info.text = @"公主";
                }
                
            } else if (indexPath.row == 2) {
                
                self.titlename.text = @"宝宝年龄";
                self.info.enabled = NO;
                self.info.text = _userModel.userbirthday;
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
