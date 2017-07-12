//
//  CommentTableViewCell.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/6.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "videoCommentModel.h"

@protocol CommentCellDelegate;

@interface CommentTableViewCell : UITableViewCell

@property (nonatomic, assign) NSInteger row;
@property (nonatomic, assign)id<CommentCellDelegate>delegate;

- (void)setupCommentCellWithCommentModel:(videoCommentModel *)commentModel;

@end

@protocol CommentCellDelegate <NSObject>

- (void)didSelectedZan:(NSInteger)index;

@end
