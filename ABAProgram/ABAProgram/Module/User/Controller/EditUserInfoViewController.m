//
//  EditUserInfoViewController.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/22.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "EditUserInfoViewController.h"
#import "UserSectionView.h"
#import "EditTableViewCell.h"
#import "EditInfoView.h"
static NSString * editCellIdentifier = @"EditTableViewCell";


@interface EditUserInfoViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView * editTableView;
@property (nonatomic, strong) EditInfoView *editInfoView;
@property (nonatomic, strong) UIView *blackGroundView;
@end

@implementation EditUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"编辑资料";
    
}

- (void)setupController {
    [super setupController];
    
    [self.rightButton setTitle:@"完成" forState:UIControlStateNormal];
    [self.rightButton sizeToFit];
    
    [self.editTableView registerNib:[UINib nibWithNibName:@"EditTableViewCell" bundle:nil] forCellReuseIdentifier:editCellIdentifier];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EditTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:editCellIdentifier forIndexPath:indexPath];
    [cell setUpInfoCell:self.userModel indexPath:indexPath];
    if (indexPath.section == 0 && indexPath.row == 2) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 1 || indexPath.row == 2) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    return cell;
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row == 2) {
        
        [self ChooseViewWithindexpath:indexPath];
        
    }
    
    if (indexPath.section == 1 && indexPath.row == 1) {
        [self ChooseViewWithindexpath:indexPath];
    }
    
}

// 显示 选择View
- (void)ChooseViewWithindexpath:(NSIndexPath *)indexp{
    
    self.blackGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    self.blackGroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    self.editInfoView = [[[NSBundle mainBundle] loadNibNamed:@"EditInfoView" owner:self options:nil] lastObject];
    [self.editInfoView setFrame:CGRectMake((ScreenW-250)/2, (ScreenH-64-200)/2, 250, 180)];
    [self.editInfoView setUpEditWithIndexpath:indexp];
    
    __weak typeof(self)Weakself = self;
    [self.editInfoView Chooseproperty:^(NSIndexPath *indexpath, NSString *str) {
        
        if (indexpath.section == 0 && indexpath.row == 2) {
            Weakself.userModel.userrelation = str;
        }
        if (indexpath.section == 1 && indexpath.row == 1) {
            if ([str isEqualToString:@"公主"]) {
                Weakself.userModel.usergender = @"1";
            } else if ([str isEqualToString:@"王子"]) {
                Weakself.userModel.usergender = @"0";
            }
        }
        
        [Weakself.editTableView reloadData];
        
        [Weakself.blackGroundView removeFromSuperview];
    }];
    
    [self.blackGroundView addSubview:self.editInfoView];
    [kAppDelegate.window addSubview:self.blackGroundView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    [self.blackGroundView addGestureRecognizer:tap];
}

- (void)tapGesture:(UITapGestureRecognizer *)tap {
    
    [self.blackGroundView removeFromSuperview];
    
}



#pragma mark - lazyLoading

- (UITableView *)editTableView
{
    if (!_editTableView) {
        _editTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-64) style:UITableViewStyleGrouped];
        _editTableView.dataSource = self;
        _editTableView.delegate = self;
        _editTableView.tableFooterView = [UIView new];
        _editTableView.sectionFooterHeight = 0.0001;
        _editTableView.rowHeight = 50;
        _editTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_editTableView];
    }
    return _editTableView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
