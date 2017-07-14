//
//  BenefitDetailViewController.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/3.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "BenefitDetailViewController.h"
#import "BenefitDetailHeaderView.h"
#import "ParameterTableViewCell.h"
#import "ImageTableViewCell.h"
#import "ServiceDesTableViewCell.h"
#import "GoodDetailSectionView.h"

#import "GoodsDetailApi.h"
#import "GoodsDetailModel.h"



static NSString * parameterCellIdentifier = @"ParameterTableViewCell";
static NSString * iamgeCellIdentifier = @"ImageTableViewCell";
static NSString * serviceDesCellIdentifier = @"ServiceDesTableViewCell";

@interface BenefitDetailViewController ()<UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) UITableView *detailViewController;
@property (nonatomic, strong) BenefitDetailHeaderView *HeaderView;
@property (nonatomic, strong) NSArray * imageArr;
@property (nonatomic, strong) GoodsDetailModel *detailModel;
@property (nonatomic, strong) GoodDetailSectionView * sectionView;

@end

@implementation BenefitDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"商品详情";
    
    self.imageArr = [NSArray array];
    
}

- (void)setupController {
    [super setupController];
    
    
    [self.detailViewController registerClass:[ParameterTableViewCell class] forCellReuseIdentifier:parameterCellIdentifier];
    [self.detailViewController registerNib:[UINib nibWithNibName:@"ImageTableViewCell" bundle:nil] forCellReuseIdentifier:iamgeCellIdentifier];
    [self.detailViewController registerNib:[UINib nibWithNibName:@"ServiceDesTableViewCell" bundle:nil] forCellReuseIdentifier:serviceDesCellIdentifier];
    
    [self requestGoodsDetailData];
}

#pragma mark - 一天一惠商品详情 数据请求
- (void)requestGoodsDetailData {
    
    [self showLoadingView:YES];
    GoodsDetailApi * detailApi = [[GoodsDetailApi alloc] initWithGoodsDetailId:self.goodId];
    [detailApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        [self showLoadingView:NO];
        if ([ABAConfig checkResponseObject:request.responseObject]) {
            
            // 映射数据model
            self.detailModel = [GoodsDetailModel mj_objectWithKeyValues:request.responseObject[@"body"]];
            
            self.detailModel.detailStyle = DetailStyleOfGoods;
            
            
            self.imageArr = [self.detailModel.infourl componentsSeparatedByString:@"|"];
            self.detailViewController.tableHeaderView = [self HeaderView];
            self.HeaderView.detailModel = self.detailModel;
            
            [self.detailViewController reloadData];
            
        } else {
            
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self showLoadingView:NO];
        [self showTipsMsg:@"网络请求错误"];
        
    }];
    
}




#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.detailModel.detailStyle == DetailStyleOfGoods) {
        return self.imageArr.count + 1;
    } else {
        return 2;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        ParameterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:parameterCellIdentifier forIndexPath:indexPath];
        cell.parameterArr = self.detailModel.userGoodsAttrList;
        return cell;
        
    }
    
    if (self.detailModel.detailStyle == DetailStyleOfGoods) {
        ImageTableViewCell *imageCell = [tableView dequeueReusableCellWithIdentifier:iamgeCellIdentifier forIndexPath:indexPath];
        imageCell.imageString = [self.imageArr objectAtIndex:indexPath.row-1];
        return imageCell;
        
    } else {
        ServiceDesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:serviceDesCellIdentifier forIndexPath:indexPath];
        return cell;
        
    }
    
    
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return [ParameterTableViewCell getHeightWithParameter:self.detailModel.userGoodsAttrList];
    }

    if (self.detailModel.detailStyle == DetailStyleOfGoods) {
        return 270;
    } else {
        return 300;
    }

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    // 0 == section
    self.sectionView = [[[NSBundle mainBundle] loadNibNamed:@"GoodDetailSectionView" owner:self options:nil] lastObject];
    self.sectionView.detailModel = self.detailModel;
    
    __weak typeof(self)WeakSelf = self;
    [self.sectionView didSelectedTab:^(DetailStyle style) {
        
        WeakSelf.detailModel.detailStyle = style;
        [WeakSelf.detailViewController reloadData];
        
    }];
    return self.sectionView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}

#pragma mark - lazyloading

- (UITableView *)detailViewController {
    if (!_detailViewController) {
        _detailViewController = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-64) style:UITableViewStylePlain];
        _detailViewController.dataSource = self;
        _detailViewController.delegate = self;
        _detailViewController.tableFooterView = [UIView new];
        _detailViewController.separatorStyle = UITableViewCellSeparatorStyleNone;
        _detailViewController.rowHeight = 120;
        [self.view addSubview:_detailViewController];
    }
    return _detailViewController;
}


- (BenefitDetailHeaderView *)HeaderView {
    if (!_HeaderView) {
        _HeaderView = [[[NSBundle mainBundle] loadNibNamed:@"BenefitDetailHeaderView" owner:self options:nil] lastObject];
//        NSString *s = @"贝贝熊-畅销40余年，发行2.4亿，影响两代人；孩子们成长初期的启蒙书；适合阅读年龄：3～9岁。";
        CGSize size = [self.detailModel.goodsname sizeWithFont:[UIFont systemFontOfSize:14.0] maxSize:CGSizeMake(ScreenW - 16 -16, MAXFLOAT)];
        [_HeaderView setFrame:CGRectMake(0, 0, ScreenW, ScreenW/5*4+90+size.height)];
    }
    return _HeaderView;
}

- (void)dealloc {
    NSLog(@"释放啦～～");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
