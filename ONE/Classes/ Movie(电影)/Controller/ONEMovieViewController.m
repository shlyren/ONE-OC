//
//  ONEMovieViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/1.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import "ONEMovieViewController.h"
#import "ONEDataRequest.h"
#import "MJRefresh.h"
#import "ONEMovieListItem.h"
#import "UITableView+Extension.h"
#import "ONEMovieListCell.h"
#import "ONEMovieDetailViewController.h"

@interface ONEMovieViewController ()

@property (nonatomic, strong) NSMutableArray *movieList;

@end

@implementation ONEMovieViewController


- (NSMutableArray *)movieList
{
    if (_movieList == nil) {
        _movieList = [NSMutableArray array];
    }
    return _movieList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor = ONEColor(234, 234, 234, 1);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.rowHeight = 150;
}


- (void)loadData
{
    ONEWeakSelf
    [ONEDataRequest requestMovieList:@"0" parameters:nil succes:^(NSArray *movieLists) {
    
        if (weakSelf.movieList.count) [weakSelf.movieList removeAllObjects];
        
        if (movieLists.count) {
            [weakSelf.movieList addObjectsFromArray:movieLists];
            [weakSelf.tableView reloadData];
        }
        [weakSelf endRefreshing];
    } failure:^(NSError *error) {
        [weakSelf endRefreshing];
    }];
}

- (void)loadMore
{
    if (self.tableView.mj_header.isRefreshing) return;
    
    ONEWeakSelf
    [ONEDataRequest requestMovieList:[[self.movieList lastObject] movie_id] parameters:nil succes:^(NSArray *movieLists) {
        if (movieLists.count) {
            [weakSelf.movieList addObjectsFromArray:movieLists];
            [weakSelf.tableView reloadData];
        }
        [weakSelf endRefreshing];
    } failure:^(NSError *error) {
        [weakSelf endRefreshing];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.movieList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *movieListCellID = @"movieList";
    ONEMovieListCell *cell = [tableView dequeueReusableCellWithIdentifier:movieListCellID];
    if (cell == nil) {
        cell = [[ONEMovieListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:movieListCellID];
    }

    cell.movieListItem = self.movieList[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ONEMovieDetailViewController *movieDetailVc = [ONEMovieDetailViewController new];
    movieDetailVc.movie_id = [self.movieList[indexPath.row] movie_id];
    movieDetailVc.title = [self.movieList[indexPath.row] title];
    [self.navigationController pushViewController:movieDetailVc animated:true];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ONEScreenWidth * 0.45;
}


- (void)endRefreshing
{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

@end
