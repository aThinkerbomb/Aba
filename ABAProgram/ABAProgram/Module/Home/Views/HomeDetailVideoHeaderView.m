//
//  HomeDetailVideoHeaderView.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/25.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "HomeDetailVideoHeaderView.h"
#import "ZFPlayer.h"
@interface HomeDetailVideoHeaderView ()
@property (weak, nonatomic) IBOutlet ZFPlayerView *playerView;

@end

@implementation HomeDetailVideoHeaderView


- (void)setHomePlayModel:(HomePlayModel *)homePlayModel {
    _homePlayModel = homePlayModel;
    if (_homePlayModel) {
        
        
        ZFPlayerControlView *controlView = [[ZFPlayerControlView alloc] init];
        
        ZFPlayerModel *playModel = [[ZFPlayerModel alloc] init];
        
        // 设置视频网络URL
        NSString *videoURL = self.homePlayModel.recordurl;
        if ([ABAConfig IsChinese:videoURL]) {
            videoURL = [videoURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
        playModel.videoURL = [NSURL URLWithString:videoURL];
        
        // 设置播放的封面图片，来源网络
        NSString *URLString = self.homePlayModel.bannerurl;
        if ([ABAConfig IsChinese:URLString]) {
            URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
        playModel.placeholderImageURLString = URLString;
        playModel.fatherView = self;
        [self.playerView playerControlView:controlView playerModel:playModel];
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
