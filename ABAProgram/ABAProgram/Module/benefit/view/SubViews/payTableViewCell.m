//
//  payTableViewCell.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/10.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "payTableViewCell.h"

@interface payTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *payImage;

@property (weak, nonatomic) IBOutlet UILabel *payName;
@property (weak, nonatomic) IBOutlet UIButton *ChooseBtn;
@property (nonatomic, strong) NSIndexPath *indexPatch;

@end


@implementation payTableViewCell

- (void)setUpCellPayWithIndexPath:(NSIndexPath *)indexPath selectedRow:(NSInteger)selectedRow {
    
    _indexPatch = indexPath;
    
    if (_indexPatch.row == 0) {
        [self.payImage setImage:[UIImage imageNamed:@"wx"]];
        self.payName.text = @"微    信";
    }
    if (_indexPatch.row == 1) {
        [self.payImage setImage:[UIImage imageNamed:@"zfb"]];
        self.payName.text = @"支付宝";
        
    }
    if (_indexPatch.row == selectedRow) {
        self.ChooseBtn.selected = YES;
    } else {
        self.ChooseBtn.selected = NO;
    }
}



- (IBAction)ChooseSelectedAction:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedIndexPathRow:)]) {
        [self.delegate didSelectedIndexPathRow:_indexPatch.row];
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
