//
//  HomeViewController.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/21.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "HomeViewController.h"
#import "HomePlayListApi.h"
#import "HomePlayModel.h"
#import "HomeListTableViewCell.h"
#import "HomeLiveHeaderView.h"

#import "HomeLiveApi.h"
#import "HomeVideoViewController.h"


// 已下为test
#import "MyVideoViewController.h"
#import "HistoryViewController.h"
#import "AboutOursViewController.h"

static NSString * homeTableViewCellIdentifier = @"HomeListTableViewCell";

@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource, HomeLiveHeaderViewDelegate>

@property (nonatomic, strong) NSArray *dataSourceArr;

@property (nonatomic, strong) UITableView *homeTableView;

@property (nonatomic, strong) HomeLiveHeaderView *liveHeaderView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"一天一播";
    self.dataSourceArr = [NSArray array];
    
    [self requestOnedayOnePlay];
    
    [self HomeLiveNow];

}

- (void)setupController
{
    [super setupController];
    
    NSString *imagerString = [KZUserDefaults objectForKey:@"userimg"];
    if ([imagerString isEqualToString:@""]) {
        UIImage *imager = [UIImage imageNamed:@"headerImage"];
        [self setNaviLeftItemNormalImage:imager HighlightedIamge:imager];
    } else {
        [self setNaviLeftItemNormalImage:imagerString HighlightedIamge:imagerString];
    }
    
    [self registerTableViewCell];
    
}

// 注册cell
- (void)registerTableViewCell {
    
    [self.homeTableView registerNib:[UINib nibWithNibName:@"HomeListTableViewCell" bundle:nil] forCellReuseIdentifier:homeTableViewCellIdentifier];
    
}


#pragma mark - 一天一播接口
- (void)requestOnedayOnePlay
{
    [self showLoadingView:YES];
    HomePlayListApi *playList = [[HomePlayListApi alloc] initWithOneDayOnePlay];
    [playList startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self showLoadingView:NO];
        
        if ([ABAConfig checkResponseObject:request.responseObject]) {
            
            // 转模型
            self.dataSourceArr = [HomePlayModel mj_objectArrayWithKeyValuesArray:[request.responseObject objectForKey:@"body"]];
            HomePlayModel *playModel = self.dataSourceArr[0];
            self.liveHeaderView.imageUrl = playModel.bannerurl;
            
            
            [self.homeTableView reloadData];
        } else {
                [self showTipsMsg:@"数据错误"];
        }
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self showLoadingView:NO];
        [self showTipsMsg:@"网络请求错误"];
    }];
}


#pragma mark - 首页直播接口

- (void)HomeLiveNow {
    
    [self showLoadingView:YES];
    
    HomeLiveApi *live = [[HomeLiveApi alloc] initWithHomeLive];
    [live startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        [self showLoadingView:NO];
        
        if ([ABAConfig checkResponseObject:request.responseObject]) {
            
        } else {
            
//            [self showTipsMsg:@"暂无直播"];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self showLoadingView:NO];
        [self showTipsMsg:@"直播网络请求失败"];
    }];
    
}



#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:homeTableViewCellIdentifier forIndexPath:indexPath];
    [cell startBuildHomeCellWith:self.dataSourceArr[indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArr.count;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeVideoViewController *videoVC = [[HomeVideoViewController alloc] init];
    videoVC.homePlayModel = self.dataSourceArr[indexPath.row];
    videoVC.hidesBottomBarWhenPushed = YES;
    [self pushToNextNavigationController:videoVC];
}



#pragma mark - HomeLiveHeaderViewDelegate
- (void)startPlayAction {
    [self showTipsMsg:@"暂无直播"];
}


#pragma mark - 头像点击方法

- (void)leftButtonAction:(UIButton *)sender
{
//    MyVideoViewController *myVideo = [[MyVideoViewController alloc] init];
//    myVideo.hidesBottomBarWhenPushed = YES;
//    [self pushToNextNavigationController:myVideo];
    
//    HistoryViewController *historyVC = [[HistoryViewController alloc] init];
//    historyVC.hidesBottomBarWhenPushed = YES;
//    [self pushToNextNavigationController:historyVC];
    
    AboutOursViewController *aboutVC = [[AboutOursViewController alloc] init];
    aboutVC.hidesBottomBarWhenPushed = YES;
    [self pushToNextNavigationController:aboutVC];
}

#pragma mark - lazyLoading

- (UITableView *)homeTableView
{
    if (!_homeTableView) {
        _homeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-64) style:UITableViewStylePlain];
        _homeTableView.dataSource = self;
        _homeTableView.delegate = self;
        _homeTableView.tableHeaderView = [self liveHeaderView];
        _homeTableView.tableFooterView = [UIView new];
        _homeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _homeTableView.rowHeight = 140;
        [self.view addSubview:_homeTableView];
    }
    return _homeTableView;
}


- (HomeLiveHeaderView *)liveHeaderView
{
    if (!_liveHeaderView) {
        _liveHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"HomeLiveHeaderView" owner:self options:nil] lastObject];
        _liveHeaderView.delegate = self;
        [_liveHeaderView setFrame:CGRectMake(0, 0, ScreenW, 220)];
    }
    
    return _liveHeaderView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
