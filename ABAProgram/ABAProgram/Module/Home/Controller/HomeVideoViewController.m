//
//  HomeVideoViewController.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/6.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "HomeVideoViewController.h"
#import "HomeVideoSectionView.h"
#import "CommentTableViewCell.h"
#import "IntroPeopleTableViewCell.h"
#import "IntroResumeTableViewCell.h"
#import "IntroGoodAtTableViewCell.h"

#import "VideoBrowNumberApi.h"
#import "VideoWatchRecordApi.h"
#import "VideoMessageApi.h"

#import "videoCommentModel.h"

#import "ZFPlayerView.h"
#import "CommentZanApi.h"

#import "VideoSendCommentView.h"
#import "VideoSendCommendApi.h"

static NSString * commentCellIdentifier       = @"CommentTableViewCell";
static NSString * introPeopleCellIdentifier   = @"IntroPeopleTableViewCell";
static NSString * introResumentCellIdentifier = @"IntroResumeTableViewCell";
static NSString * introGoodAtCellIdentifier   = @"IntroGoodAtTableViewCell";


typedef NS_ENUM(NSInteger, VideoSectionType) {
    VideoSectionTypeComment = 1,
    VideoSectionTypeIntroduction
};


@interface HomeVideoViewController ()<UITableViewDelegate, UITableViewDataSource, CommentCellDelegate, HomeVideSectionViewDelegate>
{
    VideoSectionType _Type;
}
@property (nonatomic, strong) UITableView * videoTableView;
@property (nonatomic, strong) HomeVideoSectionView * videoSectionView;
@property (nonatomic, strong) NSArray * dataSource;

@property (nonatomic, strong) ZFPlayerView *playerView;
@property (nonatomic, strong) VideoSendCommentView *sendCommentView;

@end

@implementation HomeVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataSource = [NSArray array];
    _Type = VideoSectionTypeComment;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = YES;
    UIImage *image = [UIImage imageWithColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.clipsToBounds = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor themeColor]] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.clipsToBounds = NO;
    self.automaticallyAdjustsScrollViewInsets = YES;
}

- (void)setupController {
    [super setupController];
    
    // 设置右侧按钮
    [self setNaviRightItemNormalImage:[UIImage imageNamed:@"nav_button_share"] HighlightedIamge:[UIImage imageNamed:@"nav_button_share"]];
    
    // 注册cell
    [self registerTableViewCell];
    
    // 视频
    [self.view addSubview:[self setupPlayView]];;
    
    
    
    // 发表评论的view
    self.sendCommentView = [[[NSBundle mainBundle] loadNibNamed:@"VideoSendCommentView" owner:self options:nil] lastObject];
    [self.sendCommentView setFrame:CGRectMake(0, ScreenH - 50, ScreenW, 50)];
    [self.sendCommentView didSelectedSendMessage:^(NSString *message) {
        [self requestSendCommentWithMessage:message];
    }];
    [self.view addSubview:self.sendCommentView];
    
    // 数据请求
    [self RequestBrowHistory];
    [self requestWatchRecord];
    [self requestCommentData];
    
}


- (void)registerTableViewCell {
    [self.videoTableView registerNib:[UINib nibWithNibName:@"IntroPeopleTableViewCell" bundle:nil] forCellReuseIdentifier:introPeopleCellIdentifier];
    [self.videoTableView registerNib:[UINib nibWithNibName:@"IntroResumeTableViewCell" bundle:nil] forCellReuseIdentifier:introResumentCellIdentifier];
    [self.videoTableView registerNib:[UINib nibWithNibName:@"IntroGoodAtTableViewCell" bundle:nil] forCellReuseIdentifier:introGoodAtCellIdentifier];
    [self.videoTableView registerNib:[UINib nibWithNibName:@"CommentTableViewCell" bundle:nil] forCellReuseIdentifier:commentCellIdentifier];
}

#pragma mark - 数据请求
// 更新浏览数
- (void)RequestBrowHistory {
 
    VideoBrowNumberApi *browApi = [[VideoBrowNumberApi alloc] initWithBrowHistoryGoodsId:self.homePlayModel.liveId];
    [browApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        NSLog(@"redada = %@", request.responseObject);
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"error = %@", request.error);
    }];
    
}

// 观看记录
- (void)requestWatchRecord {
    VideoWatchRecordApi *recordApi = [[VideoWatchRecordApi alloc] initWithUserWatchRecordGoodsid:self.homePlayModel.liveId];
    
    [recordApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"redada = %@", request.responseObject);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"error = %@", request.error);
    }];
}

// 评论列表数据
- (void)requestCommentData {
    
    [self showLoadingView:YES];
    VideoMessageApi * messageApi = [[VideoMessageApi alloc] initWithVideMessageLiveid:self.homePlayModel.liveId type:@"1"];
    [messageApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        [self showLoadingView:NO];
        
        if ([ABAConfig checkResponseObject:request.responseObject]) {
            
            self.dataSource = [videoCommentModel mj_objectArrayWithKeyValuesArray:request.responseObject[@"body"]];
            
            for (videoCommentModel *commentModel in self.dataSource) {
                
                CGSize size = [commentModel.content sizeWithFont:[UIFont systemFontOfSize:14.0] maxSize:CGSizeMake(ScreenW - 71, MAXFLOAT)];
                
                CGFloat height = 53 + size.height + 10;
                commentModel.height = height;
                
            }
            
            [self.videoTableView reloadData];
            
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"error = %@", request.error);
        [self showLoadingView:NO];
    }];
    
}

