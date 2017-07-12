//
//  BabyGoodDetailSectionView.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/1.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "BabyGoodDetailSectionView.h"

@interface BabyGoodDetailSectionView ()

@property (weak, nonatomic) IBOutlet UIImageView *babyImage;
@property (weak, nonatomic) IBOutlet UILabel *babyTitle;


@end


@implementation BabyGoodDetailSectionView


- (void)setVideModel:(VideoIntroductionModel *)videModel {
    
    _videModel = videModel;
    
    if (![ABAConfig isEmptyOfObj:_videModel]) {
        NSString *imageStr = _videModel.userimg;
        if ([ABAConfig IsChinese:imageStr]) {
            imageStr = [imageStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
        
        [self.babyImage sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    }
    
    self.babyTitle.text = _videModel.videoname;
}


- (IBAction)SectionViewAction:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedSection:)]) {
        [self.delegate didSelectedSection:self.section];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
