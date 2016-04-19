//
//  ONEReadSerialViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/14.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEReadSerialViewController.h"
#import "ONESerialDetailViewController.h"

@interface ONEReadSerialViewController ()

@end

@implementation ONEReadSerialViewController

- (NSArray *)readItems
{
    return self.readList.serial;
}

#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ONEReadCell *cell = [tableView dequeueReusableCellWithIdentifier:readCell];
    cell.serial = self.readItems[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ONEEssayItem *item = self.readItems[indexPath.row];
    ONESerialDetailViewController  *detailVc = [ONESerialDetailViewController new];
    detailVc.title = @"连载";
    detailVc.detail_id = item.content_id;
    [self.navigationController pushViewController:detailVc animated:true];
}
@end
