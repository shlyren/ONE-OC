//
//  ONESearchMovieViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/18.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import "ONESearchMovieViewController.h"
#import "ONESearchMovieItem.h"
#import "ONEMovieDetailViewController.h"
@interface ONESearchMovieViewController ()

@end

@implementation ONESearchMovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)setSearchKey:(NSString *)searchKey
{
    if ([self.searchKey isEqualToString:searchKey]) return;
    [super setSearchKey:searchKey];
    ONEWeakSelf
    [SVProgressHUD showWithStatus:@"搜索中..."];
    [ONEDataRequest requestSearchMovie:self.searchKey success:^(NSArray *movieResult) {
        if (movieResult.count) {
            weakSelf.searchResult = movieResult;
            [weakSelf.tableView reloadData];
        }
        
    } failure:nil];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    static NSString *movieCell = @"moviecell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:movieCell];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:movieCell];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    ONESearchMovieItem *item = self.searchResult[indexPath.row];
    cell.textLabel.text = item.title;
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
