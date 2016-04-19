//
//  ONEEssayDetailViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/14.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import "ONEEssayDetailViewController.h"
#import "ONEReadRelatedCell.h"
#import "ONEEssayItem.h"

@interface ONEEssayDetailViewController ()
@end

@implementation ONEEssayDetailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
     self.title = @"短篇";
}

- (NSString *)commentType
{
    return @"essay";
}

- (void)loadDetailData
{
   [super loadDetailData];
    ONEWeakSelf
    [SVProgressHUD show];
    [ONEDataRequest requestEssayDetail:self.detail_id parameters:nil succsee:^(ONEEssayItem *essay) {
        if (!essay) return;
        weakSelf.headerView.essayItem = essay;
        [weakSelf.tableView reloadData];
    } failure:nil];
}

- (void)loadRelatedData
{
    ONEWeakSelf
    [SVProgressHUD show];
    [ONEDataRequest requestEssayRelated:self.detail_id paramrters:nil success:^(NSArray *essayRelated) {
        if (!essayRelated.count) return;
        weakSelf.relatedItems = essayRelated;
        [super loadRelatedData];
    } failure:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && self.relatedItems.count)
    {
        ONEReadRelatedCell *cell = [tableView dequeueReusableCellWithIdentifier:relatedCell];
        cell.essayItem = self.relatedItems[indexPath.row];
        return cell;
    }
    
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && self.relatedItems.count)
    {
        ONEEssayItem *item = self.relatedItems[indexPath.row];
        ONEEssayDetailViewController *detailVc = [ONEEssayDetailViewController new];
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
        cell.essayItem = self.relatedItems[indexPath.row];
        return cell.rowHeight;
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

@end
