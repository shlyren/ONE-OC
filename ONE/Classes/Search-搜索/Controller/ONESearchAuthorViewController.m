//
//  ONESearchAuthorViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/18.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONESearchAuthorViewController.h"
#import "ONEAuthorItem.h"
#import "ONEPersonDetailViewController.h"

@implementation ONESearchAuthorViewController

- (ONESearchContentType)searchContentType
{
    return ONESearchContentTypeAuthor;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.text = [self.searchResult[indexPath.row] user_name];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    ONEPersonDetailViewController *persionVc = [ONEPersonDetailViewController new];
    ONEAuthorItem *item = self.searchResult[indexPath.row];
    persionVc.user_id = item.user_id;
    [self.navigationController pushViewController:persionVc animated:true];
}

@end
