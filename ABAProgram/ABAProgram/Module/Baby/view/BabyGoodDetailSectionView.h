//
//  BabyGoodDetailSectionView.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/1.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoIntroductionModel.h"
@protocol GoodDetailSectionViewDelegate;

@interface BabyGoodDetailSectionView : UIView

// 如果要继承协议 代理方法 必须传section
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, assign) id<GoodDetailSectionViewDelegate>delegate;

@property (nonatomic, strong) VideoIntroductionModel *videModel;

@end

@protocol GoodDetailSectionViewDelegate <NSObject>

- (void)didSelectedSection:(NSInteger)section;

@end
