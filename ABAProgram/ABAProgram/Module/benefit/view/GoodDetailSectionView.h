//
//  GoodDetailSectionView.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/4.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsDetailModel.h"


typedef void(^ChooseDetailStyle)(DetailStyle style);

@interface GoodDetailSectionView : UIView

@property (nonatomic, strong) GoodsDetailModel *detailModel;
- (void)didSelectedTab:(ChooseDetailStyle)style;

@end
