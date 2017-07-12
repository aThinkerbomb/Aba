//
//  CommodityTableViewCell.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/10.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "CommodityTableViewCell.h"

@interface CommodityTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *number;

@end



@implementation CommodityTableViewCell

- (void)setBenefitModel:(BenefitModel *)benefitModel {
    _benefitModel = benefitModel;
    if (_benefitModel) {
        self.goodsName.text = _benefitModel.goodsname;
        self.price.text = [NSString stringWithFormat:@"¥%@", _benefitModel.newprice];
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
