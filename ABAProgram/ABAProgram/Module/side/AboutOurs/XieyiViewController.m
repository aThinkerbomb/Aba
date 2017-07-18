//
//  XieyiViewController.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/18.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "XieyiViewController.h"

@interface XieyiViewController ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation XieyiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"用户协议";
    
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"useragreement"
                                                          ofType:@"html"];
    NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath
                                                    encoding:NSUTF8StringEncoding
                                                       error:nil];
    [self.webView loadHTMLString:htmlCont baseURL:baseURL];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


- (void)setupController {
    [super setupController];
}

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        [self.view addSubview:_webView];
    }
    return _webView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that useragreementcan be recreated.
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
