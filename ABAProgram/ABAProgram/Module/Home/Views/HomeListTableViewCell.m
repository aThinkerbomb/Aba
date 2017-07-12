//
//  HomeListTableViewCell.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/27.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "HomeListTableViewCell.h"

@interface HomeListTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *aImage;
@property (weak, nonatomic) IBOutlet UILabel *aTitle;
@property (weak, nonatomic) IBOutlet UILabel *accessTitle;
@property (weak, nonatomic) IBOutlet UILabel *aPrice;
@property (weak, nonatomic) IBOutlet UILabel *aTime;
@property (weak, nonatomic) IBOutlet UILabel *aBrowseNumber;
@property (weak, nonatomic) IBOutlet UIButton *playBackButton;



@end


@implementation HomeListTableViewCell
{
    HomePlayModel *_homeModel;
}

- (void)startBuildHomeCellWith:(HomePlayModel *)homeModel
{
    _homeModel = homeModel;
    
    NSString *urlString = _homeModel.bannerurl;
    if ([ABAConfig IsChinese:urlString]) {
        urlString = [_homeModel.bannerurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    
    [self.aImage sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.aTitle.text = _homeModel.streamname;
    self.accessTitle.text = _homeModel.sysUserInfo.username;
    if ([_homeModel.price doubleValue] == 0) {
        self.aPrice.text = @"免费";
    } else {
        self.aPrice.text = _homeModel.price;
    }
    
    self.aTime.text = [NSDate getDateFromDateString:_homeModel.creattime withDateFormatter:@"MM-dd HH:mm"];
    self.aBrowseNumber.text = _homeModel.looknum;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.aPrice.layer.cornerRadius = 4;
    self.aPrice.layer.borderColor = kRGBColor(253, 170, 157).CGColor;
    self.aPrice.layer.borderWidth = 1;
    self.aPrice.layer.masksToBounds = YES;
    
    self.aImage.layer.cornerRadius = 3;
    self.aImage.layer.borderColor = kRGBColor(220, 220, 220).CGColor;
    self.aImage.layer.borderWidth = 0.5;
    self.aImage.layer.masksToBounds = YES;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
