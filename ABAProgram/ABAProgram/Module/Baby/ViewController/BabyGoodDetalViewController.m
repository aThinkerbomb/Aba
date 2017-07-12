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


static NSString *TableViewCellIdentifier = @"UITableViewCell";

@interface BabyGoodDetalViewController ()<UITableViewDelegate, UITableViewDataSource, GoodDetailSectionViewDelegate, SchoolInfoSectionViewDelegate>

@property (nonatomic, strong) UITableView *teachTableView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) BabyGoodDetailSectionView *detailSectionView;
@property (nonatomic, strong) BabySchoolInfoSectionView *infoSectionView;
@property (nonatomic, strong) BabyGoodTeachHeaderView *teachHeaderView;
@property (nonatomic, strong) IntroductionModel * baseIntroMode;


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
    
    [self.teachTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:TableViewCellIdentifier];
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


#pragma mark - GoodDetailSectionViewDelegate

- (void)didSelectedSection:(NSInteger)section {
    
    NSLog(@"%lu", section);
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
