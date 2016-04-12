//
//  ONEMovieDetailViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/11.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import "ONEMovieDetailViewController.h"
#import "ONEDefaultCellGroupItem.h"
#import "UITableView+Extension.h"
#import "ONEMovieDetailHeaderView.h"
#import "ONEDataRequest.h"
#import "ONEMovieResultItem.h"
#import "ONEMovieCommentCell.h"

@interface ONEMovieDetailViewController () <ONEMovieDetailHeaderViewDelegate>

@property (nonatomic, strong) ONEMovieResultItem *movieReviewResult;

@property (nonatomic, strong) NSArray *groups;

@property (nonatomic, weak) ONEMovieDetailHeaderView *headerView;

@end

@implementation ONEMovieDetailViewController
static NSString *const movieCommentID = @"movieComment";

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self = [super initWithStyle:style]) {
        self = [super initWithStyle: UITableViewStyleGrouped];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
    [self loadData];
}

- (void)loadData
{
    ONEWeakSelf
    [ONEDataRequest requestMovieReview:[_movie_id stringByAppendingPathComponent:@"review/1/0"] parameters:nil success:^(ONEMovieResultItem *movieReview) {
        weakSelf.movieReviewResult = movieReview;
        [weakSelf setupGroup];
        [weakSelf.tableView reloadData];
    } failure:nil];
}

- (void)setupView
{
    self.automaticallyAdjustsScrollViewInsets = false;
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, -20, 0);
    self.tableView.scrollIndicatorInsets =  self.tableView.contentInset;
    ONEMovieDetailHeaderView *headerView = [ONEMovieDetailHeaderView tableHeaderView];
    headerView.movie_id = _movie_id;
    headerView.delegate = self;
    _headerView = headerView;
    [self.tableView registerNib:[UINib nibWithNibName:@"ONEMovieCommentCell" bundle:nil] forCellReuseIdentifier:movieCommentID];
    self.tableView.tableHeaderView = headerView;
}

- (void)setupGroup
{
    ONEDefaultCellGroupItem *group1 = [ONEDefaultCellGroupItem new];
    group1.footerHeight = 40;
    group1.headerView = [ONEMovieDetailHeaderView reviewSectionHeaderView];
    group1.footerView = [ONEMovieDetailHeaderView reviewSectionFooterView];    
    ONEDefaultCellGroupItem *group2 = [ONEDefaultCellGroupItem new];
    group2.headerView = [ONEMovieDetailHeaderView commentSectionHeaderView];
    
    self.groups = @[group1, group2];
    
}

- (void)movieDetailHeaderView:(ONEMovieDetailHeaderView *)movieDetailHeaderView didChangedStoryContent:(CGFloat)height
{
    self.headerView.height += height;
    self.tableView.tableHeaderView = self.headerView;
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

//    if (self.movieReviewResult == nil) return 0;
//    return self.groups.count;
    return 1;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

   return self.movieReviewResult.data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    ONEMovieCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:movieCommentID];
    ONEMovieCommentItem *commentItem = self.movieReviewResult.data[indexPath.row];
    cell.commentItem = commentItem;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static ONEMovieCommentCell *cell;
    if (cell == nil) cell = [tableView dequeueReusableCellWithIdentifier:movieCommentID];
    cell.commentItem = self.movieReviewResult.data[indexPath.row];
    return cell.rowHeight;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ONEDefaultCellGroupItem *group = self.groups[section];
    return group.headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    ONEDefaultCellGroupItem *group = self.groups[section];
    return group.footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    ONEDefaultCellGroupItem *group = self.groups[section];
    return group.footerHeight;
}
@end
