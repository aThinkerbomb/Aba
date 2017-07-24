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
#import "XMLReader.h"
#import "ZFBPayApi.h"
#import "WXPayApi.h"
#import "WXPayModel.h"

#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>

#define WeiXinAppKey @"wx909f8c29eb7ddae2"

static NSString * AdressCellIdentifier    = @"AdressTableViewCell";
static NSString * OrangeCellIdentifier    = @"OrangeTableViewCell";
static NSString * CommodityCellIdentifier = @"CommodityTableViewCell";
static NSString * PriceInfoCellIdentifier = @"PriceInfoTableViewCell";
static NSString * PayCellIdentifier       = @"payTableViewCell";


@interface OrderViewController ()<UITableViewDelegate, UITableViewDataSource, PayCellDelegate, AdressDelegate, ConfirmPayDelegate>

@property (nonatomic, strong) UITableView *orderTableView;
@property (nonatomic, strong) GetReceiptAdressModel *adressModel; // 收获地址model。
@property (nonatomic, strong) ConfirmPayView * confirmPayView;    // 支付view


@end

@implementation OrderViewController
{
    NSInteger _selectedPayRow; // 0--微信支付  1--支付支付
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"确认订单";
    _selectedPayRow = 0;
    
    // 获取地址通知 重新请求一下
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadRequestData) name:@"reload" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WeiXinPayResult:) name:@"WXpayResult" object:nil];
    
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
        _confirmPayView.delegaet = self;
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

// 微信请求数据
- (void)requestWeixinData {
    
    [self showLoadingView:YES];
    NSInteger p = [self.benefitModel.newprice doubleValue]*100;
    NSString *price = [NSString stringWithFormat:@"%lu", (long)p];
    WXPayApi *wxApi = [[WXPayApi alloc] initWithGoodsid:self.benefitModel.benefitId isPre:@"0" totalPrice:price goodsname:@"YCCIT"];
    [wxApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        [self showLoadingView:NO];
        
        NSString *xmlStr = request.responseObject[@"body"];
        NSError *error;
        NSDictionary *dic = [XMLReader dictionaryForXMLString:xmlStr error:&error];
        NSLog(@"dicdic = %@", dic);
        
        [self TuneUpWeiXinRequestWithWXPAyModel:[self setWXPayModel:dic[@"xml"]]];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        [self showLoadingView:NO];
        
        NSLog(@"error = %@", request.error);
    }];
    
    
}

// 支付宝请求数据
- (void)requestZFBData {
    
    [self showLoadingView:YES];
    
    ZFBPayApi *api = [[ZFBPayApi alloc] initWithGoodsid:self.benefitModel.benefitId isPre:@"0" totalPrice:self.benefitModel.newprice goodsname:@"YCCIT"];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        [self showLoadingView:NO];
        
        // 调起支付宝
        [self TuneUpZFBRequestWithOrderStr:request.responseObject[@"body"]];
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        [self showLoadingView:NO];
        NSLog(@"error = %@", request.error);
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

#pragma mark - PayCellDelegate (选择 微信、支付宝 支付)

- (void)didSelectedIndexPathRow:(NSInteger)row {
    _selectedPayRow = row;
    
    NSIndexSet *set = [[NSIndexSet alloc] initWithIndex:3];
    [self.orderTableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
    
}


#pragma mark - ConfirmPayDelegate (确认支付代理)

- (void)confirmPayAction {
    
    if (self.adressModel) {
        
        if (_selectedPayRow == 0) {
            
            // 微信支付
            [self requestWeixinData];
            
        } else if (_selectedPayRow == 1) {
            
            // 支付宝支付
            [self requestZFBData];
            
        }
        
    } else {
        [self showTipsMsg:@"请填写收货地址"];
    }
    
}

#pragma mark - 调起微信支付
/**
 调起微信支付
 */
- (void)TuneUpWeiXinRequestWithWXPAyModel:(WXPayModel *)payModel {
    
    if ([WXApi isWXAppSupportApi]) {
        
        [WXApi registerApp:WeiXinAppKey enableMTA:YES];
        
        // 生成随机数
        NSString * nonceStr = [ABAConfig acrRandow];
        
        // 当前时间戳
        NSString * timestamp = [NSDate getCurrentTimestamp];
        
        // 生成sign签名partnerId
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:WeiXinAppKey forKey:@"appid"];
        [dic setObject:nonceStr forKey:@"noncestr"];
        [dic setObject:@(timestamp.intValue) forKey:@"timestamp"];
        [dic setObject:ABA_WX_Partnerid forKey:@"partnerid"];
        [dic setObject:payModel.prepayId forKey:@"prepayid"];
        [dic setObject:@"Sign=WXPay" forKey:@"package"];
        NSString * sign = [ABAConfig getSignFieldFromRequestDictionary:dic];
        
        // 后台服务器返回少时间戳 只能自己计算
        PayReq *request = [[PayReq alloc] init];
        request.partnerId = ABA_WX_Partnerid;
        request.prepayId= payModel.prepayId;
        request.nonceStr= nonceStr;
        request.package = @"Sign=WXPay";
        request.timeStamp= timestamp.intValue;
        request.sign= sign;
        [WXApi sendReq:request];
        
        
// 调起微信支付
//        PayReq *request = [[PayReq alloc] init];
//        request.partnerId = payModel.partnerId;
//        request.prepayId= payModel.prepayId;
//        request.nonceStr= payModel.nonceStr;
//        request.package = payModel.package;
//        request.timeStamp= payModel.timeStamp;
//        request.sign= payModel.sign;
//        [WXApi sendReq:request];
        
    } else {
        [self showTipsMsg:@"未安装微信或请升级微信版本"];
    }
    
}


#pragma mark - 调起 支付宝支付
- (void)TuneUpZFBRequestWithOrderStr:(NSString *)orderStr {
    if (orderStr != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"ali2017041406709494";
        
        __weak typeof(self)WeakSelf = self;
        
        // 调起支付宝
        [[AlipaySDK defaultService] payOrder:orderStr fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            
            
            // 支付成功。
            if ([resultDic[@"resultStatus"] intValue] == 9000) {
                [WeakSelf showTipsMsg:@"支付成功"];
                
            } else {
                [WeakSelf showTipsMsg:resultDic[@"memo"]];
            }
        }];
    }
}


#pragma mark - 设置自定义 微信支付 model

- (WXPayModel *)setWXPayModel:(NSDictionary *)dic {
    WXPayModel *payModel = [[WXPayModel alloc] init];
    payModel.prepayId = dic[@"prepay_id"][@"text"];
    payModel.nonceStr = dic[@"nonce_str"][@"text"];
    payModel.partnerId = dic[@"mch_id"][@"text"];
    payModel.sign = dic[@"sign"][@"text"];
    payModel.package = @"Sign=WXPay";
    NSString *time = [NSDate getCurrentTimestamp];
    payModel.timeStamp = time.intValue;
    
    
    return payModel;
}

#pragma mark - 微信支付回调 通知
- (void)WeiXinPayResult:(NSNotification *)notification {
    NSDictionary *dic = notification.userInfo;
    if ([dic[@"errorCode"] intValue] == WXSuccess) {
        [self showTipsMsg:@"支付成功"];
        
    } else {
        [self showTipsMsg:@"支付失败"];
    }
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

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
