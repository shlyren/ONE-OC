//
//  ONEReadTableViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/14.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import "ONEReadTableViewController.h"


@interface ONEReadTableViewController ()

@end

@implementation ONEReadTableViewController
NSString *const readCell = @"realCell";

- (NSArray *)readItems
{
    return nil;
}

#pragma mark - initital
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
  
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

@end
