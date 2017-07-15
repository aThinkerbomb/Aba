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
        
        // 有userimg不用 非用这个字段，真特么没见过。。。狗血的数据
        NSInteger index = [_videModel.filename length] - 4;
        NSString *imageName = [_videModel.filename substringToIndex:index];
        NSString *urlstring = [[ABA_IMAGE stringByAppendingString:imageName] stringByAppendingString:@".jpg"];
        if ([ABAConfig IsChinese:urlstring]) {
            urlstring = [urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
        [self.babyImage sd_setImageWithURL:[NSURL URLWithString:urlstring] placeholderImage:[UIImage imageNamed:@"placeholder"]];
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
