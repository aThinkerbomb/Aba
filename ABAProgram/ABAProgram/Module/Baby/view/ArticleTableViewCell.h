//
//  ArticleTableViewCell.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/30.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SchoolArticleModel.h"
@interface ArticleTableViewCell : UITableViewCell

- (void)startSetupArticelCellWith:(SchoolArticleModel *)articelModel;

@end
