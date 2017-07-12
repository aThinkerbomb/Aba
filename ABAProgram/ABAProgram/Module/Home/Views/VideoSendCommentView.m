//
//  VideoSendCommentView.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/8.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "VideoSendCommentView.h"

@interface VideoSendCommentView ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *placeholdeLabel;

@property (nonatomic, copy) SendMessageHandle messageHandle;

@end

@implementation VideoSendCommentView

-(void)didSelectedSendMessage:(SendMessageHandle)message {
    if (message) {
        self.messageHandle = message;
    }
}


- (IBAction)SendAction:(UIButton *)sender {
    if (self.messageHandle) {
        self.messageHandle(_textView.text);
        
        [self.textView resignFirstResponder];
        self.textView.text = @"";
        self.placeholdeLabel.hidden = NO;
    }
    
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    if (textView.isFirstResponder) {
        self.placeholdeLabel.hidden = YES;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    if ([textView.text isEqualToString:@""]) {
        self.placeholdeLabel.hidden = NO;
    } else {
        self.placeholdeLabel.hidden = YES;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.textView.layer.cornerRadius = 4;
    self.textView.layer.borderColor = [UIColor themeDarkGrayColor].CGColor;
    self.textView.layer.borderWidth = 0.5;
    self.textView.layer.masksToBounds = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
