
//
//  SchoolViewController.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/22.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "SchoolViewController.h"
#import "LySegmentMenu.h"

#import "SchoolAlbumApi.h"
#import "SchoolDaRenApi.h"
#import "SchoolAritcleApi.h"

#import "SchoolAlbumModel.h"
#import "SchoolDaRenModel.h"
#import "SchoolArticleModel.h"

#import "SchoolSectionView.h"
#import "ArticleTableViewCell.h"

#import "ABAWebViewController.h"
#import "TalentViewController.h"
#import "ExpertVideoViewController.h"

static NSString *TableViewCellIdentifier = @"tableViewCell";
static NSString *articelCellIdentifier = @"ArticleTableViewCell";

@interface SchoolViewController ()<UITableViewDelegate, UITableViewDataSource, SchoolSectionViewDelegate>

@property (nonatomic, strong) UITableView * expertTableView;
@property (nonatomic, strong) UITableView * talentTableView;
@property (nonatomic, strong) UITableView * articleTableView;

@property (nonatomic, strong) SchoolSectionView *schoolSectionView;

@property (nonatomic, strong) NSArray *expertArr;
@property (nonatomic, strong) NSArray *talentArr;
@property (nonatomic, strong) NSArray *articleArr;

@end

@implementation SchoolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"亲子学堂";

    self.expertArr = [NSArray array];
    self.talentArr = [NSArray array];
    self.articleArr = [NSArray array];
    
    
    // 注册cell
    [self registerTableViewCell];
    
    // 数据请求
    [self requestExpertData];
    [self requestDaRenData];
    [self requestArticleData];
    
    // 导入下拉刷新
    self.expertTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestExpertData)];
    self.talentTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestDaRenData)];
    self.articleTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestArticleData)];
    
}


- (void)setupController
{
    [super setupController];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 设置头像
    NSString *imagerString = [KZUserDefaults objectForKey:@"userimg"];
    if ([imagerString isEqualToString:@""]) {
        UIImage *imager = [UIImage imageNamed:@"headerImage"];
        [self setNaviLeftItemNormalImage:imager HighlightedIamge:imager];
    } else {
        [self setNaviLeftItemNormalImage:imagerString HighlightedIamge:imagerString];
    }
    

    //lySegment 初始化
    LySegmentMenu *lySegment = [[LySegmentMenu alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-64-50) ControllerViewArray:@[self.expertTableView, self.talentTableView, self.articleTableView] TitleArray:@[@"专家", @"达人", @"文章"]];
    
    [self.view addSubview:lySegment];
    
    
    
}

#pragma mark - 数据请求

- (void)requestExpertData
{
    [self showLoadingView:YES];
    SchoolAlbumApi *albumApi = [[SchoolAlbumApi alloc] initWithSchoolAlbum];
    [albumApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        [self showLoadingView:NO];
        
        if ([ABAConfig checkResponseObject:request.responseObject]) {
            
            self.expertArr = [SchoolAlbumModel mj_objectArrayWithKeyValuesArray:request.responseObject[@"body"]];
            
            // 计算高度，放入model中，防止滑动tableView 大量计算造成卡顿
            for (SchoolAlbumModel *model in self.expertArr) {
                
                if ([model.introduction isEqualToString:@""]) {
                    model.height = 40;
                } else {
                    NSString *introdue = [NSString stringWithFormat:@"        %@", model.introduction];
                    CGSize newSize = [introdue sizeWithFont:[UIFont systemFontOfSize:12.0] maxSize:CGSizeMake(ScreenW-20-20, MAXFLOAT)];
                    model.height = newSize.height;
                }
                // 设置为关闭
                model.open = NO;
            }
            
            [self.expertTableView.mj_header endRefreshing];
            [self.expertTableView reloadData];
        } else {
            [self showTipsMsg:@"数据错误"];
        }
        
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self showLoadingView:NO];
        [self showTipsMsg:@"网络请求错误"];
    }];
    
}


- (void)requestDaRenData
{
    [self showLoadingView:YES];
    
    SchoolDaRenApi *darenApi = [[SchoolDaRenApi alloc] initWithSchoolDaRen];
    [darenApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        [self showLoadingView:NO];
        
        if ([ABAConfig checkResponseObject:request.responseObject]) {
            
            self.talentArr = [SchoolDaRenModel mj_objectArrayWithKeyValuesArray:request.responseObject[@"body"]];
            
            for (SchoolDaRenModel *model in self.talentArr) {
                
                // 设置关闭
                model.open = NO;
            }
            
            [self.talentTableView.mj_header endRefreshing];
            [self.talentTableView reloadData];
        } else {
            [self showTipsMsg:@"数据错误"];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self showLoadingView:NO];
        [self showTipsMsg:@"网络请求错误"];
    }];
}

