//
//  ONEReadDetailViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/14.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import "ONEReadDetailViewController.h"
#import "ONEReadToolBarView.h"
#import "UITableView+Extension.h"


@interface ONEReadDetailViewController ()<ONEReadDetailHeaderViewDelegate>

@end

@implementation ONEReadDetailViewController

- (ONEReadDetailHeaderView *)headerView
{
    if (_headerView == nil) {
        ONEReadDetailHeaderView *headerView = [ONEReadDetailHeaderView detailHeaderView];
        headerView.height = 100;
        headerView.delegate = self;
        _headerView = headerView;
        self.tableView.tableHeaderView = headerView;
    }
    
    return _headerView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadDetailData];
    
    [self setupToolBar];
}

- (void)setupToolBar
{
    ONEReadToolBarView *toolBarView = [ONEReadToolBarView toolBarView];
    toolBarView.frame = CGRectMake(0, self.tableView.height - 44, ONEScreenWidth, 44);
    [self.view addSubview:toolBarView];
    
}
- (void)loadDetailData{}

#pragma mark - ONEReadDetailHeaderViewDelegate
- (void)readDetailHeaderView:(ONEReadDetailHeaderView *)detailHeaderView didChangedHeight:(CGFloat)height
{
    self.headerView.height = height;
    self.tableView.tableHeaderView = self.headerView;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    [tableView tableViewShowMessage:@"" numberOfRows:0];
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}

@end
