//
//  ONESearchHpViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/18.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONESearchHpViewController.h"
#import "ONESubtotalDetailViewController.h"

@interface ONESearchHpViewController ()

@end

@implementation ONESearchHpViewController

- (void)setSearchKey:(NSString *)searchKey
{
    if ([self.searchKey isEqualToString:searchKey]) return;
    [super setSearchKey:searchKey];
    ONEWeakSelf
    [SVProgressHUD showWithStatus:@"搜索中..."];
    
    [ONEDataRequest requestSearchHp:searchKey success:^(NSArray *hpResult) {
        if (hpResult.count) {
            weakSelf.searchResult = hpResult;
            [weakSelf.tableView reloadData];
        }
        
    } failure:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ONESearchTableViewCell *cell = (ONESearchTableViewCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.item = self.searchResult[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    ONESubtotalDetailViewController *subtotalVc = [ONESubtotalDetailViewController new];
    subtotalVc.subtotalItem = self.searchResult[indexPath.row];
    
    [self.navigationController pushViewController:subtotalVc animated:true];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


@end
