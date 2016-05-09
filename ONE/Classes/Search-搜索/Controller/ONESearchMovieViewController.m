//
//  ONESearchMovieViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/18.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONESearchMovieViewController.h"
#import "ONESearchMovieItem.h"
#import "ONEMovieDetailViewController.h"


@implementation ONESearchMovieViewController

- (ONESearchContentType)searchContentType
{
    return ONESearchContentTypeMovie;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.text = [self.searchResult[indexPath.row] title];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    ONESearchMovieItem *item = self.searchResult[indexPath.row];
    ONEMovieDetailViewController *movieDetailVc = [ONEMovieDetailViewController new];
    movieDetailVc.movie_id = item.movie_id;
    movieDetailVc.title = item.title;
    [self.navigationController pushViewController:movieDetailVc animated:true];
}

@end
