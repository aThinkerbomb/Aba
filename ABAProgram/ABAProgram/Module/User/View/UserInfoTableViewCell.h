//
//  UserInfoTableViewCell.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/21.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserLoginModel.h"
@interface UserInfoTableViewCell : UITableViewCell

- (void)setUpInfoCell:(UserLoginModel *)userModel indexPath:(NSIndexPath *)indexPath;

@end
