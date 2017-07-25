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

@property (nonatomic, copy) UpdateUserInfoHandle update;
@property (nonatomic, copy) closeHandle close;

@end

@implementation EditUserBirthdayView

- (void)setUserModel:(UserLoginModel *)userModel {
    _userModel = userModel;
    if (_userModel) {
        
        // 异常处理
        NSString *birthday = _userModel.userbirthday;
        if ([birthday isEqualToString:@""]) {
            birthday = [NSDate getCurrentDateWithFormatter:@"yyyy-MM-dd"];
        }
        
        // yyyy-MM-dd转为date
        NSDate *date = [NSDate getCurrentDateWithDateString:birthday];
        // 计算年龄
        int age = [ABAConfig getAgeWithDateTimeInterval:[NSDate getSecondswithDate:date]];
        // 展示年龄
        self.age.text = [NSString stringWithFormat:@"%d岁", age];

        // 得到年 月
        NSString * month = [NSDate getMonthWithDate:date];
        NSString * day   = [NSDate getDayWithDate:date];
        
        // 展示星座
        self.Constellation.text = [ABAConfig calculateConstellationWithMonth:[month intValue] day:[day intValue]];
        
        // 展示生日
        self.birthday.text = birthday;
        
        // 设置datepicker
        self.birthdayPicker.date = [NSDate getCurrentDateWithDateString:birthday];
        
    }
    
}

- (IBAction)datePickerValueChange:(UIDatePicker *)sender {
    
    self.birthday.text = [NSDate getTimeWithdate:sender.date];
    
    int age = [ABAConfig getAgeWithDateTimeInterval:[NSDate getSecondswithDate:sender.date]];
    self.age.text = [NSString stringWithFormat:@"%d岁", age];
    
    NSString * month = [NSDate getMonthWithDate:sender.date];
    NSString * day   = [NSDate getDayWithDate:sender.date];
    
    self.Constellation.text = [ABAConfig calculateConstellationWithMonth:[month intValue] day:[day intValue]];
}

- (IBAction)Sure:(UIButton *)sender {
    
    if (self.update) {
        self.update(self.birthday.text);
    }
    
    
}
- (IBAction)Cancel:(UIButton *)sender {
    if (self.close) {
        self.close();
    }
    
}

- (void)ClickedSure:(UpdateUserInfoHandle)handle {
    if (handle) {
        self.update = handle;
    }
}

- (void)ClickedCancel:(closeHandle)handle {
    if (handle) {
        self.close = handle;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
