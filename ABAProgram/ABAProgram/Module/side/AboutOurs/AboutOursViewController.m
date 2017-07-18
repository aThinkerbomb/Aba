//
//  AboutOursViewController.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/15.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "AboutOursViewController.h"
#import "GoodsIntroViewController.h"
#import "XieyiViewController.h"
#import "BackFreeInfoViewController.h"
@interface AboutOursViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *version;
@property (weak, nonatomic) IBOutlet UITableView *AboutTableView;
@property (nonatomic, strong) NSArray *dataSource;


@end

@implementation AboutOursViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.dataSource = [NSArray arrayWithObjects:@"产品介绍", @"用户协议", @"信息反馈", nil];
    
    self.version.text = [NSString stringWithFormat:@"v%@", [ABAConfig getCurrentVersion]];
    
    self.AboutTableView.tableFooterView = [UIView new];
    
    [self.AboutTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableViewCell"];
}

- (void)setupController {
    [super setupController];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.textLabel.textColor = [UIColor themeBlackColor];
    cell.textLabel.font = [UIFont systemFontOfSize:13.0];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        
        GoodsIntroViewController *goodsIntoVC = [[GoodsIntroViewController alloc] init];
        [self pushToNextNavigationController:goodsIntoVC];
        
    }
    
    if (indexPath.row == 1) {
        XieyiViewController *xieyiVC = [[XieyiViewController alloc] init];
        [self pushToNextNavigationController:xieyiVC];
    }
    if (indexPath.row == 2) {
        BackFreeInfoViewController *backFeedVC = [[BackFreeInfoViewController alloc] init];
        [self pushToNextNavigationController:backFeedVC];
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
