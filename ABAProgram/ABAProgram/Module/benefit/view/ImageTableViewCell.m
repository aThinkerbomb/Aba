//
//  ImageTableViewCell.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/3.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "ImageTableViewCell.h"

@interface ImageTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *detailImage;

@end

@implementation ImageTableViewCell


- (void)setImageString:(NSString *)imageString {
    _imageString = imageString;
    if (_imageString) {
        
        if ([ABAConfig IsChinese:_imageString]) {
            _imageString = [_imageString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
        
        [self.detailImage sd_setImageWithURL:[NSURL URLWithString:_imageString] placeholderImage:[UIImage imageNamed:@"placeholder"]];
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
