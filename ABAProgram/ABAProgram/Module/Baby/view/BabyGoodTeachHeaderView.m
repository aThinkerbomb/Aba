//
//  BabyGoodTeachHeaderView.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/3.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "BabyGoodTeachHeaderView.h"
#import "CycleScrollView.h"

@interface BabyGoodTeachHeaderView ()
@property (weak, nonatomic) IBOutlet UIView *BackgroundView;

@property (weak, nonatomic) IBOutlet UILabel *phoneNumber;
@property (weak, nonatomic) IBOutlet UILabel *adress;
@property (weak, nonatomic) IBOutlet UIView *FrontView;

@property (nonatomic, strong) CycleScrollView *cycView;

@end


@implementation BabyGoodTeachHeaderView


- (void)setIntroModel:(IntroductionModel *)introModel {
    _introModel = introModel;
    
    if (![ABAConfig isEmptyOfObj:_introModel]) {
        
        self.phoneNumber.text = [NSString stringWithFormat:@"电话：%@", _introModel.phonenumber];
        self.adress.text = [NSString stringWithFormat:@"地址：%@", _introModel.address];
    }
}


- (void)setImageArr:(NSArray *)imageArr {
    
    _imageArr = imageArr;
    
    if (_imageArr.count > 0) {
        
        CGRect rect = CGRectMake(0, 0, ScreenW, 300);

        CycleScrollView *cycleView = [[CycleScrollView alloc] initWithFrame:rect totleCount:[_imageArr count] currentIndexShow:^(NSInteger currentIndex, UIImageView *imageView) {
            
            NSString *urlString = [NSString stringWithFormat:@"%@%@", ABA_IMAGE, _imageArr[currentIndex]];
            
            if ([ABAConfig IsChinese:urlString]) {
                urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            }
            [imageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"placeholder"]];
            
        } sourceHandler:^(NSInteger indexClick) {
            NSLog(@"indexClick = %lu", indexClick);
        }];
        [cycleView startScrollAnimation];
        [self.BackgroundView addSubview:cycleView];
        
        [self.BackgroundView bringSubviewToFront:self.FrontView];
        
    }
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
