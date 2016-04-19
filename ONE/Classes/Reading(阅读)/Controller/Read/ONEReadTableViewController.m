//
//  ONEReadTableViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/14.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEReadTableViewController.h"
#import "ONEReadPastListViewController.h"


@interface ONEReadTableViewController ()

@end

@implementation ONEReadTableViewController
NSString *const readCell = @"realCell";

- (NSArray *)readItems
{
    return nil;
}
- (NSString *)endDate
{
    return @"2012-10";
}
- (NSString *)readType
{
    return nil;
}

#pragma mark - initital
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
    
    self.tableView.tableFooterView = self.tableFooterView;
  
}
- (void)setupView
{
    self.tableView.estimatedRowHeight = 120;
    self.tableView.contentInset = UIEdgeInsetsMake(ONEDefaultMargin + ONETitleViewH, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ONEReadCell class]) bundle:nil] forCellReuseIdentifier:readCell];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.readItems.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.readItems[indexPath.row] rowHeight];
}


- (UIView *)tableFooterView
{
    UIView *footerView = [UIView new];
    footerView.height = 54;
    
    UIButton *footerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [footerBtn setBackgroundImage:[UIImage imageNamed:@"common_button_white"] forState:UIControlStateNormal];
    [footerBtn addTarget:self action:@selector(footerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerBtn setFrame:CGRectMake(10, 0, ONEScreenWidth - 20, footerView.height - 10)];
    [footerBtn setTitle:@"查看往期作品" forState:UIControlStateNormal];
    footerBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [footerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [footerView addSubview:footerBtn];
    return footerView;
}

- (void)footerBtnClick:(UIButton *)footerBtn
{
    ONEReadPastListViewController *pastListVc = [ONEReadPastListViewController new];
    pastListVc.endMonth = self.endDate;
    pastListVc.readPastListType = self.readType;
    [self.navigationController pushViewController:pastListVc animated:true];
}

@end
