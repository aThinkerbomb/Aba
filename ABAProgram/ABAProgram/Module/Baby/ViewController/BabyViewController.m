//
//  BabyViewController.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/22.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "BabyViewController.h"
#import "LySegmentMenu.h"
#import "BabyListTableViewCell.h"
#import "BabyTeachApi.h"
#import "BabyTeachModel.h"
#import "BabyGoodDetalViewController.h"


static NSString *babyListCellIdentifier = @"BabyListTableViewCell";


@interface BabyViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *goodTeachTableView;
@property (nonatomic, strong) UITableView *goodClassTableView;
@property (nonatomic, strong) NSMutableArray *teachArr;
@property (nonatomic, strong) NSMutableArray *classArr;
@end

@implementation BabyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"宝宝优选";
    self.teachArr = [NSMutableArray array];
    self.classArr = [NSMutableArray array];
    
}

- (void)setupController
{
    [super setupController];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 设置左上角图标
    UIImage *imager = [UIImage imageNamed:@"headerImage"];
    [self setNaviLeftItemNormalImage:imager HighlightedIamge:imager];
    
    // lySegment 初始化
    LySegmentMenu *lySegment = [[LySegmentMenu alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - 64 - 50) ControllerViewArray:@[self.goodTeachTableView, self.goodClassTableView] TitleArray:@[@"优教", @"优班"]];
    [self.view addSubview:lySegment];
    

    // 注册cell
    [self registerTableViewCell];
    
    // 数据请求
    [self requestBabyData];

  
}

// 注册cell
- (void)registerTableViewCell {
    
    [self.goodTeachTableView registerNib:[UINib nibWithNibName:@"BabyListTableViewCell" bundle:nil] forCellReuseIdentifier:babyListCellIdentifier];
    [self.goodClassTableView registerNib:[UINib nibWithNibName:@"BabyListTableViewCell" bundle:nil] forCellReuseIdentifier:babyListCellIdentifier];
    
}


#pragma mark - 数据请求
- (void)requestBabyData
{
    
    [self showLoadingView:YES];
    BabyTeachApi * baby = [[BabyTeachApi alloc] initWithInstitutionAllList];
    [baby startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self showLoadingView:NO];
        
        if ([ABAConfig checkResponseObject:request.responseObject]) {
            NSArray * array = [BabyTeachModel mj_objectArrayWithKeyValuesArray:[request.responseObject objectForKey:@"body"]];
            for (BabyTeachModel *model in array) {
                if ([model.institutiontype intValue] == 1) {
                    
                    [self.teachArr addObject:model];
                    
                } else if ([model.institutiontype intValue] == 3) {
                    
                    [self.classArr addObject:model];
                    
                }
            }
            
            [self.goodTeachTableView reloadData];
            [self.goodClassTableView reloadData];
            
        } else {
            [self showTipsMsg:@"请求错误"];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self showLoadingView:NO];
        [self showTipsMsg:@"网络错误"];
        
        
    }];
}


#pragma mark - UITableVIewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.goodTeachTableView) {
        
        BabyListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:babyListCellIdentifier forIndexPath:indexPath];
        [cell startBuildBabyListCellWith:self.teachArr[indexPath.row]];
        return cell;
        
    } else {
        BabyListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:babyListCellIdentifier forIndexPath:indexPath];
        [cell startBuildBabyListCellWith:self.classArr[indexPath.row]];
        return cell;
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.goodTeachTableView) {
        return self.teachArr.count;
    }
    return self.classArr.count;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.goodTeachTableView) {
        
        BabyTeachModel *model = self.teachArr[indexPath.row];
        BabyGoodDetalViewController *detailVC = [[BabyGoodDetalViewController alloc] init];
        detailVC.style = GoodChooseStyleTeach;
        detailVC.institutionId = model.babyId;
        [self pushToNextNavigationController:detailVC];
        
    } else {
        BabyTeachModel *model = self.classArr[indexPath.row];
        BabyGoodDetalViewController *detailVC = [[BabyGoodDetalViewController alloc] init];
        detailVC.style = GoodChooseStyleClass;
        detailVC.institutionId = model.babyId;
        [self pushToNextNavigationController:detailVC];
    }
}


- (void)leftButtonAction:(UIButton *)sender
{
    NSLog(@"头像按钮");
}


#pragma mark - lazyLoading

- (UITableView *)goodTeachTableView
{
    if (!_goodTeachTableView) {
        _goodTeachTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-64) style:UITableViewStylePlain];
        _goodTeachTableView.dataSource = self;
        _goodTeachTableView.delegate = self;
        _goodTeachTableView.tableFooterView = [UIView new];
        _goodTeachTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _goodTeachTableView.rowHeight = 120;
    }
    return _goodTeachTableView;
}

- (UITableView *)goodClassTableView
{
    if (!_goodClassTableView) {
        _goodClassTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-64) style:UITableViewStylePlain];
        _goodClassTableView.dataSource = self;
        _goodClassTableView.delegate = self;
        _goodClassTableView.tableFooterView = [UIView new];
        _goodClassTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _goodClassTableView.rowHeight = 120;
    }
    return _goodClassTableView;
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
