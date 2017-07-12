//
//  AdressTableViewCell.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/10.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "AdressTableViewCell.h"

@interface AdressTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *contant;
@property (weak, nonatomic) IBOutlet UILabel *adress;


@end

@implementation AdressTableViewCell

- (void)setAdressModel:(GetReceiptAdressModel *)adressModel {
    _adressModel = adressModel;
    
    if (_adressModel) {
        
        self.contant.text = [NSString stringWithFormat:@"%@    %@", _adressModel.shipname, _adressModel.shipphone];
        self.adress.text = _adressModel.shipaddress;
        self.contant.textColor = kRGBColor(53, 53, 53);
        self.adress.hidden = NO;
        
    } else {
        self.adress.hidden = YES;
    }
}


- (IBAction)AddAdressAction:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(addAdressAction)]) {
        [self.delegate addAdressAction];
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
