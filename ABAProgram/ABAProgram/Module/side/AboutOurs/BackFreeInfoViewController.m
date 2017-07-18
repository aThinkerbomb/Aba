//
//  BackFreeInfoViewController.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/18.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "BackFreeInfoViewController.h"
#import "FeedBackApi.h"

@interface BackFreeInfoViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *bigBGView;
@property (weak, nonatomic) IBOutlet UITextView *infoText;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UILabel *placeholder;



@end

@implementation BackFreeInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"信息反馈";
    
}
- (IBAction)subMitAction:(UIButton *)sender {
    
    [self showLoadingView:YES];
    
    FeedBackApi *api = [[FeedBackApi alloc] initWithFeedBack:self.infoText.text];
    
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self showLoadingView:NO];
        
        if ([ABAConfig checkResponseObject:request.responseObject]) {
            
            __weak typeof(self)WeakSelf = self;
            
            [self showTipsMsg:@"反馈成功" delayDo:^{
                
                [WeakSelf popBack];
                
                
            }];
            
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self showLoadingView:NO];
    }];
    

    
}


- (void)setupController {
    [super setupController];
    
    self.submitBtn.layer.cornerRadius = 6;
    self.submitBtn.layer.masksToBounds = YES;

    
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    if (textView.isFirstResponder) {
        self.placeholder.hidden = YES;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    if ([textView.text isEqualToString:@""]) {
        self.placeholder.hidden = NO;
    } else {
        self.placeholder.hidden = YES;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