- (void)requestArticleData
{
    
    [self showLoadingView:YES];
    
    SchoolAritcleApi *articleApi = [[SchoolAritcleApi alloc] initWithSchoolAritcle];
    [articleApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        [self showLoadingView:NO];
        
        if ([ABAConfig checkResponseObject:request.responseObject]) {
            
            self.articleArr = [SchoolArticleModel mj_objectArrayWithKeyValuesArray:request.responseObject[@"body"]];
            
            [self.articleTableView.mj_header endRefreshing];
            [self.articleTableView reloadData];
        } else {
            [self showTipsMsg:@"数据错误"];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self showLoadingView:NO];
        [self showTipsMsg:@"网络请求错误"];
    }];
    
}




#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.expertTableView) {
        
        return self.expertArr.count;
        
    } else if (tableView == self.talentTableView) {
        
        return self.talentArr.count;
    } else {
        
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.expertTableView) {
        
        return 1;
        
    } else if (tableView == self.talentTableView) {
        return 1;
    } else {
        
        return self.articleArr.count;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.expertTableView) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableViewCellIdentifier forIndexPath:indexPath];
        SchoolAlbumModel *model = self.expertArr[indexPath.section];
        if (model.open) {
            if ([model.introduction isEqualToString:@""]) {
                cell.textLabel.text = @"暂无简介";
            } else {
                cell.textLabel.text = [NSString stringWithFormat:@"        %@", model.introduction];
            }
        } else {
            cell.textLabel.text = @"";
        }
        
        cell.textLabel.font = [UIFont systemFontOfSize:12.0];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.textColor = kRGBColor(100, 100, 100);
        return cell;
        
    } else if (tableView == self.talentTableView) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableViewCellIdentifier forIndexPath:indexPath];
        SchoolDaRenModel *dareModel = self.talentArr[indexPath.section];
        if (dareModel.open) {
            cell.textLabel.text = @"    暂无简介";
        } else {
            cell.textLabel.text = @"";
        }
        
        cell.textLabel.font = [UIFont systemFontOfSize:12.0];
        cell.textLabel.textColor = kRGBColor(100, 100, 100);
        return cell;
        
    } else {
        
        ArticleTableViewCell *aritcleCell = [tableView dequeueReusableCellWithIdentifier:articelCellIdentifier forIndexPath:indexPath];
        [aritcleCell startSetupArticelCellWith:self.articleArr[indexPath.row]];
        
        return aritcleCell;
        
    }
    
}

#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (tableView == self.expertTableView) {
        
        self.schoolSectionView = [[[NSBundle mainBundle] loadNibNamed:@"SchoolSectionView" owner:nil options:nil] lastObject];
        
        self.schoolSectionView.delegate = self;
        self.schoolSectionView.section = section;
        [self.schoolSectionView startSetupExpetSectionViewWith:self.expertArr[section] sectionType:SectionTypeExpert tableView:self.expertTableView];
        
        return self.schoolSectionView;
        
    } else if (tableView == self.talentTableView) {
        
        self.schoolSectionView = [[[NSBundle mainBundle] loadNibNamed:@"SchoolSectionView" owner:nil options:nil] lastObject];
        
        self.schoolSectionView.delegate = self;
        self.schoolSectionView.section = section;
        [self.schoolSectionView startSetupTalentSectionViewwith:self.talentArr[section] sectionType:SectionTypeTalect tableView:self.talentTableView];
        
        return self.schoolSectionView;
    
    } else {
        return nil;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == self.expertTableView || tableView == self.talentTableView) {
        return 220;
    } else {
        return 0.0001;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.expertTableView) {
        SchoolAlbumModel *albumModel = self.expertArr[indexPath.section];
        if (albumModel.open) {
            
            return albumModel.height+10;
        } else {
            return 0.00001;
        }
        
        
    } else if (tableView == self.talentTableView) {
        SchoolDaRenModel *dareModel = self.talentArr[indexPath.section];
        if (dareModel.open) {
            return 40;
        } else {
            return 0.0001;
        }
        
    } else {
        return 110;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == self.expertTableView) {
        SchoolAlbumModel *albumModel = self.expertArr[indexPath.section];
        ExpertVideoViewController * expertVideoVC = [[ExpertVideoViewController alloc] init];
        expertVideoVC.albumid = albumModel.albumId;
        expertVideoVC.peopleName = albumModel.albumname;
        expertVideoVC.hidesBottomBarWhenPushed = YES;
        [self pushToNextNavigationController:expertVideoVC];
    }
    
    
    if (tableView == self.talentTableView) {
        SchoolDaRenModel *darenModel = self.talentArr[indexPath.section];
        TalentViewController *talentVC = [[TalentViewController alloc] init];
        talentVC.darenId = darenModel.DaRenid;
        talentVC.hidesBottomBarWhenPushed = YES;
        [self pushToNextNavigationController:talentVC];
    }
    
    if (tableView == self.articleTableView) {
        SchoolArticleModel *articleModel = self.articleArr[indexPath.row];
        NSString *urlString = [ABA_HTML stringByAppendingPathComponent:articleModel.articleurl];
        ABAWebViewController *webVC = [[ABAWebViewController alloc] init];
        webVC.hidesBottomBarWhenPushed = YES;
        webVC.urlString = urlString;
        [self pushToNextNavigationController:webVC];
 
    }
}


