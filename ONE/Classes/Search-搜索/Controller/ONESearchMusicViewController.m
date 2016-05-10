//
//  ONESearchMusicViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/18.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONESearchMusicViewController.h"
#import "ONEMusicViewController.h"
#import "ONESearchMusicItem.h"


@implementation ONESearchMusicViewController

- (ONESearchContentType)searchContentType
{
    return ONESearchContentTypeMusic;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[ONESearchTableViewCell class]]) {
        ONESearchTableViewCell *searchCell = (ONESearchTableViewCell*)cell;
        searchCell.musicItem = self.searchResult[indexPath.row];
        return searchCell;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    ONESearchMusicItem *item = self.searchResult[indexPath.row];
    ONEMusicViewController *musicDetailVc = [ONEMusicViewController new];
    musicDetailVc.detailIdUrl = item.music_detail_id;
    musicDetailVc.title = item.title;
    [self.navigationController pushViewController:musicDetailVc animated:true];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
@end
