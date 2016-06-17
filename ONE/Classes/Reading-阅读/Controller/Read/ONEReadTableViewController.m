//
//  ONEReadTableViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/14.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEReadTableViewController.h"
#import "ONEReadPastListViewController.h"


@implementation ONEReadTableViewController

static NSString *const readCell = @"readCell";

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

- (ONEReadCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     ONEReadCell *cell = [tableView dequeueReusableCellWithIdentifier:readCell];
    
    return cell;
}


- (UIView *)tableFooterView
{
    UIView *footerView = [UIView new];
    footerView.height = 54;
    
    UIButton *footerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [footerBtn setBackgroundColor:ONEColor(250, 250, 250, 1)];
    [footerBtn addTarget:self action:@selector(footerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerBtn setFrame:CGRectMake(ONEDefaultMargin, 0, ONEScreenWidth - 20, footerView.height - 10)];
    [footerBtn setTitle:@"查看往期作品" forState:UIControlStateNormal];
    footerBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [footerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    footerBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    footerBtn.layer.borderWidth = 0.4f;
    footerBtn.layer.shouldRasterize = true;
    footerBtn.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    footerBtn.layer.cornerRadius = 5.0;
    
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