#pragma mark - SchoolSectionViewDelegate

// 点击了第几个section
- (void)didSelectedSection:(NSInteger)section tableView:(UITableView *)tableView
{
    if (tableView == self.expertTableView) {
        SchoolAlbumModel *albumModel = self.expertArr[section];
        ExpertVideoViewController * expertVideoVC = [[ExpertVideoViewController alloc] init];
        expertVideoVC.albumid = albumModel.albumId;
        expertVideoVC.peopleName = albumModel.albumname;
        expertVideoVC.hidesBottomBarWhenPushed = YES;
        [self pushToNextNavigationController:expertVideoVC];
        
    }
    if (tableView == self.talentTableView) {
        SchoolDaRenModel *darenModel = self.talentArr[section];
        TalentViewController *talentVC = [[TalentViewController alloc] init];
        talentVC.hidesBottomBarWhenPushed = YES;
        talentVC.darenId = darenModel.DaRenid;
        [self pushToNextNavigationController:talentVC];
    }
    
    
}

// 点击了第几个简介绍
- (void)didSelectedIntroduceOfSection:(NSInteger)section open:(BOOL)open tableView:(UITableView *)tableView
{
    
    if (tableView == self.expertTableView) {
        NSIndexSet *indeSet = [[NSIndexSet alloc] initWithIndex:section];
        [self.expertTableView reloadSections:indeSet withRowAnimation:UITableViewRowAnimationAutomatic];
    } else if (tableView == self.talentTableView) {
        NSIndexSet *indeSet = [[NSIndexSet alloc] initWithIndex:section];
        [self.talentTableView reloadSections:indeSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }

}



#pragma mark - private method

- (void)registerTableViewCell
{
    [self.expertTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:TableViewCellIdentifier];
    [self.talentTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:TableViewCellIdentifier];
    [self.articleTableView registerNib:[UINib nibWithNibName:@"ArticleTableViewCell" bundle:nil] forCellReuseIdentifier:articelCellIdentifier];
}



- (void)leftButtonAction:(UIButton *)sender
{
    [self showLeftSideView];
}


#pragma mark - lazyLoading

- (UITableView *)expertTableView
{
    if (!_expertTableView) {
        _expertTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-64) style:UITableViewStyleGrouped];
        _expertTableView.dataSource = self;
        _expertTableView.delegate = self;
        _expertTableView.tableFooterView = [UIView new];
    }
    return _expertTableView;
}

- (UITableView *)talentTableView
{
    if (!_talentTableView) {
        _talentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-64) style:UITableViewStyleGrouped];
        _talentTableView.dataSource = self;
        _talentTableView.delegate = self;
        _talentTableView.tableFooterView = [UIView new];
        _talentTableView.rowHeight = 40;
        
    }
    return _talentTableView;
}

- (UITableView *)articleTableView
{
    if (!_articleTableView) {
        _articleTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-64) style:UITableViewStylePlain];
        _articleTableView.dataSource = self;
        _articleTableView.delegate = self;
        _articleTableView.tableFooterView = [UIView new];
        _articleTableView.rowHeight = 110;
    }
    return _articleTableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
