//
//  BabyListTableViewCell.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/27.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "BabyListTableViewCell.h"
#import "BabyTeachModel.h"
@interface BabyListTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *bImage;
@property (weak, nonatomic) IBOutlet UILabel *bTitleName;
@property (weak, nonatomic) IBOutlet UILabel *serviceTime;
@property (weak, nonatomic) IBOutlet UILabel *bYears;
@property (weak, nonatomic) IBOutlet UILabel *distance;



@end

@implementation BabyListTableViewCell
{
    BabyTeachModel *_babyModel;
}
- (void)startBuildBabyListCellWith:(BabyTeachModel *)babyModel
{
    _babyModel = babyModel;
    
    NSString *urlString = _babyModel.institutionlogo;
    if ([ABAConfig IsChinese:urlString]) {
        urlString = [_babyModel.institutionlogo stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    
    [self.bImage sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.bTitleName.text = _babyModel.institutionname;
    NSArray *array = [_babyModel.remark componentsSeparatedByString:@"<br />"];
    
    self.serviceTime.text = array[1];
    self.bYears.text = array[2];
    
    CGFloat distance = [_babyModel.distance floatValue];
    
    self.distance.text = [NSString stringWithFormat:@"%.2fkm", distance];
    
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.bImage.layer.cornerRadius = 3;
    self.bImage.layer.borderColor = kRGBColor(220, 220, 220).CGColor;
    self.bImage.layer.borderWidth = 0.5;
    self.bImage.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
