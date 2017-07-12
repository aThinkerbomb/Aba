//
//  CommentTableViewCell.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/6.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "CommentTableViewCell.h"

@interface CommentTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIButton *zanNumber;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *message;

@property (nonatomic, strong) videoCommentModel *commentModel;

@end

@implementation CommentTableViewCell

- (void)setupCommentCellWithCommentModel:(videoCommentModel *)commentModel {
    _commentModel = commentModel;
    if (_commentModel) {
        
//        [self.headerImage sd_setImageWithURL:[NSURL URLWithString:_commentModel.sysUserInfo.userimg] placeholderImage:[UIImage imageNamed:@"headerImage"]];
        [self.headerImage setImage:[UIImage imageNamed:@"headerImage"]];
        self.userName.text = _commentModel.sysUserInfo.username;
        [self.zanNumber setTitle:_commentModel.topnum forState:UIControlStateNormal];
        self.time.text = [NSDate getDateFromDateString:_commentModel.creattime withDateFormatter:@"MM-dd HH:mm"];
        self.message.text = _commentModel.content;
        
    }
}

- (IBAction)ZanClicked:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedZan:)]) {
        [self.delegate didSelectedZan:self.row];
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
