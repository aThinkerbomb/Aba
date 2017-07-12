//
//  MyVideoViewController.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/12.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "MyVideoViewController.h"
#import "MyVideoApi.h"
@interface MyVideoViewController ()

@end

@implementation MyVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的视频";
}

- (void)setupController {
    [super setupController];
    
    
    // request
    [self requestMyVideo];
}

#pragma mark - 数据请求

- (void)requestMyVideo {
    
    [self showLoadingView:YES];
    MyVideoApi *myVideoApi = [[MyVideoApi alloc] initWithMyVideo];
    [myVideoApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        [self showLoadingView:NO];
        if ([ABAConfig checkResponseObject:request.responseObject]) {
            
        } else {
            [self showTipsMsg:@"暂时没有上传视频"];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self showLoadingView:NO];
    }];
    
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
