//
//  ONEReadEssayViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/14.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEReadEssayViewController.h"
#import "ONEEssayDetailViewController.h"

@interface ONEReadEssayViewController ()

@end

@implementation ONEReadEssayViewController

- (NSArray *)readItems
{
    return self.readList.essay;
}
- (NSString *)readType
{
    return essay;
}


#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    ONEReadCell *cell = (ONEReadCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.essay = self.readItems[indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ONEEssayItem *item = self.readItems[indexPath.row];
    ONEEssayDetailViewController *detailVc = [ONEEssayDetailViewController new];
    detailVc.detail_id = item.content_id;
    [self.navigationController pushViewController:detailVc animated:true];
    
}

@end
