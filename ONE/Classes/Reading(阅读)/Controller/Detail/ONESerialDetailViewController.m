//
//  ONESerialDetailViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/14.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import "ONESerialDetailViewController.h"
#import "ONESerialItem.h"

@interface ONESerialDetailViewController ()

@end

@implementation ONESerialDetailViewController
- (NSString *)commentUrl
{
    return commnet_serial;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"连载";
}

- (void)loadDetailData
{
    [super loadDetailData];
    ONEWeakSelf
    [SVProgressHUD show];
    [ONEDataRequest requestSerialDetail:self.detail_id parameters:nil succsee:^(ONESerialItem *serial) {
        [SVProgressHUD dismiss];
        if (!serial) return ;
        weakSelf.headerView.serialItem = serial;
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

- (void)loadRelatedData
{
    [ONEDataRequest requestSerialRelated:self.detail_id paramrters:nil success:^(NSArray *serialRelated) {
        if (!serialRelated.count) return;
        self.relatedItems = serialRelated;
        [super loadRelatedData];
    } failure:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && self.relatedItems.count)
    {
        ONEReadRelatedCell *cell = [tableView dequeueReusableCellWithIdentifier:relatedCell];
        cell.serialItem = self.relatedItems[indexPath.row];
        return cell;
    }
    
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && self.relatedItems.count)
    {
        ONESerialItem *item = self.relatedItems[indexPath.row];
        ONESerialDetailViewController *detailVc = [ONESerialDetailViewController new];
        detailVc.detail_id = item.content_id;
        [self.navigationController pushViewController:detailVc animated:true];
    }
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && self.relatedItems.count)
    {
        ONEReadRelatedCell *cell = [tableView dequeueReusableCellWithIdentifier:relatedCell];
        cell.serialItem = self.relatedItems[indexPath.row];
        return cell.rowHeight;
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}
@end
