//
//  ONESearchHpViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/18.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONESearchHpViewController.h"
#import "ONESubtotalDetailViewController.h"

@implementation ONESearchHpViewController

- (ONESearchContentType)searchContentType
{
    return ONESearchContentTypeHp;
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
