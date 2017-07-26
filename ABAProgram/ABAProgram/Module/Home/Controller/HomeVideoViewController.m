//
//  HomeVideoViewController.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/6.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "HomeVideoViewController.h"
#import "HomeDetailVideoHeaderView.h"
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

#import "ABAShareManager.h"
#import "PayChooseView.h"

#import "NSDate+Calender.h"

#import "XMLReader.h"

#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXPayApi.h"
#import "WXPayModel.h"

#import "ZFBPayApi.h"


#define WeiXinAppKey @"wx909f8c29eb7ddae2"

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
    VideoSectionType _Type; // Tab选项类型
    NSInteger _isBuy;       // 标志该视频是否付费 1--付费 0--未付费
}
@property (nonatomic, strong) UITableView * videoTableView;
@property (nonatomic, strong) HomeVideoSectionView * videoSectionView;
@property (nonatomic, strong) NSArray * dataSource;

@property (nonatomic, strong) ZFPlayerView *playerView;
@property (nonatomic, strong) VideoSendCommentView *sendCommentView;

@property (nonatomic, strong) UIButton * shelterBtnView;     //遮挡视频播放的btn，需要支付的时候出现
@property (nonatomic, strong) PayChooseView * payChooseView; //支付选择页面
@property (nonatomic, strong) HomeDetailVideoHeaderView *headerView;
@property (nonatomic, strong) UIView *backView;              //视频播放界面的父view
@property (nonatomic, strong) UIView * backGroundView;       //支付选择页面的父view

@end

@implementation HomeVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataSource = [NSArray array];
    _Type = VideoSectionTypeComment;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WeiXinPayResult:) name:@"WXpayResult" object:nil];
    
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
    
    // 设置视频View
    [self setupPlayView];
    
    // 发表评论的view
    self.sendCommentView = [[[NSBundle mainBundle] loadNibNamed:@"VideoSendCommentView" owner:self options:nil] lastObject];
    [self.sendCommentView setFrame:CGRectMake(0, ScreenH - 50, ScreenW, 50)];
    __weak typeof(self)WeakSelf = self;
    [self.sendCommentView didSelectedSendMessage:^(NSString *message) {
        
        if ([ABAConfig isEmptyOfString:message]) {
            [WeakSelf showTipsMsg:@"请输入正确的内容"];
            return ;
        }
        
        if ([ABAConfig isContainsTwoEmoji:message]) {
            [WeakSelf showTipsMsg:@"不能发送表情"];
            return;
        }
        [WeakSelf requestSendCommentWithMessage:message];
    }];
    [self.view addSubview:self.sendCommentView];
    
    // 数据请求
    [self RequestBrowHistory];
    [self requestPayRecord];
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
 
    [self showLoadingView:YES];
    VideoBrowNumberApi *browApi = [[VideoBrowNumberApi alloc] initWithBrowHistoryGoodsId:self.homePlayModel.liveId];[self showLoadingView:NO];    [browApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self showLoadingView:NO];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateBrowNumber" object:nil];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self showLoadingView:NO];
        
    }];
    
}

// 收费接口
- (void)requestPayRecord {
    VideoWatchRecordApi *recordApi = [[VideoWatchRecordApi alloc] initWithUserWatchRecordGoodsid:self.homePlayModel.liveId];
    
    [recordApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"redada = %@", request.responseObject);
        
        NSString *buy = request.responseObject[@"body"];
        _isBuy = [buy intValue];
        
        // 设置遮挡btnView
        if ([self.homePlayModel.price doubleValue] > 0 && _isBuy == 0) {
            self.shelterBtnView = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.shelterBtnView setFrame:self.backView.bounds];
            self.shelterBtnView.backgroundColor = [UIColor clearColor];
            [self.shelterBtnView addTarget:self action:@selector(ShelterBtnViewClickedAction) forControlEvents:UIControlEventTouchUpInside];
            [self.backView addSubview:self.shelterBtnView];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"error = %@", request.error);
    }];
}

