//
//  BenefitViewController.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/22.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "BenefitViewController.h"
#import "BenefitGoodsApi.h"
#import "BenefitModel.h"
#import "CycleScrollView.h"
#import "BenefitDetailViewController.h"
#import "OrderViewController.h"
@interface BenefitViewController ()
{
    int _mySeconds;
}

@property (weak, nonatomic) IBOutlet UILabel *second;
@property (weak, nonatomic) IBOutlet UILabel *minute;
@property (weak, nonatomic) IBOutlet UILabel *hour;
@property (weak, nonatomic) IBOutlet UIView *cycView;
@property (weak, nonatomic) IBOutlet UILabel *goodsname;
@property (weak, nonatomic) IBOutlet UILabel *newprice;
@property (weak, nonatomic) IBOutlet UILabel *oldprice;
@property (weak, nonatomic) IBOutlet UILabel *ordernumber;
@property (weak, nonatomic) IBOutlet UIButton *comeBuy;

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation BenefitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"一天一惠";
    self.dataSource = [NSArray array];
    
    //数据请求
    [self requestBeneGoods];
}

- (void)setupController
{
    [super setupController];
    
    // 设置头像
    NSString *imagerString = [KZUserDefaults objectForKey:@"userimg"];
    if ([imagerString isEqualToString:@""]) {
        UIImage *imager = [UIImage imageNamed:@"headerImage"];
        [self setNaviLeftItemNormalImage:imager HighlightedIamge:imager];
    } else {
        [self setNaviLeftItemNormalImage:imagerString HighlightedIamge:imagerString];
    }
    
    self.hour.layer.cornerRadius = 4;
    self.hour.layer.masksToBounds = YES;
    
    self.minute.layer.cornerRadius = 4;
    self.minute.layer.masksToBounds = YES;
    
    self.second.layer.cornerRadius = 4;
    self.second.layer.masksToBounds = YES;
    
    self.comeBuy.layer.cornerRadius = 4;
    self.comeBuy.layer.masksToBounds = YES;
    
    
    
}

// 初始化数据
- (void)initViewDataSource {
    
    BenefitModel *model = self.dataSource[0];
    
    if (model != nil) {
        NSDate *start = [NSDate dateWithTimeIntervalSince1970:[model.starttime doubleValue]/1000];
        NSDate *end   = [NSDate dateWithTimeIntervalSince1970:[model.endtime   doubleValue]/1000];
        NSTimeInterval seconds = [end timeIntervalSinceDate:start];
        
        // 设置倒计时秒数
        _mySeconds = seconds;
        
        int ahour = seconds/3600;
        int aminute = (seconds - (ahour * 3600))/60;
        int asecond = seconds - aminute*60 - ahour*3600;
        
        self.hour.text = [NSString stringWithFormat:@"%d", ahour];
        self.minute.text = [NSString stringWithFormat:@"%d", aminute];
        self.second.text = [NSString stringWithFormat:@"%d", asecond];
        
        // 初始化倒计时
        [self initTimer];
        
        self.goodsname.text = model.goodsname;
        self.newprice.text = [NSString stringWithFormat:@"¥ %@", model.newprice];
        self.oldprice.text = [NSString stringWithFormat:@"¥ %@", model.oldprice];
        self.ordernumber.text = [NSString stringWithFormat:@"已售%@件宝贝", model.ordernumber];
        
        NSMutableArray *imageStrArr = [NSMutableArray array];
        [imageStrArr removeAllObjects];
        for (uPreGPList *preGPModel in model.uPreGPList) {
            
            NSString *urlString = preGPModel.photourl;
            
            if ([ABAConfig IsChinese:urlString]) {
                urlString = [preGPModel.photourl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            }
            [imageStrArr addObject:urlString];
        }
        
        // 轮播图
        
        if (imageStrArr.count > 0) {
            
            CGRect rect = self.cycView.bounds;
            __weak typeof(self)weakSelf = self;
            CycleScrollView *cycleView = [[CycleScrollView alloc] initWithFrame:rect totleCount:[model.uPreGPList count] currentIndexShow:^(NSInteger currentIndex, UIImageView *imageView) {
                
                [imageView sd_setImageWithURL:[NSURL URLWithString:imageStrArr[currentIndex]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
                
            } sourceHandler:^(NSInteger indexClick) {
                BenefitDetailViewController *detailVC = [[BenefitDetailViewController alloc] init];
                detailVC.hidesBottomBarWhenPushed = YES;
                detailVC.goodId = model.benefitId;
                [weakSelf pushToNextNavigationController:detailVC];
                
                
            }];
            [cycleView startScrollAnimation];
            [self.cycView addSubview:cycleView];
        }
    }

}

#pragma mark - private Method

- (void)initTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(CountDownTime) userInfo:nil repeats:YES];
}

- (void)CountDownTime
{
    if (_mySeconds > 0) {
        
        _mySeconds--;
        
        // 倒计时
        [self setupCountDownTime];
        
    } else {
        
        [self.timer invalidate];
    }
}


- (void)setupCountDownTime
{
    int ahour = _mySeconds/3600;
    int aminute = (_mySeconds - (ahour * 3600))/60;
    int asecond = _mySeconds - aminute*60 - ahour*3600;
    
    self.hour.text = [NSString stringWithFormat:@"%d", ahour];
    self.minute.text = [NSString stringWithFormat:@"%d", aminute];
    self.second.text = [NSString stringWithFormat:@"%d", asecond];
}


#pragma mark - 数据请求
- (void)requestBeneGoods
{
    [self showLoadingView:YES];
    BenefitGoodsApi *goodsApi = [[BenefitGoodsApi alloc] initWithBenefitGoods];
    [goodsApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self showLoadingView:NO];
        
        if ([ABAConfig checkResponseObject:request.responseObject]) {
            
            self.dataSource = [BenefitModel mj_objectArrayWithKeyValuesArray:[request.responseObject  objectForKey:@"body"]];
            
            [self initViewDataSource];
            
        } else {
            [self showTipsMsg:@"暂无抢购"];
        }
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self showLoadingView:NO];
        [self showTipsMsg:@"网络请求错误"];
    }];
}

- (IBAction)ComeOnBuyAction:(UIButton *)sender {
    
    if ([ABAConfig isEmptyOfObj:self.dataSource]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"抢购未开始，敬请期待！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        
    } else {
        OrderViewController *orderVC = [[OrderViewController alloc] init];
        orderVC.hidesBottomBarWhenPushed = YES;
        orderVC.benefitModel = self.dataSource[0];
        [self pushToNextNavigationController:orderVC];
        
    }
    
}

- (void)leftButtonAction:(UIButton *)sender
{
    [self showLeftSideView];
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
