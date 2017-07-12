//
//  PriceInfoTableViewCell.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/10.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "PriceInfoTableViewCell.h"

@interface PriceInfoTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *des;
@property (weak, nonatomic) IBOutlet UILabel *entity;

@property (nonatomic, strong) BenefitModel * benefitModel;

@end


@implementation PriceInfoTableViewCell

- (void)setUpCellWithModel:(BenefitModel *)benefitModel indexPath:(NSIndexPath *)indexPath {
    _benefitModel = benefitModel;
    if (indexPath.row == 0) {
        self.des.text = @"商品合计";
        
        if (_benefitModel) {
            self.entity.text = [NSString stringWithFormat:@"¥%@", _benefitModel.newprice];
        }
    }
    if (indexPath.row == 1) {
        self.des.text = @"运费";
        self.entity.text = @"免运费";
    }
    if (indexPath.row == 2) {
        self.des.text = @"应付";
        if (_benefitModel) {
            self.entity.text = [NSString stringWithFormat:@"¥%@", _benefitModel.newprice];
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
