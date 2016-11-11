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

@interface ONEMovieViewController ()<UIViewControllerPreviewingDelegate>

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
    
    // 2、判断3DTouch
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable)
    {
        [self registerForPreviewingWithDelegate: self sourceView: self.view];
    }
}


#pragma mark - UIViewControllerPreviewingDelegate
- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    //    [self.navigationController pushViewController: viewControllerToCommit animated: YES];
    [self showViewController: viewControllerToCommit sender: self];
}

- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint: location];
    ONEMovieListCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (!cell) return nil;
    
    ONEMovieListItem *movieListItem = cell.movieListItem;
    ONEMovieDetailViewController *movieDetailVc = [ONEMovieDetailViewController new];
    movieDetailVc.movie_id = [movieListItem movie_id];
    movieDetailVc.title = [movieListItem title];
    return movieDetailVc;
}

- (NSArray<id<UIPreviewActionItem>> *)previewActionItems
{
    // 生成UIPreviewAction
    UIPreviewAction *action1 = [UIPreviewAction actionWithTitle:@"Action 1" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"Action 1 selected");
    }];
    
    UIPreviewAction *action2 = [UIPreviewAction actionWithTitle:@"Action 2" style:UIPreviewActionStyleDestructive handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"Action 2 selected");
    }];
    
    UIPreviewAction *action3 = [UIPreviewAction actionWithTitle:@"Action 3" style:UIPreviewActionStyleSelected handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"Action 3 selected");
    }];
    
    UIPreviewAction *tap1 = [UIPreviewAction actionWithTitle:@"tap 1" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"tap 1 selected");
    }];
    
    UIPreviewAction *tap2 = [UIPreviewAction actionWithTitle:@"tap 2" style:UIPreviewActionStyleDestructive handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"tap 2 selected");
    }];
    
    UIPreviewAction *tap3 = [UIPreviewAction actionWithTitle:@"tap 3" style:UIPreviewActionStyleSelected handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"tap 3 selected");
    }];
    
    // 塞到UIPreviewActionGroup中
    NSArray *actions = @[action1, action2, action3];
    NSArray *taps = @[tap1, tap2, tap3];
    UIPreviewActionGroup *group1 = [UIPreviewActionGroup actionGroupWithTitle:@"Action Group" style:UIPreviewActionStyleDefault actions:actions];
    UIPreviewActionGroup *group2 = [UIPreviewActionGroup actionGroupWithTitle:@"Action Group" style:UIPreviewActionStyleDefault actions:taps];
    NSArray *group = @[group1,group2];
    
    return group;
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    /** 通知 */
    [[NSNotificationCenter defaultCenter] addObserver:self.tableView.mj_header selector:@selector(beginRefreshing) name:ONETabBarItemDidRepeatClickNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    /** 移除通知 */
    [[NSNotificationCenter defaultCenter] removeObserver:self.tableView.mj_header];
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
