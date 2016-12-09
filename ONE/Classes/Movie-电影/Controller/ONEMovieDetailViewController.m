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


@interface ONEMovieDetailViewController ()

/** 评审团评论的模型 */
@property (nonatomic, strong) ONEMovieResultItem *movieReviewResult;
/** tableview组 */
@property (nonatomic, strong) NSMutableArray *groups;
/** taberheader, 电影故事详情的View */
@property (nonatomic, weak) ONEMovieDetailHeaderView *headerView;
/** 用户评论的模型 */
@property (nonatomic, strong) NSMutableArray *commentArray;

/** 保存行高的字典 */
@property (nonatomic, strong) NSMutableDictionary *rowHeightDict;
@end

@implementation ONEMovieDetailViewController

static NSString *const movieCommentID = @"ONEMovieCommentCell";

#pragma mark - lazy load
- (NSMutableDictionary *)rowHeightDict
{
    if (!_rowHeightDict) {
        _rowHeightDict = [NSMutableDictionary dictionary];
    }
    
    return _rowHeightDict;
}

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
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
//    [self loadData];
    [self loadCommentData];
}

- (void)setupView
{
    self.automaticallyAdjustsScrollViewInsets = false;
    self.tableView.contentInset = UIEdgeInsetsMake(ONENavBMaxY, 0, 0, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    ONEMovieDetailHeaderView *headerView = [ONEMovieDetailHeaderView tableHeaderView];
    headerView.movie_id = _movie_id;
    headerView.reviewCount = self.movieReviewResult.count;
    
    self.tableView.tableHeaderView = _headerView = headerView;
    [self.tableView registerNib:[UINib nibWithNibName:@"ONEMovieCommentCell" bundle:nil] forCellReuseIdentifier:movieCommentID];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
}

#pragma mark - load data
#pragma mark detail data
//- (void)loadData
//{
//    ONEWeakSelf
//    /** 电影评审团 */
//    [ONEDataRequest requestMovieReview:[_movie_id stringByAppendingPathComponent:@"review/1/0"] parameters:nil success:^(ONEMovieResultItem *movieReview) {
//        if (movieReview.data.count) {
//            weakSelf.movieReviewResult = movieReview;
//        }
//        [weakSelf loadCommentData];
//    } failure:^(NSError *error) {
//        [weakSelf loadCommentData];
//    }];
//}

/** 加载评论数据 */
- (void)loadCommentData
{
    ONEWeakSelf
    /** 评论 */
    [ONEDataRequest requestMovieComment:[_movie_id stringByAppendingPathComponent:@"0"] parameters:nil success:^(NSMutableArray *movieComments) {
        if (movieComments.count) {
            weakSelf.commentArray = movieComments;
            [weakSelf setupGroup];
        } else {
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
    } failure:^(NSError *error) {
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark load more comment data
- (void)loadMore
{
    NSString *url = nil;
    if (self.commentArray.count == 0)
    {
        return;
        //url = [_movie_id stringByAppendingPathComponent:@"review/1/0"];
    }
    
    ONEMovieCommentItem *item = [self.commentArray lastObject];
    url = [_movie_id stringByAppendingPathComponent:item.comment_id];
    
    ONEWeakSelf
    
    [ONEDataRequest requestMovieComment:url parameters:nil success:^(NSArray *movieComments) {
        [SVProgressHUD dismiss];
        if (movieComments.count) {
            [weakSelf.commentArray addObjectsFromArray:movieComments];
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.mj_footer endRefreshing];
        }else{
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
    } failure:^(NSError *error) {
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - init group
- (void)setupGroup
{
   
    if (self.movieReviewResult.data.count) { // 电影短评
        ONEDefaultCellGroupItem *group1 = [ONEDefaultCellGroupItem new];
        group1.items        = self.movieReviewResult.data;
        group1.footerHeight = 40;
        group1.headerView   = [ONEMovieDetailHeaderView reviewSectionHeaderView];
        group1.footerView   = [ONEMovieDetailHeaderView reviewSectionFooterView];
        [self.groups addObject:group1];
    }
    
    if (self.commentArray.count) { // 评论
        ONEDefaultCellGroupItem *group2 = [ONEDefaultCellGroupItem new];
        group2.items        = self.commentArray;
        group2.headerView   = [ONEMovieDetailHeaderView commentSectionHeaderView];
        group2.footerHeight = 0.000000000001;
        group2.footerView   = nil;
        [self.groups addObject:group2];
    }
    
     [self.tableView reloadData];
    
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
    
    cell.commentItem = [self.groups[indexPath.section] items][indexPath.row];
    cell.movie_id = _movie_id;
    
    if (self.groups.count == 1) {
        cell.commentCellType = ONEMovieCommentCellTypeMovieComment;
        return cell;
    }
    
    if (indexPath.section == 0)
        cell.commentCellType = ONEMovieCommentCellTypeMovieReview;
    if (indexPath.section == 1)
        cell.commentCellType = ONEMovieCommentCellTypeMovieComment;
    
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
    // key
    NSString *key = [NSString stringWithFormat:@"%zd-%zd", indexPath.section, indexPath.row];

    NSString *rowHeightStr = [self.rowHeightDict objectForKey:key];
    if (rowHeightStr) {
        //ONELog(@"保存的行高-%@", key)
        return rowHeightStr.floatValue;
    }
    
    ONEMovieCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:movieCommentID];
    cell.commentItem = [self.groups[indexPath.section] items][indexPath.row];
    // 保存到字典
    [self.rowHeightDict setObject:[NSString stringWithFormat:@"%f", cell.rowHeight] forKey:key];
    //ONELog(@"计算的行高-%@", key)
    return cell.rowHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self.groups[section] headerView];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [self.groups[section] footerView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return [self.groups[section] footerHeight];
}

@end
