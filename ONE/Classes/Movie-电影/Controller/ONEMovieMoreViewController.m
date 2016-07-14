//
//  ONEMovieMoreViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/13.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEMovieMoreViewController.h"
#import "MJRefresh.h"
#import "ONEDataRequest.h"
#import "ONEMovieResultItem.h"
#import "ONEMovieStoryItem.h"
#import "ONEMovieCommentCell.h"
#import "ONEPersonDetailViewController.h"
#import "UITableView+Extension.h"

@interface ONEMovieMoreViewController ()
/** 故事模型数组 */
@property (nonatomic, strong) NSMutableArray *storyItems;
/** 保存行高的字典 */
@property (nonatomic, strong) NSMutableDictionary *rowHeightDict;
@end

@implementation ONEMovieMoreViewController

static NSString *const moreMovieCell = @"moreMovieCell";


#pragma mark - lazy load
- (NSMutableDictionary *)rowHeightDict
{
    if (!_rowHeightDict) {
        _rowHeightDict = [NSMutableDictionary dictionary];
    }
    
    return _rowHeightDict;
}

#pragma mark - initial
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
}

#pragma mark view
- (void)setupView
{
    [self.tableView registerClass:[ONEMovieCommentCell class] forCellReuseIdentifier:moreMovieCell];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [self.tableView.mj_header beginRefreshing];

}

#pragma mark data
/** load data */
- (void)loadData
{
    ONEWeakSelf
    /** 电影故事 */
    [ONEDataRequest requestMovieStory:[_movie_id stringByAppendingPathComponent:@"story/0/0"] parameters:nil success:^(ONEMovieResultItem *movieStory) {
         
         if (movieStory)
         {
             weakSelf.storyItems = (NSMutableArray *)movieStory.data;
             [weakSelf.tableView reloadData];
         }
         
         [weakSelf endRefreshing];
     } failure:^(NSError *error) {
         [weakSelf endRefreshing];
     }];
}

/** load more */
- (void)loadMoreData
{
    ONEWeakSelf
    ONEMovieStoryItem *item = self.storyItems.lastObject;
    
    NSString *url = [_movie_id stringByAppendingPathComponent:[@"story/0" stringByAppendingPathComponent:item.movie_story_id]];
    /** 更多电影故事 */
    [ONEDataRequest requestMovieStory:url parameters:nil success:^(ONEMovieResultItem *movieStory) {
        
        if (movieStory)
        {
            [weakSelf.storyItems addObjectsFromArray:movieStory.data ];
            [weakSelf.tableView reloadData];
        }
        
        [weakSelf endRefreshing];
    } failure:^(NSError *error) {
        [weakSelf endRefreshing];
    }];
}


/** endRefresh */
- (void)endRefreshing
{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [tableView tableViewShowMessage:nil numberOfRows:self.storyItems.count];
    return self.storyItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ONEMovieCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:moreMovieCell];
    ONEMovieStoryItem *item = self.storyItems[indexPath.row];
    cell.movieStoryItem = item;
    cell.movie_id = item.movie_id;
    return cell;
}

#pragma mark - table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *rowHeightStr = [self.rowHeightDict objectForKey:@(indexPath.row)];
    if (rowHeightStr) {
        ONELog(@"保存的行高-%zd", indexPath.row)
        return rowHeightStr.floatValue;
    }
    
    ONEMovieCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:moreMovieCell];
    cell.movieStoryItem = self.storyItems[indexPath.row];
    [self.rowHeightDict setObject:[NSString stringWithFormat:@"%f", cell.rowHeight] forKey:@(indexPath.row)];
    ONELog(@"计算的行高-%zd", indexPath.row)
    return cell.rowHeight;
}


@end


