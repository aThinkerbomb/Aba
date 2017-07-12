//
//  BenefitDetailHeaderView.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/3.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "BenefitDetailHeaderView.h"
#import "CycleScrollView.h"
@interface BenefitDetailHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *scend;
@property (weak, nonatomic) IBOutlet UILabel *minute;
@property (weak, nonatomic) IBOutlet UILabel *hour;
@property (weak, nonatomic) IBOutlet UIView *cycBackgroundView;
@property (weak, nonatomic) IBOutlet UILabel *info;
@property (weak, nonatomic) IBOutlet UILabel *saleNumber;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation BenefitDetailHeaderView
{
    int _mySeconds;
}

- (void)setDetailModel:(GoodsDetailModel *)detailModel {
    _detailModel = detailModel;
    
    if (_detailModel != nil) {
        NSDate *start = [NSDate dateWithTimeIntervalSince1970:[_detailModel.starttime doubleValue]/1000];
        NSDate *end   = [NSDate dateWithTimeIntervalSince1970:[_detailModel.endtime   doubleValue]/1000];
        NSTimeInterval seconds = [end timeIntervalSinceDate:start];
        
        // 设置倒计时秒数
        _mySeconds = seconds;
        
        int ahour = seconds/3600;
        int aminute = (seconds - (ahour * 3600))/60;
        int asecond = seconds - aminute*60 - ahour*3600;
        
        self.hour.text = [NSString stringWithFormat:@"%d", ahour];
        self.minute.text = [NSString stringWithFormat:@"%d", aminute];
        self.scend.text = [NSString stringWithFormat:@"%d", asecond];
        
        // 初始化倒计时
        [self initTimer];
        
        self.info.text = _detailModel.goodsname;//@"贝贝熊-畅销40余年，发行2.4亿，影响两代人；孩子们成长初期的启蒙书；适合阅读年龄：3～9岁。";
        self.saleNumber.text = [NSString stringWithFormat:@"已售%@件宝贝", _detailModel.ordernumber];
        
        NSMutableArray *imageStrArr = [NSMutableArray array];
        [imageStrArr removeAllObjects];
        for (detailuPreGPList *preGPModel in _detailModel.uPreGPList) {
            
            NSString *urlString = preGPModel.photourl;
            
            if ([ABAConfig IsChinese:urlString]) {
                urlString = [preGPModel.photourl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            }
            [imageStrArr addObject:urlString];
        }
        
        // 轮播图
        
        if (imageStrArr.count > 0) {
            
            CycleScrollView *cycleView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW/5*4) totleCount:[_detailModel.uPreGPList count] currentIndexShow:^(NSInteger currentIndex, UIImageView *imageView) {
                
                [imageView sd_setImageWithURL:[NSURL URLWithString:imageStrArr[currentIndex]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
                
            } sourceHandler:^(NSInteger indexClick) {
                
                
            }];
            [cycleView startScrollAnimation];
            [self.cycBackgroundView addSubview:cycleView];
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
    self.scend.text = [NSString stringWithFormat:@"%d", asecond];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
