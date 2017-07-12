//
//  ParameterTableViewCell.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/5.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParameterTableViewCell : UITableViewCell

@property (nonatomic, strong) NSArray * parameterArr;

+ (CGFloat)getHeightWithParameter:(NSArray *)paratemer;

@end
