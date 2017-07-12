//
//  ParameterTableViewCell.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/5.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "ParameterTableViewCell.h"
#import "GoodsDetailModel.h"
@interface ParameterTableViewCell ()

@property (nonatomic, strong) UILabel *goodsParameter;

@end

@implementation ParameterTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self goodsParameter];
        
    }
    return self;
}


- (void)setParameterArr:(NSArray *)parameterArr {
    _parameterArr = parameterArr;
    
    for (UIView *view in self.contentView.subviews) {

        [view removeFromSuperview];
    }
    
    self.goodsParameter = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, 150, 20)];
    self.goodsParameter.text = @"商品参数";
    self.goodsParameter.font = [UIFont systemFontOfSize:13.0];
    self.goodsParameter.textColor = [UIColor themeDarkGrayColor];
    [self.contentView addSubview:self.goodsParameter];
    
    
    if (_parameterArr.count > 0) {
        
        CGFloat x = 2.0;
        CGFloat y = CGRectGetMaxY(self.goodsParameter.frame)+3;
        
        for (int i = 0; i < _parameterArr.count; i++) {
            
            if (i > 0 && i % 2 == 0) {
                x = 2.0;
                y += 25;
            }
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, ScreenW/2, 20)];
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = [UIColor themeBlackColor];
            label.font = [UIFont systemFontOfSize:12.0];
            label.numberOfLines = 0;
            detailuserGoodsAttrList *model = _parameterArr[i];
            label.text = [NSString stringWithFormat:@"%@ %@", model.attrname, model.attrvalue];
            [self.contentView addSubview:label];
            
            x+=(ScreenW/2);
            
        }
        
        
    }
}



+ (CGFloat)getHeightWithParameter:(NSArray *)paratemer {
    
    if (paratemer.count > 0) {
        
        NSInteger count =  paratemer.count;
        
        NSInteger a = count % 2;
        NSInteger b = count / 2;
        return 35+(a+b)*25;
    } else {
        return 35;
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
