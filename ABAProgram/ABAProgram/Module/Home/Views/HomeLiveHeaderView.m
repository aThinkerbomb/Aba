//
//  HomeLiveHeaderView.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/1.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "HomeLiveHeaderView.h"

@interface HomeLiveHeaderView ()

@property (weak, nonatomic) IBOutlet UIImageView *HeaderImage;
@property (weak, nonatomic) IBOutlet UIButton *PlayButton;
@property (weak, nonatomic) IBOutlet UIImageView *PlayImage;
@property (weak, nonatomic) IBOutlet UIButton *zwzbButton;


@end


@implementation HomeLiveHeaderView

- (void)setImageUrl:(NSString *)imageUrl
{
    _imageUrl = imageUrl;
    if ([ABAConfig IsChinese:_imageUrl]) {
        _imageUrl = [_imageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    
    [self.HeaderImage sd_setImageWithURL:[NSURL URLWithString:_imageUrl] placeholderImage:[UIImage imageNamed:@"placeholder"]];
}


- (IBAction)PlayAction:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(startPlayAction)]) {
        
        [self.delegate startPlayAction];
    }
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
