//
//  SchoolSectionView.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/28.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SchoolAlbumModel.h"
#import "SchoolDaRenModel.h"

typedef NS_ENUM(NSInteger, SectionType) {
    
    SectionTypeExpert = 1,
    SectionTypeTalect
    
};


@protocol SchoolSectionViewDelegate;

@interface SchoolSectionView : UIView

@property (nonatomic, assign)id <SchoolSectionViewDelegate> delegate;
@property (nonatomic, assign) NSInteger section; //如果需要代理，必传

// 专家样式
- (void)startSetupExpetSectionViewWith:(SchoolAlbumModel *)expertModel sectionType:(SectionType)type tableView:(UITableView *)tableView;

// 达人样式
- (void)startSetupTalentSectionViewwith:(SchoolDaRenModel *)TalecntModel sectionType:(SectionType)type tableView:(UITableView *)tableView;
@end


@protocol SchoolSectionViewDelegate <NSObject>

// section 点击view
- (void)didSelectedSection:(NSInteger)section tableView:(UITableView *)tableView;

// section 点击简介button
- (void)didSelectedIntroduceOfSection:(NSInteger)section open:(BOOL)open tableView:(UITableView *)tableView;

@end
