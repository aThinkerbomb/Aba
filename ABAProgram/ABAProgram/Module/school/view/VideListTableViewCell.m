
//
//  VideListTableViewCell.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/12.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "VideListTableViewCell.h"

@interface VideListTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *videoImage;
@property (weak, nonatomic) IBOutlet UILabel *videoTitle;
@property (weak, nonatomic) IBOutlet UILabel *playNumber;

@end



@implementation VideListTableViewCell


- (void)setVideoModel:(ExpertVideoModel *)videoModel {
    _videoModel = videoModel;
    if (_videoModel) {
        
        // 狗血的图片数据。。。
        NSInteger index = [_videoModel.filename length] - 4;
        NSString *imageName = [_videoModel.filename substringToIndex:index];
        NSString *urlstring = [[ABA_IMAGE stringByAppendingString:imageName] stringByAppendingString:@".jpg"];
        
        if ([ABAConfig IsChinese:urlstring]) {
            urlstring = [urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
        
        [self.videoImage sd_setImageWithURL:[NSURL URLWithString:urlstring] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        self.videoTitle.text = _videoModel.videoname;
        self.playNumber.text = [NSString stringWithFormat:@"%@次播放", _videoModel.videolooksum];
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
