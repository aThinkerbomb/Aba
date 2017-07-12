//
//  HomeVideoSectionView.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/6.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeVideSectionViewDelegate;


@interface HomeVideoSectionView : UIView

@property (nonatomic, assign)id<HomeVideSectionViewDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIButton *CommentBtn;
@property (weak, nonatomic) IBOutlet UIButton *IntroBtn;

@end

@protocol HomeVideSectionViewDelegate <NSObject>

- (void)didSelectedSection:(NSInteger)sectionIndex;

@end
