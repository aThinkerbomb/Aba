//
//  PriceInfoTableViewCell.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/10.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BenefitModel.h"

@interface PriceInfoTableViewCell : UITableViewCell

- (void)setUpCellWithModel:(BenefitModel *)benefitModel indexPath:(NSIndexPath *)indexPath;

@end
