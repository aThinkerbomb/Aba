//
//  ArticleTableViewCell.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/30.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "ArticleTableViewCell.h"

@interface ArticleTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *arImage;
@property (weak, nonatomic) IBOutlet UILabel *arTitle;

@end


@implementation ArticleTableViewCell
{
    SchoolArticleModel *_articelModel;
    
    DaRenArticleModel *_DarenModel;
}

- (void)startSetupArticelCellWith:(SchoolArticleModel *)articelModel
{
    _articelModel = articelModel;
    
    if (![ABAConfig isEmptyOfObj:_articelModel]) {
        
        NSString *urlString = [ABA_IMAGE stringByAppendingString:_articelModel.imgurl];
        if ([ABAConfig IsChinese:urlString]) {
            urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
        
        [self.arImage sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        self.arTitle.text = _articelModel.articletitle;
        
    }
}


- (void)startSetupDarenArticleCellWith:(DaRenArticleModel *)articleModel {
    
    _DarenModel = articleModel;
    
    if (![ABAConfig isEmptyOfObj:_DarenModel]) {
        NSString *urlString = [ABA_IMAGE stringByAppendingString:_DarenModel.imgurl];
        if ([ABAConfig IsChinese:urlString]) {
            urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
        
        [self.arImage sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        self.arTitle.text = _DarenModel.articletitle;
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
