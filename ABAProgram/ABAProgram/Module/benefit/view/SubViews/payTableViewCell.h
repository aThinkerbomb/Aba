//
//  payTableViewCell.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/10.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PayCellDelegate;

@interface payTableViewCell : UITableViewCell

@property (nonatomic, assign) id<PayCellDelegate>delegate;
- (void)setUpCellPayWithIndexPath:(NSIndexPath *)indexPath selectedRow:(NSInteger)selectedRow;

@end

@protocol PayCellDelegate <NSObject>

- (void)didSelectedIndexPathRow:(NSInteger)row;

@end
