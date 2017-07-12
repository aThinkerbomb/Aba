//
//  BabyListTableViewCell.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/27.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BabyTeachModel.h"
@interface BabyListTableViewCell : UITableViewCell

- (void)startBuildBabyListCellWith:(BabyTeachModel *)babyModel;

@end
