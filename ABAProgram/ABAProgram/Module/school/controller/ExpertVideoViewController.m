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
#import "ExpertVideoModel.h"

static NSString *TableViewCellIdentifier = @"UITableViewCell";
static NSString *VideoListCellIdentifier = @"VideListTableViewCell";

@interface ExpertVideoViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *videoTableView;
@property (nonatomic, strong) NSArray * dataSource;

@property (nonatomic, strong) VideoHeaderView *videoheaderView;
@property (nonatomic, strong) VideoIntroSectionView *sectionView;
@end

@implementation ExpertVideoViewController
{
    BOOL _open;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = [NSString stringWithFormat:@"%@视频", self.peopleName];
    
    _open = NO;
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pause" object:nil];
}

- (void)setupController {
    [super setupController];
    
    // 注册cell
    [self.videoTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:TableViewCellIdentifier];
    [self.videoTableView registerNib:[UINib nibWithNibName:@"VideListTableViewCell" bundle:nil] forCellReuseIdentifier:VideoListCellIdentifier];
    
    // view
    self.videoheaderView = [[[NSBundle mainBundle] loadNibNamed:@"VideoHeaderView" owner:self options:nil] lastObject];
    [self.videoheaderView setFrame:CGRectMake(0, 0, ScreenW, ScreenW/4*3)];
    [self.view addSubview:self.videoheaderView];
    

    
    // 数据请求
    [self requestVideoList];
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
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self showLoadingView:NO];
        
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
    [self.sectionView didClickedVideoIntro:^{
        
        _open = !_open;
        if (_open) {
            [self.sectionView.jiantouIcon setImage:[UIImage imageNamed:@"jiantoushang"]];
        } else {
            [self.sectionView.jiantouIcon setImage:[UIImage imageNamed:@"jiantouxia"]];
        }
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0] ;
        [WeakSelf.videoTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
    }];
    return self.sectionView;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 40;

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.videoheaderView.videoModel = self.dataSource[indexPath.row-1];
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

- (VideoIntroSectionView *)sectionView {
    if (!_sectionView) {
        _sectionView = [[[NSBundle mainBundle] loadNibNamed:@"VideoIntroSectionView" owner:self options:nil] lastObject];
        [_sectionView.jiantouIcon setImage:[UIImage imageNamed:@"jiantouxia"]];
    }
    return _sectionView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
