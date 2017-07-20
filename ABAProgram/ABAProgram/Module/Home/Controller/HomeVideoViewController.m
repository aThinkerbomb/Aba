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
    VideoSectionType _Type;
}
@property (nonatomic, strong) UITableView * videoTableView;
@property (nonatomic, strong) HomeVideoSectionView * videoSectionView;
@property (nonatomic, strong) NSArray * dataSource;

@property (nonatomic, strong) ZFPlayerView *playerView;
@property (nonatomic, strong) VideoSendCommentView *sendCommentView;

@property (nonatomic, strong) UIButton * shelterBtnView;     //遮挡视频播放的btn，需要支付的时候出现
@property (nonatomic, strong) PayChooseView * payChooseView; //支付选择页面
@property (nonatomic, strong) UIView * backGroundView;       //支付选择页面的父view

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
    __weak typeof(self)WeakSelf = self;
    [self.sendCommentView didSelectedSendMessage:^(NSString *message) {
        [WeakSelf requestSendCommentWithMessage:message];
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

// 微信请求数据
- (void)requestWeixinData {

    [self showLoadingView:YES];
    NSInteger p = [self.homePlayModel.price doubleValue]*100;
    NSString *price = [NSString stringWithFormat:@"%lu", (long)p];
    WXPayApi *wxApi = [[WXPayApi alloc] initWithGoodsid:self.homePlayModel.liveId isPre:@"1" totalPrice:price goodsname:@"Video"];
    [wxApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        [self showLoadingView:NO];
        
        NSString *xmlStr = request.responseObject[@"body"];
        xmlStr = @"<xml><return_code><![CDATA[SUCCESS]]></return_code>\n<return_msg><![CDATA[OK]]></return_msg>\n<appid><![CDATA[wx909f8c29eb7ddae2]]></appid>\n<mch_id><![CDATA[1454243702]]></mch_id>\n<nonce_str><![CDATA[BMRyL9EGHr0T9g2o]]></nonce_str>\n<sign><![CDATA[08B91DAD9F863949A11609CF1C2CA8AC]]></sign>\n<result_code><![CDATA[SUCCESS]]></result_code>\n<prepay_id><![CDATA[wx20170720204837e1add99e120629090425]]></prepay_id>\n<trade_type><![CDATA[APP]]></trade_type>\n</xml>";
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

- (UIView *)setupPlayView {
    
    // 底层View
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW/5*3)];

    self.playerView = [[ZFPlayerView alloc] initWithFrame:backView.bounds];
    
    ZFPlayerControlView *controlView = [[ZFPlayerControlView alloc] init];
    
    ZFPlayerModel *playModel = [[ZFPlayerModel alloc] init];
    
    // 设置视频标题
//    playModel.title = self.homePlayModel.streamname; //标题不写了，展示的太难看，还需要改三方
    
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
    
    // 设置遮挡btnView
    if ([self.homePlayModel.price doubleValue] > 0) {
        self.shelterBtnView = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.shelterBtnView setFrame:backView.bounds];
        self.shelterBtnView.backgroundColor = [UIColor clearColor];
        [self.shelterBtnView addTarget:self action:@selector(ShelterBtnViewClickedAction) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:self.shelterBtnView];
    }
    
    
    return backView;

}

#pragma mark - 支付按钮

// 遮挡btn 被点击 需要支付
- (void)ShelterBtnViewClickedAction {

    // 支付BlackView
    self.backGroundView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.backGroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    // 支付View
    [self.payChooseView setFrame:CGRectMake((ScreenW-260)/2, (ScreenH-360)/2, 260, 360)];
    
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
        
//        // 生成随机数
//        NSString * nonceStr = [ABAConfig acrRandow];
//
//        // 当前时间戳
//        NSString * timestamp = [NSDate getCurrentTimestamp];
//        
//        // 生成sign签名partnerId
//        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//        [dic setObject:WeiXinAppKey forKey:@"appid"];
//        [dic setObject:nonceStr forKey:@"noncestr"];
//        [dic setObject:@(timestamp.intValue) forKey:@"timestamp"];
//        [dic setObject:ABA_WX_Partnerid forKey:@"partnerid"];
//        [dic setObject:payModel.prepayId forKey:@"prepayid"];
//        [dic setObject:@"Sign=WXPay" forKey:@"package"];
//        NSString * sign = [ABAConfig getSignFieldFromRequestDictionary:dic];
//        
//        
//        PayReq *request = [[PayReq alloc] init];
//        request.partnerId = ABA_WX_Partnerid;
//        request.prepayId= payModel.prepayId;
//        request.nonceStr= nonceStr;
//        request.package = @"Sign=WXPay";
//        request.timeStamp= timestamp.intValue;
//        request.sign= sign;
//        [WXApi sendReq:request];
//        
        
        // 调起微信支付
        PayReq *request = [[PayReq alloc] init];
        request.partnerId = payModel.partnerId;
        request.prepayId= payModel.prepayId;
        request.nonceStr= payModel.nonceStr;
        request.package = payModel.package;
        request.timeStamp= payModel.timeStamp;
        request.sign= payModel.sign;
        [WXApi sendReq:request];

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


#pragma mark - 支付成功后的处理

- (void)PaySuccessHandle {
    // 移除 视频遮挡button
    [self.shelterBtnView removeFromSuperview];
    
    // 移除支付选项页面
    [self.backGroundView removeFromSuperview];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Homereload" object:self];
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



- (void)dealloc {
    
    NSLog(@"释放啦～～");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
