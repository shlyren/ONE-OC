//
//  ONEReadDetailViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/14.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEReadDetailViewController.h"
#import "UITableView+Extension.h"
#import "ONEPersonDetailViewController.h"
#import "ONEReadCommentItem.h"
#import "MJRefresh.h"
#import "ONECommentCell.h" //serial

@interface ONEReadDetailViewController ()
@property (nonatomic, strong) NSMutableArray *commentItems;
@property (nonatomic, strong) UIImageView *noDataImgView;

@end

@implementation ONEReadDetailViewController
static NSString *const commentCellID = @"ONECommentCell";
NSString *const relatedCellID = @"relatedCell";
#define ToolBarHeight 44

#pragma mark - lazy load
- (ONEReadDetailHeaderView *)headerView
{
    if (_headerView == nil)
    {
        ONEWeakSelf
        __weak ONEReadDetailHeaderView *headerView = [ONEReadDetailHeaderView detailHeaderView];
        headerView.contentChangeBlock = ^(CGFloat height){
            headerView.height = height;
            weakSelf.tableView.tableHeaderView = headerView;
        };
        
        headerView.clickListBtnBlock = ^(NSString *content_id){
            weakSelf.detail_id = content_id;
            [weakSelf loadDetailData];
        };
        _headerView = headerView;
        
    }
    return _headerView;
}

- (UIImageView *)noDataImgView
{
    if (_noDataImgView == nil)
    {
        UIImageView *noDataImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sofa_image"]];
        noDataImgView.frame = CGRectMake(0, 0, ONEScreenWidth, 192 * ONEScreenWidth / 828);
        _noDataImgView = noDataImgView;
    }
    return _noDataImgView;
}

- (UITableView *)tableView
{
    if (_tableView == nil)
    {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        tableView.contentInset = UIEdgeInsetsMake(ONENavBMaxY, 0, ToolBarHeight, 0);
        [tableView registerNib:[UINib nibWithNibName:@"ONECommentCell" bundle:nil] forCellReuseIdentifier:commentCellID];
        [tableView registerNib:[UINib nibWithNibName:@"ONEReadRelatedCell" bundle:nil] forCellReuseIdentifier:relatedCellID];
        tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
        tableView.scrollIndicatorInsets = tableView.contentInset;
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:_tableView = tableView];
    }
    return _tableView;
}


- (NSString *)commentType
{
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDetailData];
    [self setupView];
}

- (void)setupView
{
    self.automaticallyAdjustsScrollViewInsets = false;
    self.tableView.tableHeaderView = self.headerView;
    
    ONEReadToolBarView *toolBarView = [ONEReadToolBarView toolBarView];
    toolBarView.frame = CGRectMake(0, self.tableView.height - ToolBarHeight, self.view.width, ToolBarHeight);
    [self.view  addSubview: _toolBarView = toolBarView];
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

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    tableView.tableFooterView = !self.commentItems.count ? self.noDataImgView : nil;
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
