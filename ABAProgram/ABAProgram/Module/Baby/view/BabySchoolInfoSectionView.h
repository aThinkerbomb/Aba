//
//  BabySchoolInfoSectionView.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/2.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntroductionModel.h"

@protocol SchoolInfoSectionViewDelegate;

@interface BabySchoolInfoSectionView : UIView

@property (nonatomic, assign)id<SchoolInfoSectionViewDelegate>delegate;
@property (nonatomic, strong) IntroductionModel *introductionModel;

@property (weak, nonatomic) IBOutlet UIImageView *JTImage;
@end


@protocol SchoolInfoSectionViewDelegate <NSObject>

- (void)didSelectionIntroduction;

@end
