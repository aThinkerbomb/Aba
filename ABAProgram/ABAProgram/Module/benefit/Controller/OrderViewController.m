//
//  OrderViewController.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/10.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "OrderViewController.h"
#import "AdressTableViewCell.h"
#import "OrangeTableViewCell.h"
#import "CommodityTableViewCell.h"
#import "PriceInfoTableViewCell.h"
#import "payTableViewCell.h"
#import "ConfirmPayView.h"
#import "GetReceiptApi.h"
#import "GetReceiptAdressModel.h"
#import "EditViewController.h"



static NSString * AdressCellIdentifier    = @"AdressTableViewCell";
static NSString * OrangeCellIdentifier    = @"OrangeTableViewCell";
static NSString * CommodityCellIdentifier = @"CommodityTableViewCell";
static NSString * PriceInfoCellIdentifier = @"PriceInfoTableViewCell";
static NSString * PayCellIdentifier       = @"payTableViewCell";


@interface OrderViewController ()<UITableViewDelegate, UITableViewDataSource, PayCellDelegate, AdressDelegate>

@property (nonatomic, strong) UITableView *orderTableView;
@property (nonatomic, strong) GetReceiptAdressModel *adressModel;
@property (nonatomic, strong) ConfirmPayView * confirmPayView;


@end

@implementation OrderViewController
{
    NSInteger _selectedPayRow;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"确认订单";
    _selectedPayRow = 0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadRequestData) name:@"reload" object:nil];
    
}


- (void)viewDidLayoutSubviews {
    [self.confirmPayView setFrame:CGRectMake(0, ScreenH-50-64, ScreenW, 50)];
}

- (void)setupController {
    [self confirmPayView];
    [super setupController];
    
    // 注册cell
    [self registerTableViewCell];
    
    // 数据请求
    [self getReceiptAdressDate];
    

    // 确认支付View
    [self.view addSubview:self.confirmPayView];

    
}

- (ConfirmPayView *)confirmPayView {
    if (!_confirmPayView) {
        _confirmPayView = [[[NSBundle mainBundle] loadNibNamed:@"ConfirmPayView" owner:self options:nil]firstObject];
        [_confirmPayView setFrame:CGRectMake(0, ScreenH-50-64, ScreenW, 50)];
    }
    return _confirmPayView;
}


- (void)registerTableViewCell {
    
    [self.orderTableView registerNib:[UINib nibWithNibName:@"AdressTableViewCell" bundle:nil] forCellReuseIdentifier:AdressCellIdentifier];
    [self.orderTableView registerNib:[UINib nibWithNibName:@"OrangeTableViewCell" bundle:nil] forCellReuseIdentifier:OrangeCellIdentifier];
    [self.orderTableView registerNib:[UINib nibWithNibName:@"CommodityTableViewCell" bundle:nil] forCellReuseIdentifier:CommodityCellIdentifier];
    [self.orderTableView registerNib:[UINib nibWithNibName:@"PriceInfoTableViewCell" bundle:nil] forCellReuseIdentifier:PriceInfoCellIdentifier];
    [self.orderTableView registerNib:[UINib nibWithNibName:@"payTableViewCell" bundle:nil] forCellReuseIdentifier:PayCellIdentifier];
}

#pragma mark - 通知
- (void)reloadRequestData {
    [self getReceiptAdressDate];
}



#pragma mark - 获取收获地址

- (void)getReceiptAdressDate {
    
    GetReceiptApi *adressApi = [[GetReceiptApi alloc] initWithReceiptAdress];
    [adressApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        if ([ABAConfig checkResponseObject:request.responseObject]) {
            
            self.adressModel = [GetReceiptAdressModel mj_objectWithKeyValues:request.responseObject[@"body"]];
            
            [self.orderTableView reloadData];
            
        }
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
    
}



#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 2;
    } else if (section == 2) {
        return 3;
    } else {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (0 == indexPath.section && 0 == indexPath.row) {
        
        AdressTableViewCell *adressCell = [tableView dequeueReusableCellWithIdentifier:AdressCellIdentifier forIndexPath:indexPath];
        adressCell.adressModel = self.adressModel;
        adressCell.delegate = self;
        return adressCell;
    } else if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            OrangeTableViewCell *orangeCell = [tableView dequeueReusableCellWithIdentifier:OrangeCellIdentifier forIndexPath:indexPath];
            return orangeCell;
        } else {
            CommodityTableViewCell *commodityCell = [tableView dequeueReusableCellWithIdentifier:CommodityCellIdentifier forIndexPath:indexPath];
            [commodityCell setBenefitModel:self.benefitModel];
            return commodityCell;
        }
        
    } else if (indexPath.section == 2) {
        
        PriceInfoTableViewCell *priceInfoCell = [tableView dequeueReusableCellWithIdentifier:PriceInfoCellIdentifier forIndexPath:indexPath];
        [priceInfoCell setUpCellWithModel:self.benefitModel indexPath:indexPath];
        return priceInfoCell;
    } else {
        
        payTableViewCell *payCell = [tableView dequeueReusableCellWithIdentifier:PayCellIdentifier forIndexPath:indexPath];
        [payCell setDelegate:self];
        [payCell setUpCellPayWithIndexPath:indexPath selectedRow:_selectedPayRow];
        return payCell;
    }

}

#pragma mark - UITableViewdelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (self.adressModel) {
            return 70;
        }
        return 45;
        
    } else if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            return 40;
        } else {
            return 60;
        }
        
    } else if (indexPath.section == 2) {
        return 40;
    } else {
        return 40;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 3) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
        UILabel *labe = [[UILabel alloc] initWithFrame:view.bounds];
        labe.text = @"    支付方式";
        labe.textColor = [UIColor themeBlackColor];
        labe.font = [UIFont systemFontOfSize:14.0];
        labe.textAlignment = NSTextAlignmentLeft;
        [view addSubview:labe];
        return view;
    } else  {
        return [UIView new];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0 || section == 1 || section == 2) {
        return 10;
    } else {
        return 50;
    }
}

#pragma mark - PayCellDelegate

- (void)didSelectedIndexPathRow:(NSInteger)row {
    _selectedPayRow = row;
    
    NSIndexSet *set = [[NSIndexSet alloc] initWithIndex:3];
    [self.orderTableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
    
}


#pragma mark - AdressDelegate

- (void)addAdressAction {
    
    EditViewController *editVC = [[EditViewController alloc] init];
    editVC.adressModel = self.adressModel;
    [self pushToNextNavigationController:editVC];
    
}



#pragma mark - lazyLoading

- (UITableView *)orderTableView {
    if (!_orderTableView) {
        _orderTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-64-50) style:UITableViewStylePlain];
        _orderTableView.backgroundColor = kRGBColor(246, 247, 248);
        _orderTableView.dataSource = self;
        _orderTableView.delegate = self;
        _orderTableView.tableFooterView = [UIView new];
        _orderTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_orderTableView];
    }
    return _orderTableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
