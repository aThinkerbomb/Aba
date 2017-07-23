//
//  HistoryViewController.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/12.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "HistoryViewController.h"
#import "HistoryTableViewCell.h"
#import "HistoryWatchApi.h"
#import "HistoryModel.h"
#import "ZFPlayerView.h"

static NSString *historyCellIdentifier = @"HistoryTableViewCell";

@interface HistoryViewController ()<UITableViewDelegate, UITableViewDataSource, ZFPlayerDelegate>

@property (nonatomic, strong) UITableView *historyTableView;
@property (nonatomic, strong) NSArray * dataSource;
@property (nonatomic, strong) ZFPlayerView * playerView;

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"历史观看";
    
    self.dataSource = [NSArray array];
}

- (void)setupController {
    [super setupController];
    
    [self.historyTableView registerNib:[UINib nibWithNibName:@"HistoryTableViewCell" bundle:nil] forCellReuseIdentifier:historyCellIdentifier];
    
    [self requestHistoryData];
    
    self.historyTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestHistoryData)];
}

#pragma mark - 历史观看数据请求

- (void)requestHistoryData {
    
    [self showLoadingView:YES];
    HistoryWatchApi * historyApi = [[HistoryWatchApi alloc] initWithHistoryWatch];
    [historyApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self showLoadingView:NO];
        
        if ([ABAConfig checkResponseObject:request.responseObject]) {
            
            self.dataSource = [HistoryModel mj_objectArrayWithKeyValuesArray:request.responseObject[@"body"]];
            
            
            [self.historyTableView reloadData];
            
        }
        [self.historyTableView.mj_header endRefreshing];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self showLoadingView:NO];
    }];
    
}




#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:historyCellIdentifier forIndexPath:indexPath];
    [cell setHistoryModel:self.dataSource[indexPath.row]];
    return cell;
    
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self setupPlayViewWithUrl:self.dataSource[indexPath.row]];
    
}


#pragma mark - 视频播放

- (void)setupPlayViewWithUrl:(HistoryModel *)model {
    
    ZFPlayerControlView *controlView = [[ZFPlayerControlView alloc] init];
    [controlView setHiddenFullButton: YES];
    ZFPlayerModel *playModel = [[ZFPlayerModel alloc] init];
    
    // 设置视频网络URL
    NSString *videoURL = model.videopath;
    if ([ABAConfig IsChinese:videoURL]) {
        videoURL = [videoURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    playModel.videoURL = [NSURL URLWithString:videoURL];
    
    // 有userimg不用 非用这个字段，真特么没见过。。。狗血的数据 一个图片 搞这么繁琐的代码，真是够了
    NSInteger index = [model.filename length] - 4;
    NSString *imageName = [model.filename substringToIndex:index];
    NSString *urlstring = [[ABA_IMAGE stringByAppendingString:imageName] stringByAppendingString:@".jpg"];
    if ([ABAConfig IsChinese:urlstring]) {
        urlstring = [urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    
    playModel.placeholderImageURLString = urlstring;
    playModel.fatherView = self.view;
    
    [self.playerView playerControlView:controlView playerModel:playModel];
    [self.playerView _fullScreenAction];
}

#pragma mark - 视频播放返回按钮代理方法
- (void)zf_playerBackAction {
    
    [self.playerView pause];
    self.playerView.hidden = YES;
    self.playerView = nil;
    
}



#pragma mark - lazyLoading

- (UITableView *)historyTableView {
    if (!_historyTableView) {
        _historyTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-64) style:UITableViewStylePlain];
        _historyTableView.dataSource = self;
        _historyTableView.delegate = self;
        _historyTableView.rowHeight = 100;
        _historyTableView.tableFooterView = [UIView new];
        [self.view addSubview:_historyTableView];
    }
    return _historyTableView;
}

- (ZFPlayerView *)playerView {
    if (!_playerView) {
        _playerView = [[ZFPlayerView alloc]init];
        _playerView.delegate = self;
    }
    return _playerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
