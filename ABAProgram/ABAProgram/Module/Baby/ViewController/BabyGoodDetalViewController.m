//
//  BabyGoodDetalViewController.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/1.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "BabyGoodDetalViewController.h"
#import "BabyGoodDetailSectionView.h"
#import "BabySchoolInfoSectionView.h"
#import "BabyGoodTeachHeaderView.h"

#import "BabyIntroductionApi.h"
#import "BabyVieoIntroductionApi.h"
#import "IntroductionModel.h"
#import "VideoIntroductionModel.h"

#import "ZFPlayerView.h"

static NSString *TableViewCellIdentifier = @"UITableViewCell";

@interface BabyGoodDetalViewController ()<UITableViewDelegate, UITableViewDataSource, GoodDetailSectionViewDelegate, SchoolInfoSectionViewDelegate, ZFPlayerDelegate>

@property (nonatomic, strong) UITableView *teachTableView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) BabyGoodDetailSectionView *detailSectionView;
@property (nonatomic, strong) BabySchoolInfoSectionView *infoSectionView;
@property (nonatomic, strong) BabyGoodTeachHeaderView *teachHeaderView;
@property (nonatomic, strong) IntroductionModel * baseIntroMode;

@property (nonatomic, strong) ZFPlayerView * playerView;
@end

@implementation BabyGoodDetalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataSource = [NSArray array];
    
    if (self.style == GoodChooseStyleTeach) {
        self.title = @"优教";
    } else {
        self.title = @"优班";
    }
    
    
    // 数据请求
    [self requestBaseInfoData];
    [self requestVideoInfoData];
    
}


- (void)setupController
{
    [super setupController];
    
    // 注册cell
    [self.teachTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:TableViewCellIdentifier];
    
    // 导入 下拉刷新
    self.teachTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestVideoInfoData)];
}


#pragma mark - 数据请求

- (void)requestBaseInfoData {
    
    [self showLoadingView:YES];
    BabyIntroductionApi *introductionApi = [[BabyIntroductionApi alloc] initWithIntroductionid:self.institutionId];
    [introductionApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        [self showLoadingView:NO];
        if ([ABAConfig checkResponseObject:request.responseObject]) {
            
            self.baseIntroMode = [IntroductionModel mj_objectWithKeyValues:request.responseObject[@"body"]];
            
            // 计算高度
       
            CGSize size = [self.baseIntroMode.topiccontent sizeWithFont:[UIFont systemFontOfSize:12.0] maxSize:CGSizeMake(ScreenW - 40, MAXFLOAT)];
            self.baseIntroMode.height = size.height+10;
            self.baseIntroMode.open = NO;

            // 设置model
            self.teachHeaderView.introModel = self.baseIntroMode;
            NSArray *imageArr = [self.baseIntroMode.profilepicture componentsSeparatedByString:@"|"];
            self.teachHeaderView.imageArr = imageArr;
            
            
            [self.teachTableView reloadData];
            
            
        } else {
//            [self showTipsMsg:@"数据错误"];
        }

    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self showLoadingView:NO];
        [self showTipsMsg:@"网络请求错误"];
    }];
    
}

- (void)requestVideoInfoData {
    
    [self showLoadingView:YES];
    BabyVieoIntroductionApi *videoApi = [[BabyVieoIntroductionApi alloc] initWithInstitutionid:self.institutionId];
    [videoApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        [self showLoadingView:NO];
        
        if ([ABAConfig checkResponseObject:request.responseObject]) {
            
            self.dataSource = [VideoIntroductionModel mj_objectArrayWithKeyValuesArray:request.responseObject[@"body"]];
            
            
            [self.teachTableView reloadData];
            
            
        } else {
            
//            [self showTipsMsg:@"数据错误"];
        }
        [self.teachTableView.mj_header endRefreshing];
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self showLoadingView:YES];
        [self showTipsMsg:@"网络请求错误"];
    }];
}



#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (self.dataSource.count <= 0) {
        return 1;
    }
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableViewCellIdentifier forIndexPath:indexPath];

    if (self.baseIntroMode.open) {
        cell.textLabel.text = [NSString stringWithFormat:@"        %@", self.baseIntroMode.topiccontent];
    } else {
        cell.textLabel.text = @"";
    }
    cell.textLabel.font = [UIFont systemFontOfSize:12.0];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.textColor = kRGBColor(100, 100, 100);

    return cell;
    
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        if (self.baseIntroMode.open) {
            return self.baseIntroMode.height;
        }
        return 0.001;
        
    } else {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        self.infoSectionView = [[[NSBundle mainBundle] loadNibNamed:@"BabySchoolInfoSectionView" owner:self options:nil] lastObject];
        self.infoSectionView.delegate = self;
        self.infoSectionView.introductionModel = self.baseIntroMode;
        if (self.baseIntroMode.open) {
            
            [self.infoSectionView.JTImage setImage:[UIImage imageNamed:@"jiantoushang"]];
        } else {
            [self.infoSectionView.JTImage setImage:[UIImage imageNamed:@"jiantouxia"]];
        }
        return self.infoSectionView;
        
    }
    
    self.detailSectionView = [[[NSBundle mainBundle] loadNibNamed:@"BabyGoodDetailSectionView" owner:self options:nil] lastObject];
    self.detailSectionView.delegate = self;
    self.detailSectionView.section = section;
    self.detailSectionView.videModel = self.dataSource[section];
    return self.detailSectionView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return 40;
    }
    
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}


#pragma mark - 视频播放

- (void)setupPlayViewWithModel:(VideoIntroductionModel *)model {
    
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

#pragma mark - GoodDetailSectionViewDelegate

- (void)didSelectedSection:(NSInteger)section {
    
    NSLog(@"%lu", section);
    
    VideoIntroductionModel *VideoModel = self.dataSource[section];
    [self setupPlayViewWithModel:VideoModel];
}


#pragma mark - SchoolInfoSectionViewDelegate

- (void)didSelectionIntroduction {
    
    NSIndexSet *indeSet = [[NSIndexSet alloc] initWithIndex:0];
    [self.teachTableView reloadSections:indeSet withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

#pragma mark - lazyLoading

- (UITableView *)teachTableView {
    if (!_teachTableView) {
        _teachTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - 64) style:UITableViewStyleGrouped];
        _teachTableView.delegate = self;
        _teachTableView.dataSource = self;
        _teachTableView.tableFooterView = [UIView new];
        _teachTableView.tableHeaderView = [self teachHeaderView];
        _teachTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_teachTableView];
    }
    return _teachTableView;
}

- (BabyGoodTeachHeaderView *)teachHeaderView {
    if (!_teachHeaderView) {
        _teachHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"BabyGoodTeachHeaderView" owner:self options:nil] lastObject];
        [_teachHeaderView setFrame:CGRectMake(0, 0, ScreenW, 300)];
    }
    return _teachHeaderView;
}

- (ZFPlayerView *)playerView {
    if (!_playerView) {
        _playerView = [[ZFPlayerView alloc]init];
        _playerView.delegate = self;
    }
    return _playerView;
}


- (void)dealloc {
    NSLog(@"释放啦～～");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
