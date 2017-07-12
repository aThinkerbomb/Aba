//
//  HistoryViewController.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/12.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "HistoryViewController.h"
#import "HistoryTableViewCell.h"
#import "HistoryWatchApi.h"
#import "HistoryModel.h"


static NSString *historyCellIdentifier = @"HistoryTableViewCell";

@interface HistoryViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *historyTableView;
@property (nonatomic, strong) NSArray * dataSource;

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"历史观看";
    
    self.dataSource = [NSArray array];
}

- (void)setupController {
    [super setupController];
    
    [self.historyTableView registerNib:[UINib nibWithNibName:@"HistoryTableViewCell" bundle:nil] forCellReuseIdentifier:historyCellIdentifier];
    
    [self requestHistoryData];
}

#pragma mark - 历史观看数据请求

- (void)requestHistoryData {
    
    [self showLoadingView:YES];
    HistoryWatchApi * historyApi = [[HistoryWatchApi alloc] initWithHistoryWatch];
    [historyApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self showLoadingView:NO];
        
        if ([ABAConfig checkResponseObject:request.responseObject]) {
            
            self.dataSource = [HistoryModel mj_objectArrayWithKeyValuesArray:request.responseObject[@"body"]];
            
            [self.historyTableView reloadData];
            
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self showLoadingView:NO];
    }];
    
}




#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:historyCellIdentifier forIndexPath:indexPath];
    [cell setHistoryModel:self.dataSource[indexPath.row]];
    return cell;
    
    
}




#pragma mark - lazyLoading

- (UITableView *)historyTableView {
    if (!_historyTableView) {
        _historyTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-64) style:UITableViewStylePlain];
        _historyTableView.dataSource = self;
        _historyTableView.delegate = self;
        _historyTableView.rowHeight = 100;
        _historyTableView.tableFooterView = [UIView new];
        [self.view addSubview:_historyTableView];
    }
    return _historyTableView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
