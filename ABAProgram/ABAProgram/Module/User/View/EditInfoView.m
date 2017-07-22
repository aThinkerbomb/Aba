//
//  EditInfoView.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/22.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "EditInfoView.h"

@interface EditInfoView ()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;

@property (nonatomic, copy) ChooseHandle handle;
@property (nonatomic, strong) NSIndexPath *indexpath;

@end

@implementation EditInfoView

- (void)setUpEditWithIndexpath:(NSIndexPath *)indxpath {
    
    _indexpath = indxpath;
    
    if (_indexpath.section == 0 && _indexpath.row == 2) {
        self.title.text = @"编辑关系";
        [self.btn1 setTitle:@"妈妈" forState:UIControlStateNormal];
        [self.btn2 setTitle:@"爸爸" forState:UIControlStateNormal];
    }
    
    if (_indexpath.section == 1 && _indexpath.row == 1) {
        self.title.text = @"编辑性别";
        [self.btn1 setTitle:@"公主" forState:UIControlStateNormal];
        [self.btn2 setTitle:@"王子" forState:UIControlStateNormal];
    }
    
}


- (IBAction)chooseAction:(UIButton *)sender {

    if (self.handle) {
        self.handle(self.indexpath, sender.titleLabel.text);
    }

}

- (void)Chooseproperty:(ChooseHandle)handle {
    if (handle) {
        self.handle = handle;
    }
}


@end
