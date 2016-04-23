//
//  ONEMovieViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/1.
//  Copyright © 2016年 任玉祥. All rights reserved.
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

#pragma mark - initial
#pragma mark view
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
   
}

- (void)setupView
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor = ONEColor(234, 234, 234, 1);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.rowHeight = 150;
}

#pragma mark data
/** 刷新数据 */
- (void)loadData
{
    ONEWeakSelf
    [ONEDataRequest requestMovieList:@"0" parameters:nil succes:^(NSArray *movieLists) {

        if (movieLists.count) {
            weakSelf.movieList = (NSMutableArray *)movieLists;
            [weakSelf.tableView reloadData];
        }
       [weakSelf endRefreshing];
    } failure:^(NSError *error) {
        [weakSelf endRefreshing];
    }];
}

/** 加载更多 */
- (void)loadMore
{
    if (self.tableView.mj_header.isRefreshing) return;
    
    ONEWeakSelf
    [ONEDataRequest requestMovieList:[[self.movieList lastObject] movie_id] parameters:nil succes:^(NSArray *movieLists) {
        if (movieLists.count) {
            [weakSelf.movieList addObjectsFromArray:movieLists];
            [weakSelf.tableView reloadData];
            [weakSelf endRefreshing];
        }else{
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
    } failure:^(NSError *error) {
        [weakSelf endRefreshing];
    }];
}

#pragma mark - tableview data source
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

#pragma mark - table view delegate
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

/** endRefresh */
- (void)endRefreshing
{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

@end
