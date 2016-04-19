//
//  ONEReadDetailViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/14.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEReadDetailViewController.h"
#import "ONEReadToolBarView.h"
#import "UITableView+Extension.h"
#import "ONEPersonDetailViewController.h"
#import "ONEReadCommentItem.h"
#import "MJRefresh.h"
#import "ONECommentCell.h" //serial

@interface ONEReadDetailViewController () <ONEReadDetailHeaderViewDelegate>
@property (nonatomic, strong) NSMutableArray *commentItems;

@end

@implementation ONEReadDetailViewController
static NSString *const commentCellID = @"commentCell";
NSString *const relatedCell = @"relatedCell";

#pragma mark - lazy load
- (ONEReadDetailHeaderView *)headerView
{
    if (_headerView == nil)
    {
        ONEReadDetailHeaderView *headerView = [ONEReadDetailHeaderView detailHeaderView];
        headerView.height = 100;
        headerView.delegate = self;
        _headerView = headerView;
        self.tableView.tableHeaderView = headerView;
    }
    return _headerView;
}

#pragma mark  initial
- (instancetype)init
{
    return [super initWithStyle: UITableViewStyleGrouped];
}
- (NSString *)commentType
{
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDetailData];
    [self.tableView registerNib:[UINib nibWithNibName:@"ONECommentCell" bundle:nil] forCellReuseIdentifier:commentCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"ONEReadRelatedCell" bundle:nil] forCellReuseIdentifier:relatedCell];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
//    [self setupToolBar];
}

- (void)setupToolBar
{
    ONEReadToolBarView *toolBarView = [ONEReadToolBarView toolBarView];
    toolBarView.frame = CGRectMake(0, self.tableView.height - 44, ONEScreenWidth, 44);
    [self.view addSubview:toolBarView];
    
}

#pragma mark - 数据相关
/** 加载详情数据 */
- (void)loadDetailData
{
    [self loadData];
}

/** 加载评论数据 */
- (void)loadData
{
    ONEWeakSelf
    NSString *url = [NSString stringWithFormat:@"%@/%@/%@/0",readeCommnet,self.commentType, self.detail_id];
   [ONEDataRequest requestReadComment:url parameters:nil success:^(NSArray *commentItems) {
      
       if (!commentItems.count) return;
       weakSelf.commentItems = (NSMutableArray *)commentItems;
       [weakSelf loadRelatedData];
       
   } failure:nil];
}

/** 加载相似数据 */
- (void)loadRelatedData
{
    [self.tableView reloadData];
}

/** 加载更多评论 */
- (void)loadMore
{
    ONEWeakSelf
    NSString *comment_id = [self.commentItems.lastObject comment_id];
    NSString *url = [NSString stringWithFormat:@"%@/%@/%@/%@", readeCommnet, self.commentType, self.detail_id, comment_id];
    
    [SVProgressHUD show];
    [ONEDataRequest requestReadComment:url parameters:nil success:^(NSArray *commentItems) {
        
        if (commentItems.count) {
            [weakSelf.commentItems addObjectsFromArray: commentItems];
            [weakSelf.tableView reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:@"没有更多数据了..."];
        }
        [weakSelf.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - ONEReadDetailHeaderViewDelegate
- (void)readDetailHeaderView:(ONEReadDetailHeaderView *)detailHeaderView didChangedHeight:(CGFloat)height
{
    self.headerView.height = height;
    self.tableView.tableHeaderView = self.headerView;
}

- (void)readDetailHeaderView:(ONEReadDetailHeaderView *)detailHeaderView didSelectedSerialList:(NSString *)content_id
{
    self.detail_id = content_id;
    [self loadDetailData];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    [tableView tableViewShowMessage:@"" numberOfRows:self.commentItems.count];
    if (self.relatedItems.count) return 2;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.relatedItems.count && section == 0) return self.relatedItems.count;
    return self.commentItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView tableViewSetExtraCellLineHidden];
    ONECommentCell *cell = [tableView dequeueReusableCellWithIdentifier:commentCellID];
    
    cell.commentItem = self.commentItems[indexPath.row];
    cell.detail_id   = self.detail_id;
    cell.commentType = self.commentType;
    return cell;
}

#pragma mark -tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ONECommentCell *cell = [tableView dequeueReusableCellWithIdentifier:commentCellID];
    cell.commentItem = self.commentItems[indexPath.row];
    return cell.rowHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0 && self.relatedItems.count )
    return [ONEReadDetailHeaderView relatedSectionHeader];
    return [ONEReadDetailHeaderView commentSectionHeader];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ONETitleViewH;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.000000000001;
}

@end
