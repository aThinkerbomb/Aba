//
//  ArticleTableViewCell.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/30.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SchoolArticleModel.h"
#import "DaRenArticleModel.h"
@interface ArticleTableViewCell : UITableViewCell

// 亲子学堂 -> 文章
- (void)startSetupArticelCellWith:(SchoolArticleModel *)articelModel;

// 亲子学堂 -> 达人 -> 文章
- (void)startSetupDarenArticleCellWith:(DaRenArticleModel *)articleModel;
@end
