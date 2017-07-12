//
//  ABAWebViewController.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/30.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "ABAWebViewController.h"
#import <WebKit/WebKit.h>
@interface ABAWebViewController ()

@property (nonatomic, strong)WKWebView *webView;

@end

@implementation ABAWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"文章";

}

- (void)setupController
{
    [super setupController];
    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-64)];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    [self.view addSubview:self.webView];
    

}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
