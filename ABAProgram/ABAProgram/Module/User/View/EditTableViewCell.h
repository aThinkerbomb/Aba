//
//  EditTableViewCell.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/22.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserLoginModel.h"
@interface EditTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *info;
- (void)setUpInfoCell:(UserLoginModel *)userModel indexPath:(NSIndexPath *)indexPath;

@end
