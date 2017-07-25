//
//  UserInfoViewController.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/21.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserInfoApi.h"
#import "UserLoginModel.h"
#import "UserInfoTableViewCell.h"
#import "UserSectionView.h"
#import "UserHeaderView.h"
#import "EditUserInfoViewController.h"

static NSString *UserinfoIdentifier = @"UserInfoTableViewCell";

@interface UserInfoViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * myTableView;
@property (nonatomic, strong) UserLoginModel * userModel;
@property (nonatomic, strong) UserHeaderView * headerView;
@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的资料";
    
    [self requestUserInfo];
    
    // 通知刷新数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestUserInfo) name:@"reloanUserInfo" object:nil];
}

- (void)setupController {
    [super setupController];
    
    
    [self.rightButton setTitle:@"编辑" forState:UIControlStateNormal];
    [self.rightButton sizeToFit];
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"UserInfoTableViewCell" bundle:nil] forCellReuseIdentifier:UserinfoIdentifier];
}


#pragma mark - 请求个人信息 

- (void)requestUserInfo {
    
    [self showLoadingView:YES];
    UserInfoApi *userApi = [[UserInfoApi alloc] initWithUserInfo];
    
    [userApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        [self showLoadingView:NO];
        
        if ([ABAConfig checkResponseObject:request.responseObject]) {
            
            self.userModel = [UserLoginModel mj_objectWithKeyValues:request.responseObject[@"body"]];
            
            [self.headerView.headerImage sd_setImageWithURL:[NSURL URLWithString:self.userModel.userimg] placeholderImage:[UIImage imageNamed:@"headerImage"]];
            
            [self.myTableView reloadData];
            
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        [self showTipsMsg:@"网络错误"];
        [self showLoadingView:NO];
    }];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UserInfoTableViewCell *infoCell = [tableView dequeueReusableCellWithIdentifier:UserinfoIdentifier forIndexPath:indexPath];
    [infoCell setUpInfoCell:self.userModel indexPath:indexPath];
    return infoCell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50.0;
}

#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UserSectionView *sectionView = [[[NSBundle mainBundle] loadNibNamed:@"UserSectionView" owner:self options:nil] lastObject];
    
    if (section == 0) {
        sectionView.sectionName.text = @"家长";
    } else if (section == 1) {
        sectionView.sectionName.text = @"宝宝";
    }
    return sectionView;
    
}

- (void)rightButtonAction:(UIButton *)sender {
    
    EditUserInfoViewController *edit = [[EditUserInfoViewController alloc] init];
    edit.userModel = self.userModel;
    [self pushToNextNavigationController:edit];
}


#pragma mark - lazyLoading

- (UITableView *)myTableView
{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-64) style:UITableViewStyleGrouped];
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
        _myTableView.tableHeaderView = [self headerView];
        _myTableView.tableFooterView = [UIView new];
        _myTableView.sectionFooterHeight = 0.0001;
        _myTableView.rowHeight = 40;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_myTableView];
    }
    return _myTableView;
}

- (UserHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[[NSBundle mainBundle] loadNibNamed:@"UserHeaderView" owner:self options:nil] lastObject];
        [_headerView setFrame:CGRectMake(0, 0, ScreenW, ScreenW/720*322)];
    }
    return _headerView;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
