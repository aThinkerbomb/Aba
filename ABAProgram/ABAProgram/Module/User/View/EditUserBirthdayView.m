//
//  EditUserBirthdayView.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/22.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "EditUserBirthdayView.h"

@interface EditUserBirthdayView ()

@property (weak, nonatomic) IBOutlet UILabel *age;
@property (weak, nonatomic) IBOutlet UILabel *Constellation;
@property (weak, nonatomic) IBOutlet UILabel *birthday;
@property (weak, nonatomic) IBOutlet UIDatePicker *birthdayPicker;



@end

@implementation EditUserBirthdayView

- (void)setUserModel:(UserLoginModel *)userModel {
    _userModel = userModel;
    if (_userModel) {
        
        self.birthday.text = _userModel.userbirthday;
        self.birthdayPicker.date = [NSDate getCurrentDateWithDateString:_userModel.userbirthday];
        
    }
    
}


- (IBAction)Sure:(UIButton *)sender {
    
    NSLog(@" %@", [NSDate getTimeWithdate:self.birthdayPicker.date]);
    
    
}
- (IBAction)Cancel:(UIButton *)sender {
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
