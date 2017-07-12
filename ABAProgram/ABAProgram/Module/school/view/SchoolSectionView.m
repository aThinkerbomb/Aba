//
//  SchoolSectionView.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/28.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "SchoolSectionView.h"

@interface SchoolSectionView ()
@property (weak, nonatomic) IBOutlet UIImageView *sImage;
@property (weak, nonatomic) IBOutlet UILabel *sTileNam;
@property (weak, nonatomic) IBOutlet UILabel *TyleName;
@property (weak, nonatomic) IBOutlet UILabel *Album;
@property (weak, nonatomic) IBOutlet UIImageView *jiantouImageView;


@end


@implementation SchoolSectionView
{
    SchoolAlbumModel *_expertModel;
    SchoolDaRenModel *_talentModel;
    
    SectionType _type;
    UITableView *_currentTablview;
}
- (void)startSetupExpetSectionViewWith:(SchoolAlbumModel *)expertModel sectionType:(SectionType)type tableView:(UITableView *)tableView
{
    
    _type = type;
    _currentTablview = tableView;
    _expertModel = expertModel;
    if (![ABAConfig isEmptyOfObj:_expertModel]) {
        
        self.TyleName.text = [NSString stringWithFormat:@"%@    ", _expertModel.albumname];
        
        self.sTileNam.text = _expertModel.lecturerName;
        
        NSString *urlString = _expertModel.imageurl;
        
        if ([ABAConfig IsChinese:urlString]) {
            urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }

        [self.sImage sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"placeholder"]];

        if (_expertModel.open) {
            [self.jiantouImageView setImage:[UIImage imageNamed:@"jiantoushang"]];
        } else {
            [self.jiantouImageView setImage:[UIImage imageNamed:@"jiantouxia"]];
        }
        
    }
}

- (void)startSetupTalentSectionViewwith:(SchoolDaRenModel *)TalecntModel sectionType:(SectionType)type tableView:(UITableView *)tableView
{
    
    _type = type;
    _currentTablview = tableView;
    _talentModel = TalecntModel;
    
    self.TyleName.hidden = YES;
    self.Album.hidden = YES;
    
    if (![ABAConfig isEmptyOfObj:_talentModel]) {
        
        self.sTileNam.text = _talentModel.darenname;
        
        NSString *urlString = _talentModel.imageurl;
        
        if ([ABAConfig IsChinese:urlString]) {
            urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
        
        [self.sImage sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
        if (_talentModel.open) {
            [self.jiantouImageView setImage:[UIImage imageNamed:@"jiantoushang"]];
        } else {
            [self.jiantouImageView setImage:[UIImage imageNamed:@"jiantouxia"]];
        }
        
    }
}

- (IBAction)pictureAction:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedSection:tableView:)]) {
        
        [self.delegate didSelectedSection:self.section tableView:_currentTablview];
    }
    
}


- (IBAction)jianjieAction:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedIntroduceOfSection:open:tableView:)]) {
        
        BOOL open;
        if (_type == SectionTypeExpert) {
            _expertModel.open = !_expertModel.open;
            open = _expertModel.open;
        } else {
            _talentModel.open = !_talentModel.open;
            open = _talentModel.open;
        }

        [self.delegate didSelectedIntroduceOfSection:self.section open:open tableView:_currentTablview];
    }
    
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.TyleName.layer.cornerRadius = 4;
    self.TyleName.layer.masksToBounds = YES;
    
    self.Album.layer.cornerRadius = 4;
    self.Album.layer.masksToBounds = YES;
}


@end
