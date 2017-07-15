//
//  HistoryTableViewCell.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/12.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "HistoryTableViewCell.h"

@interface HistoryTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *historyTime;
@property (weak, nonatomic) IBOutlet UIImageView *videoImage;
@property (weak, nonatomic) IBOutlet UILabel *videoTitle;
@property (weak, nonatomic) IBOutlet UILabel *playNumber;

@end


@implementation HistoryTableViewCell

- (void)setHistoryModel:(HistoryModel *)historyModel {
    _historyModel = historyModel;
    if (_historyModel) {
        self.historyTime.text = [NSDate getDateFromDateString:_historyModel.creattime withDateFormatter:@"yyyy/MM/dd"];
        
        // image 烦人 狗血的图片数据
        NSInteger index = [_historyModel.filename length] - 4;
        NSString *imageName = [_historyModel.filename substringToIndex:index];
        NSString *urlstring = [[ABA_IMAGE stringByAppendingString:imageName] stringByAppendingString:@".jpg"];
        if ([ABAConfig IsChinese:urlstring]) {
            urlstring = [urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
        [self.videoImage sd_setImageWithURL:[NSURL URLWithString:urlstring] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
        self.videoTitle.text = _historyModel.videoname;
        self.playNumber.text = [NSString stringWithFormat:@"%@次播放", _historyModel.videolooksum];
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
