//
//  GoodDetailSectionView.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/4.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "GoodDetailSectionView.h"

@interface GoodDetailSectionView ()

@property (nonatomic, copy) ChooseDetailStyle detailStyle;
@property (weak, nonatomic) IBOutlet UIButton *goods;
@property (weak, nonatomic) IBOutlet UIButton *service;

@end



@implementation GoodDetailSectionView

- (void)setDetailModel:(GoodsDetailModel *)detailModel {
    _detailModel = detailModel;
    if (_detailModel) {
        if (_detailModel.detailStyle == DetailStyleOfGoods) {
            self.goods.selected = YES;
            self.service.selected = NO;
        } else {
            self.goods.selected = NO;
            self.service.selected = YES;
        }
    }
}


- (IBAction)chooseTabAction:(UIButton *)sender {
    
    NSInteger tag = sender.tag - 1000;
    if (tag == 1) {
        
        if (self.detailStyle) {
            self.detailStyle(DetailStyleOfGoods);
        }
        
    } else if (tag == 2) {
        
        if (self.detailStyle) {
            self.detailStyle(DetailStyleOfService);
        }
        
    }
    
    
}

- (void)didSelectedTab:(ChooseDetailStyle)style {
    if (style) {
        self.detailStyle = style;
    }
}

-(void)awakeFromNib {
    [super awakeFromNib];
    self.goods.selected = YES;
    self.service.selected = NO;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