// 评论列表数据
- (void)requestCommentData {
    
    VideoMessageApi * messageApi = [[VideoMessageApi alloc] initWithVideMessageLiveid:self.homePlayModel.liveId type:@"1"];
    [messageApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
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

// 微信请求数据
- (void)requestWeixinData {

    [self showLoadingView:YES];
    NSInteger p = [self.homePlayModel.price doubleValue]*100;
    NSString *price = [NSString stringWithFormat:@"%lu", (long)p];
    WXPayApi *wxApi = [[WXPayApi alloc] initWithGoodsid:self.homePlayModel.liveId isPre:@"1" totalPrice:price goodsname:@"Video"];
    [wxApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        [self showLoadingView:NO];
        
        NSString *xmlStr = request.responseObject[@"body"];
        NSError *error;
        NSDictionary *dic = [XMLReader dictionaryForXMLString:xmlStr error:&error];
        NSLog(@"dicdic = %@", dic);
        
        [self TuneUpWeiXinRequestWithWXPAyModel:[self setWXPayModel:dic[@"xml"]]];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        [self showLoadingView:NO];
        
        NSLog(@"error = %@", request.error);
    }];

    
}

// 支付宝请求数据
- (void)requestZFBData {
    
    [self showLoadingView:YES];

    ZFBPayApi *api = [[ZFBPayApi alloc] initWithGoodsid:self.homePlayModel.liveId isPre:@"1" totalPrice:self.homePlayModel.price goodsname:@"Video"];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        [self showLoadingView:NO];
        
        // 调起支付宝
        [self TuneUpZFBRequestWithOrderStr:request.responseObject[@"body"]];
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        [self showLoadingView:NO];
        NSLog(@"error = %@", request.error);
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


#pragma mark - 分享Action
- (void)rightButtonAction:(UIButton *)sender {
    //分享
    [self sharePlatform];
}



#pragma mark - CommentCellDelegate  评论点赞

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

#pragma mark - HomeVideSectionViewDelegate (切换Tab)

/**
 切换Tab

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

- (void)setupPlayView {
    [self showLoadingView:YES];
    dispatch_async(dispatch_get_global_queue(0, DISPATCH_QUEUE_PRIORITY_HIGH), ^{
       
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
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // 底层View
            self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW/5*3)];
            
            self.playerView = [[ZFPlayerView alloc] initWithFrame:self.backView.bounds];
            
            ZFPlayerControlView *controlView = [[ZFPlayerControlView alloc] init];

            playModel.fatherView = self.backView;
            [self.playerView playerControlView:controlView playerModel:playModel];
            [self.backView addSubview:self.playerView];
            
            [self.view addSubview:self.backView];
            [self showLoadingView:NO];
            
        });
    });
    
    
    
    

}

#pragma mark - 支付按钮

// 遮挡btn 被点击 需要支付
- (void)ShelterBtnViewClickedAction {

    // 支付BlackView
    self.backGroundView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.backGroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    // 支付View
    [self.payChooseView setFrame:CGRectMake((ScreenW-260)/2, (ScreenH-360)/2, 260, 360)];
    self.payChooseView.WxBtn.selected = YES;
    __weak typeof(self)WeakSelf = self;
    
    // 支付关闭按钮
    [self.payChooseView closePayView:^{
        [WeakSelf.backGroundView removeFromSuperview];
    }];
    
    // 支付按钮
    [self.payChooseView SurePay:^(NSInteger index) {
       
        if (1 == index) {
            
            // 微信
            [WeakSelf requestWeixinData];
            
        } else if (2 == index) {
            
            // 支付宝
            [WeakSelf requestZFBData];
            
        } else {
            
            [WeakSelf showTipsMsg:@"请选择支付方式"];
            
        }
        
        
    }];
    
    [self.backGroundView addSubview:self.payChooseView];
    [self.view addSubview:self.backGroundView];
    
}


#pragma mark - 调起微信支付
/**
 调起微信支付
 */
- (void)TuneUpWeiXinRequestWithWXPAyModel:(WXPayModel *)payModel {
    
    if ([WXApi isWXAppSupportApi]) {
        
        [WXApi registerApp:WeiXinAppKey enableMTA:YES];
        
        // 生成随机数
        NSString * nonceStr = [ABAConfig acrRandow];

        // 当前时间戳
        NSString * timestamp = [NSDate getCurrentTimestamp];
        
        // 生成sign签名partnerId
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:WeiXinAppKey forKey:@"appid"];
        [dic setObject:nonceStr forKey:@"noncestr"];
        [dic setObject:@(timestamp.intValue) forKey:@"timestamp"];
        [dic setObject:ABA_WX_Partnerid forKey:@"partnerid"];
        [dic setObject:payModel.prepayId?:@"0" forKey:@"prepayid"];
        [dic setObject:@"Sign=WXPay" forKey:@"package"];
        NSString * sign = [ABAConfig getSignFieldFromRequestDictionary:dic];
        
        
        PayReq *request = [[PayReq alloc] init];
        request.partnerId = ABA_WX_Partnerid;
        request.prepayId= payModel.prepayId;
        request.nonceStr= nonceStr;
        request.package = @"Sign=WXPay";
        request.timeStamp= timestamp.intValue;
        request.sign= sign;
        [WXApi sendReq:request];
        
        
        // 调起微信支付
//        PayReq *request = [[PayReq alloc] init];
//        request.partnerId = payModel.partnerId;
//        request.prepayId= payModel.prepayId;
//        request.nonceStr= payModel.nonceStr;
//        request.package = payModel.package;
//        request.timeStamp= payModel.timeStamp;
//        request.sign= payModel.sign;
//        [WXApi sendReq:request];

    } else {
        [self showTipsMsg:@"未安装微信或请升级微信版本"];
    }
   
}


#pragma mark - 调起 支付宝支付
- (void)TuneUpZFBRequestWithOrderStr:(NSString *)orderStr {
    if (orderStr != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"ali2017041406709494";
        
        __weak typeof(self)WeakSelf = self;
        
        // 调起支付宝
        [[AlipaySDK defaultService] payOrder:orderStr fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            

            // 支付成功。
            if ([resultDic[@"resultStatus"] intValue] == 9000) {
                [WeakSelf showTipsMsg:@"支付成功"];
                // 支付
                [WeakSelf PaySuccessHandle];
    
            } else {
                [WeakSelf showTipsMsg:resultDic[@"memo"]];
            }
        }];
    }
}


