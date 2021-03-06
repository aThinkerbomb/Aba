//
//  ExpertVideoViewController.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/12.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "ExpertVideoViewController.h"
#import "VideoIntroSectionView.h"
#import "VideListTableViewCell.h"
#import "VideoHeaderView.h"
#import "ExpertVideoApi.h"
#import "ExpertVideoLookSumApi.h"
#import "ExpertVideoModel.h"
#import "ABAShareManager.h"


static NSString *TableViewCellIdentifier = @"UITableViewCell";
static NSString *VideoListCellIdentifier = @"VideListTableViewCell";

@interface ExpertVideoViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *videoTableView;
@property (nonatomic, strong) NSArray * dataSource;

@property (nonatomic, strong) VideoHeaderView *videoheaderView;

@end

@implementation ExpertVideoViewController
{
    BOOL _open; //是否展开简介 ，默认NO
    NSInteger _index;  //记录点击的indexPatch.row, 默认为0   用于分享
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = [NSString stringWithFormat:@"%@视频", self.peopleName];
    
    _open = NO;
    _index = 0;
    
    self.dataSource = [NSArray array];
}

- (void)popBack {
    [super popBack];
    
    [self.videoheaderView pause];
}

- (void)setupController {
    [super setupController];
    
    // 注册cell
    [self.videoTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:TableViewCellIdentifier];
    [self.videoTableView registerNib:[UINib nibWithNibName:@"VideListTableViewCell" bundle:nil] forCellReuseIdentifier:VideoListCellIdentifier];
    
    // view
    self.videoheaderView = [[[NSBundle mainBundle] loadNibNamed:@"VideoHeaderView" owner:self options:nil] lastObject];
    // 回调
    __weak typeof(self)weakSelf = self;
    [self.videoheaderView ShareHandle:^{
        
        [weakSelf sharePlatform];
    }];
    
    [self.videoheaderView setFrame:CGRectMake(0, 0, ScreenW, ScreenW/4*3)];
    [self.view addSubview:self.videoheaderView];
    

    
    // 数据请求
    [self requestVideoList];
    
    self.videoTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestVideoList)];
}

- (void)viewDidLayoutSubviews {
    [self.videoheaderView setFrame:CGRectMake(0, 0, ScreenW, ScreenW/4*3)];
}
#pragma mark - 视频列表请求接口

- (void)requestVideoList {
    
    [self showLoadingView:YES];
    ExpertVideoApi *videoAPi = [[ExpertVideoApi alloc] initWithAlbumId:self.albumid];
    [videoAPi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self showLoadingView:NO];
        
        if ([ABAConfig checkResponseObject:request.responseObject]) {
            self.dataSource = [ExpertVideoModel mj_objectArrayWithKeyValuesArray:request.responseObject[@"body"]];
            
            // 设置视频播放 第一个 0
            self.videoheaderView.videoModel = self.dataSource[0];
            
            
            [self.videoTableView reloadData];
        }
        [self.videoTableView.mj_header endRefreshing];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self showLoadingView:NO];
        
    }];
    
}

#pragma mark - 观看视频记录
- (void)requestVideoLookSum:(NSString *)videoId {
    
    ExpertVideoLookSumApi *lookApi = [[ExpertVideoLookSumApi alloc] initWithLookSum:videoId];
    [lookApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
    
}



#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource.count + 1;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableViewCellIdentifier forIndexPath:indexPath];
        cell.textLabel.font = [UIFont systemFontOfSize:12.0];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.textColor = kRGBColor(100, 100, 100);
        if (_open) {
            cell.textLabel.text = @"暂无简介";
        } else {
            cell.textLabel.text = @"";
        }
        
        return cell;
    } else {
        
        VideListTableViewCell *videoCell = [tableView dequeueReusableCellWithIdentifier:VideoListCellIdentifier forIndexPath:indexPath];
        videoCell.videoModel = self.dataSource[indexPath.row-1];
        return videoCell;
        
    }
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        if (_open) {
            return 30;
        } else {
            return 0.0001;
        }
    } else {
        return 100;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

        
    __weak typeof(self)WeakSelf = self;
    VideoIntroSectionView *sectionView = [[[NSBundle mainBundle] loadNibNamed:@"VideoIntroSectionView" owner:self options:nil] lastObject];
    [sectionView didClickedVideoIntro:^{
        
        _open = !_open;
        if (_open) {
            [sectionView.jiantouIcon setImage:[UIImage imageNamed:@"jiantoushang"]];
        } else {
            [sectionView.jiantouIcon setImage:[UIImage imageNamed:@"jiantouxia"]];
        }
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0] ;
        [WeakSelf.videoTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
    }];
    return sectionView;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 40;

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ExpertVideoModel *videModel = self.dataSource[indexPath.row-1];
    self.videoheaderView.videoModel = videModel;
    _index = indexPath.row - 1;
    
    // 观看接口请求
    [self requestVideoLookSum:videModel.videoid];
}

#pragma mark - 分享
- (void)sharePlatform {
    
    [UMSocialUIManager setPreDefinePlatforms:@[@0,@1,@2,@4,@5]];
    __weak typeof (self)Weakself = self;
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        
        // 视频网络URL
        ExpertVideoModel *model = Weakself.dataSource[_index];
        NSString *videoURL = model.videopath;
        if ([ABAConfig IsChinese:videoURL]) {
            videoURL = [videoURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
        
        // 图片
//        NSInteger index = [model.filename length] - 4;
//        NSString *imageName = [model.filename substringToIndex:index];
//        NSString *urlstring = [[ABA_IMAGE stringByAppendingString:imageName] stringByAppendingString:@".jpg"];
//        if ([ABAConfig IsChinese:urlstring]) {
//            urlstring = [urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        }
        
        [ABAShareManager shareToPlatform:platformType title:model.videoname content:model.remark image:[UIImage imageNamed:@"ic_launcher"] url:videoURL presentedController:Weakself complete:^(BOOL isSuccess, NSString *errorMsg) {
            if (isSuccess) {
                [Weakself showTipsMsg:@"分享成功"];
            } else {
                [Weakself showTipsMsg:errorMsg];
            }
            
        }];
    }];
}



#pragma mark - lazyLoading

- (UITableView *)videoTableView {
    if (!_videoTableView) {
        _videoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, ScreenW/4*3, ScreenW, ScreenH-64-ScreenW/4*3) style:UITableViewStylePlain];
        _videoTableView.backgroundColor = kRGBColor(246, 247, 248);
        _videoTableView.dataSource = self;
        _videoTableView.delegate = self;
        _videoTableView.tableFooterView = [UIView new];
        _videoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_videoTableView];
    }
    return _videoTableView;
}

//- (VideoIntroSectionView *)sectionView {
//    if (!_sectionView) {
//        _sectionView = [[[NSBundle mainBundle] loadNibNamed:@"VideoIntroSectionView" owner:self options:nil] lastObject];
//        [_sectionView.jiantouIcon setImage:[UIImage imageNamed:@"jiantouxia"]];
//    }
//    return _sectionView;
//}

- (void)dealloc {
    NSLog(@"释放啦～～～");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
