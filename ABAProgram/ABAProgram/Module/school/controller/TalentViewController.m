//
//  TalentViewController.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/1.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "TalentViewController.h"
#import "ArticleTableViewCell.h"
#import "DaRenArticleApi.h"
#import "DaRenArticleModel.h"
#import "ABAWebViewController.h"
static NSString *articleCellIdentifier = @"ArticleTableViewCell";


@interface TalentViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation TalentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"文章";
    
    self.dataSource = [NSArray array];
}


- (void)setupController
{
    [super setupController];
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"ArticleTableViewCell" bundle:nil] forCellReuseIdentifier:articleCellIdentifier];
    
    [self requestArticleData];
}

#pragma mark - requestData
- (void)requestArticleData {
    
    [self showLoadingView:YES];
    
    DaRenArticleApi *articleApi = [[DaRenArticleApi alloc] initWithDaRenid:self.darenId];
    
    [articleApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        [self showLoadingView:NO];
        
        if ([ABAConfig checkResponseObject:request.responseObject]) {
            
            self.dataSource = [DaRenArticleModel mj_objectArrayWithKeyValuesArray:[request.responseObject objectForKey:@"body"]];
            
            [self.myTableView reloadData];
            
        } else {
            [self showTipsMsg:@"数据错误"];
        }
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self showLoadingView:NO];
        [self showTipsMsg:@"网络请求错误"];
    }];
    
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ArticleTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:articleCellIdentifier forIndexPath:indexPath];
    [cell startSetupDarenArticleCellWith:self.dataSource[indexPath.row]];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ABAWebViewController *webVC = [[ABAWebViewController alloc] init];
    
    DaRenArticleModel *darenRrtModel = [self.dataSource objectAtIndex:indexPath.row];
    webVC.urlString = [ABA_HTML stringByAppendingPathComponent:darenRrtModel.articleurl];
    [self pushToNextNavigationController:webVC];
    
}


#pragma mark - lazyloading
- (UITableView *)myTableView
{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - 64) style:UITableViewStylePlain];
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
        _myTableView.tableFooterView = [UIView new];
        _myTableView.rowHeight = 110;
        [self.view addSubview:_myTableView];
    }
    return _myTableView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