#pragma mark - 设置自定义 微信支付 model

- (WXPayModel *)setWXPayModel:(NSDictionary *)dic {
    WXPayModel *payModel = [[WXPayModel alloc] init];
    payModel.prepayId = dic[@"prepay_id"][@"text"];
    payModel.nonceStr = dic[@"nonce_str"][@"text"];
    payModel.partnerId = dic[@"mch_id"][@"text"];
    payModel.sign = dic[@"sign"][@"text"];
    payModel.package = @"Sign=WXPay";
    NSString *time = [NSDate getCurrentTimestamp];
    payModel.timeStamp = time.intValue;
    
    
    return payModel;
}

#pragma mark - 微信支付回调 通知
- (void)WeiXinPayResult:(NSNotification *)notification {
    NSDictionary *dic = notification.userInfo;
    if ([dic[@"errorCode"] intValue] == WXSuccess) {
        [self showTipsMsg:@"支付成功"];
        
        [self PaySuccessHandle];
    } else {
        [self showTipsMsg:@"支付失败"];
    }
}


#pragma mark - 支付成功后的处理

- (void)PaySuccessHandle {
    // 移除 视频遮挡button
    [self.shelterBtnView removeFromSuperview];
    
    // 移除支付选项页面
    [self.backGroundView removeFromSuperview];
}



#pragma mark - 分享
- (void)sharePlatform {
 
    [UMSocialUIManager setPreDefinePlatforms:@[@0,@1,@2,@4,@5]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        
        // 设置视频网络URL
        NSString *videoURL = self.homePlayModel.recordurl;
        if ([ABAConfig IsChinese:videoURL]) {
            videoURL = [videoURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }

        
        [ABAShareManager shareToPlatform:platformType title:self.homePlayModel.streamname content:self.homePlayModel.sysUserInfo.userbegood image:[UIImage imageNamed:@"ic_launcher"] url:videoURL presentedController:self complete:^(BOOL isSuccess, NSString *errorMsg) {
            if (isSuccess) {
                [self showTipsMsg:@"分享成功"];
            } else {
                [self showTipsMsg:errorMsg];
            }
            
        }];
    }];
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

- (PayChooseView *)payChooseView {
    if (!_payChooseView) {
        _payChooseView = [[[NSBundle mainBundle] loadNibNamed:@"PayChooseView" owner:self options:nil] lastObject];
        _payChooseView.layer.cornerRadius = 6;
        _payChooseView.layer.masksToBounds = YES;
        
    }
    return _payChooseView;
}

- (HomeDetailVideoHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[[NSBundle mainBundle] loadNibNamed:@"HomeDetailVideoHeaderView" owner:self options:nil] lastObject];
        _headerView.homePlayModel = self.homePlayModel;
        [_headerView setFrame:CGRectMake(0, 0, ScreenW, ScreenW/5*3)];
    }
    return _headerView;
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"WXpayResult" object:nil];
    NSLog(@"释放啦～～");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
