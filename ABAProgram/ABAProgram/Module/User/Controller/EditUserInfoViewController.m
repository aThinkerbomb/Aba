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
#import "UpdateUserInfoApi.h"
#import "EditUserBirthdayView.h"


static NSString * editCellIdentifier = @"EditTableViewCell";


@interface EditUserInfoViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView * editTableView;
@property (nonatomic, strong) EditInfoView *editInfoView;
@property (nonatomic, strong) EditUserBirthdayView *birthdayView;
@property (nonatomic, strong) UIView *blackGroundView;

@property (nonatomic, strong) NSMutableDictionary *updateDic;  // 更新的数据信息
@end

@implementation EditUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"编辑资料";
    self.updateDic = [NSMutableDictionary dictionary];
}

- (void)setupController {
    [super setupController];
    
    [self.rightButton setTitle:@"完成" forState:UIControlStateNormal];
    [self.rightButton sizeToFit];
    
    [self.editTableView registerNib:[UINib nibWithNibName:@"EditTableViewCell" bundle:nil] forCellReuseIdentifier:editCellIdentifier];
    
}

- (void)rightButtonAction:(UIButton *)sender {
    
    // 提交更新信息
    [self UpdateUserinfo];
    
}



#pragma mark - 更新提交数据

- (void)UpdateUserinfo {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    EditTableViewCell *cell1 = [self.editTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    EditTableViewCell *cell2 = [self.editTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    EditTableViewCell *cell3 = [self.editTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    EditTableViewCell *cell4 = [self.editTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    EditTableViewCell *cell5 = [self.editTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    EditTableViewCell *cell6 = [self.editTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]];
    
    NSInteger gender = 0;
    if ([cell5.info.text isEqualToString:@"公主"]) {
        gender = 1;
    }
    
    [dic setValue:[KZUserDefaults objectForKey:@"userid"] forKey:@"userid"];
    [dic setValue:cell1.info.text forKey:@"username"];
    [dic setValue:cell2.info.text forKey:@"userphone"];
    [dic setValue:cell3.info.text forKey:@"userrelation"];
    [dic setValue:cell4.info.text forKey:@"usersonname"];
    [dic setValue:@(gender) forKey:@"usergender"];
    [dic setValue:cell6.info.text forKey:@"userbirthday"];
    
    if (cell2.info.text.length != 11) {
        [self showTipsMsg:@"请输入正确的11位手机号"];
        return;
    }
    
    
    [self showLoadingView:YES];
    
    UpdateUserInfoApi *updateApi = [[UpdateUserInfoApi alloc] initWithUserInfo:dic];

    [updateApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        [self showLoadingView:NO];
        
        if ([ABAConfig checkResponseObject:request.responseObject]) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reloanUserInfo" object:nil];
            [self showTipsMessageDelayPopBackWithMessage:@"更新信息成功"];
            
            
        } else {
            [self showTipsMsg:@"更新失败"];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        [self showLoadingView:NO];
        [self showTipsMsg:@"网络错误"];
        
    }];
//    EditTableViewCell *cell1 = [self.editTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//    EditTableViewCell *cell2 = [self.editTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
//    EditTableViewCell *cell3 = [self.editTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
//    EditTableViewCell *cell4 = [self.editTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
//    EditTableViewCell *cell5 = [self.editTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
//    EditTableViewCell *cell6 = [self.editTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]];
//    
//    NSLog(@"nmb = %@", cell3.info.text);
//    NSString *relation = cell3.info.text;
//    [dic setValue:[KZUserDefaults objectForKey:@"userid"] forKey:@"userid"];
//    [dic setValue:cell1.info.text forKey:@"usersonname"];
//    [dic setValue:cell2.info.text forKey:@"userphone"];
//    [dic setValue:relation forKey:@"userrelation"];
//    [dic setValue:cell4.info.text forKey:@"username"];
//    [dic setValue:cell5.info.text forKey:@"usergender"];
//    [dic setValue:cell6.info.text forKey:@"userbirthday"];
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
    
    if (indexPath.section == 1 && indexPath.row == 2) {
     
        [self showBirthdayView];
    }
    
}


#pragma mark - 显示 选择性别关系View
// 显示 选择View
- (void)ChooseViewWithindexpath:(NSIndexPath *)indexp{
    
    self.blackGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    self.blackGroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    self.editInfoView = [[[NSBundle mainBundle] loadNibNamed:@"EditInfoView" owner:self options:nil] lastObject];
    [self.editInfoView setFrame:CGRectMake((ScreenW-250)/2, (ScreenH-64-200)/2, 250, 180)];
    [self.editInfoView setUpEditWithIndexpath:indexp];
    
    __weak typeof(self)Weakself = self;
    [self.editInfoView Chooseproperty:^(NSIndexPath *indexpath, NSString *str) {
        
        EditTableViewCell *cell = [Weakself.editTableView cellForRowAtIndexPath:indexpath];
        cell.info.text = str;
        [Weakself.blackGroundView removeFromSuperview];
    }];
    
    [self.blackGroundView addSubview:self.editInfoView];
    [kAppDelegate.window addSubview:self.blackGroundView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    [self.blackGroundView addGestureRecognizer:tap];
}

// 取消手势
- (void)tapGesture:(UITapGestureRecognizer *)tap {
    
    [self.blackGroundView removeFromSuperview];
    
}



#pragma mark - 显示 生日view

- (void)showBirthdayView {
    
    self.blackGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    self.blackGroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    self.birthdayView = [[[NSBundle mainBundle] loadNibNamed:@"EditUserBirthdayView" owner:self options:nil] lastObject];
    [self.birthdayView setFrame:CGRectMake((ScreenW - (ScreenW-60))/2, (ScreenH - 400)/2, ScreenW-60, 400)];
    self.birthdayView.userModel = self.userModel;
    
    __weak typeof(self)WeakSelf = self;
    [self.birthdayView ClickedSure:^(NSString *birthday) {
       
        WeakSelf.userModel.userbirthday = birthday;
        
        EditTableViewCell *cell = [WeakSelf.editTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]];
        cell.info.text = birthday;
        [WeakSelf.blackGroundView removeFromSuperview];
        
    }];
    
    [self.birthdayView ClickedCancel:^{
       
        [WeakSelf.blackGroundView removeFromSuperview];
        
    }];
    
    [self.blackGroundView addSubview:self.birthdayView];
    [kAppDelegate.window addSubview:self.blackGroundView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    [self.blackGroundView addGestureRecognizer:tap];
    
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
