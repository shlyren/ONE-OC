//
//  ONEMovieDetailViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/11.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEMovieDetailViewController.h"
#import "ONEDefaultCellGroupItem.h"
#import "UITableView+Extension.h"
#import "ONEMovieDetailHeaderView.h"
#import "ONEDataRequest.h"
#import "ONEMovieResultItem.h"
#import "ONEMovieCommentItem.h"
#import "ONEMovieCommentCell.h"
#import "MJRefresh.h"
#import "ONEPersonDetailViewController.h"
#import "ONEMovieMoreViewController.h"


@interface ONEMovieDetailViewController () <ONEMovieDetailHeaderViewDelegate>
/** 评审团评论的模型 */
@property (nonatomic, strong) ONEMovieResultItem *movieReviewResult;
/** tableview组 */
@property (nonatomic, strong) NSMutableArray *groups;
/** taberheader, 电影故事详情的View */
@property (nonatomic, weak) ONEMovieDetailHeaderView *headerView;
/** 用户评论的模型 */
@property (nonatomic, strong) NSMutableArray *commentArray;

@end

@implementation ONEMovieDetailViewController

static NSString *const movieCommentID = @"movieComment";

- (NSMutableArray *)groups
{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

#pragma mark - initial
#pragma mark view
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
    [self setupGroup];
}

- (void)setupView
{
    self.automaticallyAdjustsScrollViewInsets = false;
    ONEMovieDetailHeaderView *headerView = [ONEMovieDetailHeaderView tableHeaderView];
    headerView.movie_id = _movie_id;
    headerView.reviewCount = self.movieReviewResult.count;
    headerView.delegate = self;
    
    self.tableView.tableHeaderView = _headerView = headerView;
    [self.tableView registerClass:[ONEMovieCommentCell class] forCellReuseIdentifier:movieCommentID];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    
}

#pragma mark - load data
#pragma mark detail data
- (void)loadData
{
    ONEWeakSelf
    /** 电影评审团 */
    [ONEDataRequest requestMovieReview:[_movie_id stringByAppendingPathComponent:@"review/1/0"] parameters:nil success:^(ONEMovieResultItem *movieReview) {
        if (movieReview.data.count) {
            weakSelf.movieReviewResult = movieReview;
            ONEDefaultCellGroupItem *group1 = weakSelf.groups.firstObject;
            group1.items = movieReview.data;
        }else{
           [weakSelf.groups removeObjectAtIndex:0];
        }
        [weakSelf.tableView reloadData];
    } failure:nil];
 
    /** 评论 */
    [ONEDataRequest requestMovieComment:[_movie_id stringByAppendingPathComponent:@"0"] parameters:nil success:^(NSMutableArray *movieComments) {
        if (movieComments.count) {
            weakSelf.commentArray = movieComments;
            ONEDefaultCellGroupItem *group2 = weakSelf.groups.lastObject;
            group2.items = weakSelf.commentArray;
            [weakSelf.tableView reloadData];
        }
    
    } failure:nil];
    
}

#pragma mark load more comment  data
- (void)loadMore
{
    NSString *url = nil;
    if (self.commentArray.count == 0)
    {
        url = [_movie_id stringByAppendingPathComponent:@"review/1/0"];
    }else{
        ONEMovieCommentItem *item = [self.commentArray lastObject];
        url = [_movie_id stringByAppendingPathComponent:item.comment_id];
    }
    
    ONEWeakSelf
    [SVProgressHUD show];
    [ONEDataRequest requestMovieComment:url parameters:nil success:^(NSArray *movieComments) {
        if (movieComments.count) {
            [weakSelf.commentArray addObjectsFromArray:movieComments];
            [weakSelf.tableView reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:@"没有数据了哦~~"];
        }

        [weakSelf.tableView.mj_footer  endRefreshing];
    } failure:^(NSError *error) {
         [weakSelf.tableView.mj_footer  endRefreshing];
    }];
    
   
}

#pragma mark - init group
- (void)setupGroup
{
   
    ONEDefaultCellGroupItem *group1 = [ONEDefaultCellGroupItem new];
    group1.items        = self.movieReviewResult.data;
    group1.footerHeight = 40;
    group1.headerView   = [ONEMovieDetailHeaderView reviewSectionHeaderView];
    group1.footerView   = [ONEMovieDetailHeaderView reviewSectionFooterView];
    ONEDefaultCellGroupItem *group2 = [ONEDefaultCellGroupItem new];
    group2.items        = self.commentArray;
    group2.headerView   = [ONEMovieDetailHeaderView commentSectionHeaderView];
    group2.footerHeight = 0.000000000001;
    group2.footerView   = nil;
    [self.groups addObject:group1];
    [self.groups addObject:group2];
}



#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.groups[section] items].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ONEMovieCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:movieCommentID];
    if (indexPath.section == 0) cell.commentCellType = ONEMovieCommentCellTypeMovieReview;
    if (indexPath.section == 1) cell.commentCellType = ONEMovieCommentCellTypeMovieComment;
    cell.commentItem = [self.groups[indexPath.section] items][indexPath.row];
    cell.movie_id = _movie_id;
    return cell;
}

#pragma mark - delegate Methods
#pragma mark movieDetailHeaderView
- (void)movieDetailHeaderView:(ONEMovieDetailHeaderView *)movieDetailHeaderView didChangedStoryContent:(CGFloat)height
{
    self.headerView.height += height;
    self.tableView.tableHeaderView = self.headerView;
}

- (void)movieDetailHeaderView:(ONEMovieDetailHeaderView *)movieDetailHeaderView didClickAllBtn:(NSString *)title
{
    ONEMovieMoreViewController *moreVc = [ONEMovieMoreViewController new];
    moreVc.movie_id = _movie_id;
    moreVc.title =  title;
    [self.navigationController pushViewController:moreVc animated:true];
}

#pragma mark tableView
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static ONEMovieCommentCell *cell;
    if (cell == nil) cell = [tableView dequeueReusableCellWithIdentifier:movieCommentID];
    cell.commentItem = [self.groups[indexPath.section] items][indexPath.row];

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