// 发表评论
- (void)requestSendCommentWithMessage:(NSString *)message {
    VideoSendCommendApi * sendCommentApi = [[VideoSendCommendApi alloc] initWithSendCommentLiveid:self.homePlayModel.liveId type:@"1" content:message];
    [sendCommentApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if ([ABAConfig checkResponseObject:request.responseObject]) {
            
            [self showTipsMsg:request.responseObject[@"body"]];
            
            // 重新刷新评论数据列表
            [self requestCommentData];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (_Type == VideoSectionTypeComment) {
        
        return self.dataSource.count;
        
    } else {
        
        return 3;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_Type == VideoSectionTypeComment) {
        
        CommentTableViewCell *commentCell = [tableView dequeueReusableCellWithIdentifier:commentCellIdentifier forIndexPath:indexPath];
        commentCell.delegate = self;
        commentCell.row = indexPath.row;
        [commentCell setupCommentCellWithCommentModel:self.dataSource[indexPath.row]];
        return commentCell;
    
    } else {
        
        if (indexPath.row == 0) {
            IntroPeopleTableViewCell *introPeopleCell = [tableView dequeueReusableCellWithIdentifier:introPeopleCellIdentifier forIndexPath:indexPath];
            introPeopleCell.homePlayModel = self.homePlayModel;
            return introPeopleCell;
        } else if (indexPath.row == 1) {
            IntroResumeTableViewCell *introResumeCell = [tableView dequeueReusableCellWithIdentifier:introResumentCellIdentifier forIndexPath:indexPath];
            introResumeCell.homeModel = self.homePlayModel;
            return introResumeCell;
        } else {
            IntroGoodAtTableViewCell *intoGoodAtCell = [tableView dequeueReusableCellWithIdentifier:introGoodAtCellIdentifier forIndexPath:indexPath];
            intoGoodAtCell.homePlayModel = self.homePlayModel;
            return intoGoodAtCell;
        }
        
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_Type == VideoSectionTypeComment) {

        videoCommentModel * videoCommentModel = self.dataSource[indexPath.row];
        return videoCommentModel.height;
    } else {
        
        if (indexPath.row == 0) {
            return 80;
        } else if (indexPath.row == 1) {
            return 170;
        } else {
            return 130;
        }
        
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    self.videoSectionView = [[[NSBundle mainBundle] loadNibNamed:@"HomeVideoSectionView" owner:self options:nil] lastObject];
    self.videoSectionView.delegate = self;
    if (_Type == VideoSectionTypeComment) {
        self.videoSectionView.CommentBtn.selected = YES;
        self.videoSectionView.IntroBtn.selected = NO;
    } else if (_Type == VideoSectionTypeIntroduction) {
        self.videoSectionView.CommentBtn.selected = NO;
        self.videoSectionView.IntroBtn.selected = YES;
    }
    
    return self.videoSectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}


- (void)rightButtonAction:(UIButton *)sender {
    // 分享
}

#pragma mark - CommentCellDelegate

- (void)didSelectedZan:(NSInteger)index {
    
    videoCommentModel *commentModel = self.dataSource[index];
    
    CommentZanApi *zanApi = [[CommentZanApi alloc] initWithMesId:commentModel.mesId];
    [zanApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        [self showTipsMsg:request.responseObject[@"body"]];
        
        // 重新刷新评论数据
        [self requestCommentData];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
    
}

#pragma mark - HomeVideSectionViewDelegate

/**
 Section 点击事件

 @param sectionIndex 1--留言  2--介绍
 */
- (void)didSelectedSection:(NSInteger)sectionIndex {
    
    if (sectionIndex == 1) {
        _Type = VideoSectionTypeComment;
        [self.videoTableView reloadData];
        self.sendCommentView.hidden = NO;
        
    } else if (sectionIndex == 2) {
        _Type = VideoSectionTypeIntroduction;
        [self.videoTableView reloadData];
        self.sendCommentView.hidden = YES;
    }
    
}



#pragma mark - 设置播放器界面

- (UIView *)setupPlayView {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW/5*3)];

    self.playerView = [[ZFPlayerView alloc] initWithFrame:backView.bounds];
    
    ZFPlayerControlView *controlView = [[ZFPlayerControlView alloc] init];
    
    ZFPlayerModel *playModel = [[ZFPlayerModel alloc] init];
    
    // 设置视频标题
    playModel.title = self.homePlayModel.streamname;
    
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
    
    playModel.fatherView = backView;
    [self.playerView playerControlView:controlView playerModel:playModel];
    
    [backView addSubview:self.playerView];
    
    return backView;

}



#pragma mark - lazyLoading
- (UITableView *)videoTableView {
    if (!_videoTableView) {
        _videoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, ScreenW/5*3, ScreenW, ScreenH-50-ScreenW/5*3) style:UITableViewStylePlain];
        _videoTableView.delegate = self;
        _videoTableView.dataSource = self;
        _videoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_videoTableView];
    }
    return _videoTableView;
}

- (void)popBack {
    [super popBack];
    [self.playerView pause];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
