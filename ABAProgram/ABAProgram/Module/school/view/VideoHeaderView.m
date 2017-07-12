//
//  VideoHeaderView.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/12.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "VideoHeaderView.h"
#import "ZFPlayerView.h"
@interface VideoHeaderView ()

@property (strong, nonatomic) IBOutlet ZFPlayerView *playerView;
@property (weak, nonatomic) IBOutlet UIButton *playNumbwe;

@property (nonatomic, strong) ZFPlayerControlView *playerControlView;
@end


@implementation VideoHeaderView

- (void)setVideoModel:(ExpertVideoModel *)videoModel {
    
    _videoModel = videoModel;
    if (_videoModel) {
        ZFPlayerModel * playerModel = [[ZFPlayerModel alloc] init];
        playerModel.title = _videoModel.videoname;
        
        NSString *videoPath = _videoModel.videopath;
        if ([ABAConfig IsChinese:videoPath]) {
            videoPath = [videoPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
        
        playerModel.videoURL = [NSURL URLWithString:videoPath];
        
        // image 烦人
        NSInteger index = [_videoModel.filename length] - 4;
        NSString *imageName = [_videoModel.filename substringToIndex:index];
        NSString *urlstring = [[ABA_IMAGE stringByAppendingString:imageName] stringByAppendingString:@".jpg"];
        if ([ABAConfig IsChinese:urlstring]) {
            urlstring = [urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
        playerModel.placeholderImageURLString = urlstring;
        playerModel.fatherView = self;
        
        [self.playerView playerControlView:self.playerControlView playerModel:playerModel];
        
    }
}


- (IBAction)shareaction:(UIButton *)sender {
}


- (ZFPlayerControlView *)playerControlView {
    if (!_playerControlView) {
        _playerControlView = [[ZFPlayerControlView alloc] init];
    }
    return _playerControlView;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
