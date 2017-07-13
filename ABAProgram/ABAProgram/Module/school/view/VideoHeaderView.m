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
@property (weak, nonatomic) IBOutlet UIView *playerFatherView;

@property (nonatomic, strong) ZFPlayerControlView *playerControlView;

@property (nonatomic, copy)VideoShare videoShare;

@end


@implementation VideoHeaderView

- (void)setVideoModel:(ExpertVideoModel *)videoModel {
    
    _videoModel = videoModel;
    if (_videoModel) {
        
        NSString *num = [NSString stringWithFormat:@"  %@次播放", _videoModel.videolooksum];
        [self.playNumbwe setTitle:num forState:UIControlStateNormal];
        
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
        playerModel.fatherView = self.playerFatherView;
        
        //用于重置新的播放。
        [self.playerView resetPlayer];
        
        [self.playerView playerControlView:self.playerControlView playerModel:playerModel];
        
    }
}


- (IBAction)shareaction:(UIButton *)sender {
    
    if (self.videoShare) {
        self.videoShare();
    }
    
}

- (void)ShareHandle:(VideoShare)share {
    if (share) {
        self.videoShare = share;
    }
}


- (ZFPlayerControlView *)playerControlView {
    if (!_playerControlView) {
        _playerControlView = [[ZFPlayerControlView alloc] init];
    }
    return _playerControlView;
}

- (void)pause {
    [self.playerView pause];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
