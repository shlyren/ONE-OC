//
//  ONEMusicViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/1.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEMusicViewController.h"
#import "ONECommentCell.h"
#import "ONEMusicCommentItem.h"
#import "ONEDataRequest.h"
#import "MJRefresh.h"
#import "ONEMusicrelatedCell.h"
#import "ONEMusicDetailView.h"
#import "ONEMusicRelatedItem.h"
#import "UITableView+Extension.h"
#import "ONEHttpTool.h"

@interface ONEMusicViewController ()<ONEMusicDetailViewDelegate,
UICollectionViewDelegate, UICollectionViewDataSource>


@property (nonatomic, weak) UICollectionView *collectionView;

/** 音乐详情的view */
@property (nonatomic, weak) ONEMusicDetailView *musicDetailView;

/** 存放评论模型的数组  */
@property (nonatomic, strong) NSMutableArray *commentArr;

/** 存放相似歌曲的数组 */
@property (nonatomic, strong) NSArray *relatedArr;

/** 有没有相似歌曲数据  默认没有 */
@property (nonatomic, assign) BOOL haveRelatedData;

@property (nonatomic, strong) UIImageView *noDataImgView;

/** 音乐播放器 */
//@property (nonatomic, weak) ONEMusicPlayerView *playerView;

@end

@implementation ONEMusicViewController

static NSString *const commentCellID = @"commentCell";
static NSString *const relatedCellID = @"relatedCell";

#pragma mark - ↓↓↓↓↓↓ lazy load ↓↓↓↓↓↓
- (UIImageView *)noDataImgView
{
    if (_noDataImgView == nil) {
        UIImageView *noDataImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sofa_image"]];
        noDataImgView.frame = CGRectMake(0, 0, ONEScreenWidth, 192 * ONEScreenWidth / 828);
        _noDataImgView = noDataImgView;
    }
    return _noDataImgView;
}

- (NSMutableArray *)commentArr
{
    if (_commentArr == nil) {
        _commentArr = [NSMutableArray array];
    }
    return _commentArr;
}

- (UICollectionView *)collectionView
{
    if (_collectionView == nil)
    {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(95, 150);
        layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
        layout.minimumLineSpacing = 40;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ONEScreenWidth, 190) collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.showsHorizontalScrollIndicator = false;
        collectionView.scrollsToTop = false;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ONEMusicRelatedCell class]) bundle:nil] forCellWithReuseIdentifier:relatedCellID];
        
        _collectionView = collectionView;
    }
    return _collectionView;
}

#pragma mark - ↓↓↓↓↓↓ initial ↓↓↓↓↓↓
- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return self = [super initWithStyle:style] ? [super initWithStyle:UITableViewStyleGrouped] : self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpView];
}


#pragma mark 初始化view
- (void)setUpView
{
    self.automaticallyAdjustsScrollViewInsets = false;
    
    ONEMusicDetailView *headerView = [[ONEMusicDetailView alloc] init];
    headerView.delegate = self;
    headerView.size = CGSizeMake(ONEScreenWidth, 450);
    __weak ONEMusicDetailView *weakHeaderView = headerView;
    ONEWeakSelf
    headerView.contentChangeBlock = ^(CGFloat height){
        weakHeaderView.height = height;
        weakSelf.tableView.tableHeaderView = weakHeaderView;
    };
    _musicDetailView = headerView;
    
    self.tableView.tableHeaderView = headerView;
    
    CGFloat bottom = self.navigationController.childViewControllers.count == 1 ? ONETabBarH : 0;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, bottom, 0);
    
    bottom = self.navigationController.childViewControllers.count == 1 ? ONETabBarH : 0;
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(ONENavBMaxY, 0, bottom, 0);
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ONECommentCell class]) bundle:nil] forCellReuseIdentifier:commentCellID];
    
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadDetailData)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadCommentData)];
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - ↓↓↓↓↓↓ loadData Methods ↓↓↓↓↓↓
#pragma mark 音乐详情的数据
- (void)loadDetailData
{
    ONEWeakSelf
    [SVProgressHUD showWithStatus:@"努力加载中..."];
    [ONEDataRequest requestMusicDetail:_detailIdUrl parameters:nil success:^(ONEMusicDetailItem *musicDetailItem) {
        if (musicDetailItem) _musicDetailView.musicDetailItem = musicDetailItem;
        [weakSelf loadRelatedData];
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

#pragma mark 相似歌曲数据
- (void)loadRelatedData
{
    ONEWeakSelf
    [ONEDataRequest requestMusicRelated:self.detailIdUrl parameters:nil success:^(NSArray<ONEMusicRelatedItem *> *relatedItems) {
        _haveRelatedData = relatedItems.count;
       
        if (relatedItems.count)
        {
            weakSelf.relatedArr = relatedItems;
            [weakSelf.tableView reloadData];
            [weakSelf.collectionView reloadData];
        }
    } failure:nil];
    
    [self loadCommentData];
}

#pragma mark 评论数据
- (void)loadCommentData
{
    ONEWeakSelf
    ONEMusicCommentItem *item = [self.commentArr lastObject];
    NSString *commentId = item ? item.comment_id : @"0";

    [ONEDataRequest requestMusicComment:[_detailIdUrl stringByAppendingPathComponent:commentId] parameters:nil success:^(NSArray<ONEMusicCommentItem *> *commentItems) {
        if (commentItems.count) {
            [weakSelf.commentArr addObjectsFromArray:commentItems];
            [weakSelf.tableView reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:@"没有数据了哦~~"];
        }
        [weakSelf.tableView.mj_footer  endRefreshing];
        
    } failure:^(NSError *error) {
        [weakSelf.tableView.mj_footer  endRefreshing];
    }];
}


#pragma mark - ↓↓↓↓↓↓ data source Methods ↓↓↓↓↓↓
#pragma mark table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    tableView.tableFooterView = !self.commentArr.count ? self.noDataImgView : nil;
    if (_haveRelatedData) return 2;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_haveRelatedData && section == 0) return 1;
    return self.commentArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_haveRelatedData && indexPath.section == 0)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"related"];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"related"];
            [cell.contentView addSubview:self.collectionView];
        }
        return cell;
    }
    
    ONECommentCell *cell = [tableView dequeueReusableCellWithIdentifier:commentCellID];
    cell.commentItem = self.commentArr[indexPath.row];
    cell.detail_id = _detailIdUrl;
    cell.commentType = @"music";
    return cell;
}

#pragma mark UICollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.relatedArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ONEMusicRelatedCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:relatedCellID forIndexPath:indexPath];
    cell.relatedItem = self.relatedArr[indexPath.row];
    return cell;
}


#pragma mark -  ↓↓↓↓↓↓ delegate Methods ↓↓↓↓↓↓
#pragma mark musicDetailView
- (void)musicDetailViwe:(ONEMusicDetailView *)musicDetailView didClickPlayerBtn:(UIButton *)button
{
    //self.playerView.frame = CGRectMake(0, 0, ONEScreenWidth, 225);
}

#pragma mark table view
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_haveRelatedData && indexPath.section == 0) return 190;
    ONECommentCell *cell= [tableView dequeueReusableCellWithIdentifier:commentCellID];
    cell.commentItem = self.commentArr[indexPath.row];
    return cell.rowHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [UIView new];
    headerView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    
    if (_haveRelatedData && section == 0)
    {
        [headerView addSubview:[tableView tableViewHeaderViewLabelWithString:@"相似歌曲"]];
        [headerView addSubview:self.musicListBtn];
        return headerView;
    }
    
    [headerView addSubview:[tableView tableViewHeaderViewLabelWithString:@"评论列表"]];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.000000001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ONETitleViewH;
}


#pragma mark UICollectionView
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ONEMusicRelatedItem *item = self.relatedArr[indexPath.row];
    ONEMusicViewController *musicVc = [ONEMusicViewController new];
    musicVc.detailIdUrl = item.related_id;
    musicVc.title = item.title;
    [self.navigationController pushViewController:musicVc animated:true];
}

#pragma mark - ↓↓↓↓↓↓ tableHeaderView Methods ↓↓↓↓↓↓
#pragma mark 播放按钮
- (UIButton *)musicListBtn
{
    UIButton *musicListBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [musicListBtn setImage:[UIImage imageNamed:@"music_list_play_default"] forState:UIControlStateNormal];
    [musicListBtn setImage:[UIImage imageNamed:@"music_list_pause highlighted"] forState:UIControlStateHighlighted];
    [musicListBtn setImage:[UIImage imageNamed:@"music_list_pause_default"] forState:UIControlStateSelected];
    [musicListBtn addTarget:self action:@selector(musicListBtnCilck:) forControlEvents:UIControlEventTouchUpInside];
    [musicListBtn sizeToFit];
    musicListBtn.centerY = ONETitleViewH * 0.5;
    musicListBtn.x = ONEScreenWidth - musicListBtn.width;
    
    return musicListBtn;
}

#pragma mark 点击播放按钮的事件处理
- (void)musicListBtnCilck:(UIButton *)musicListBtn
{
    musicListBtn.selected = !musicListBtn.selected;
    
    if (musicListBtn.selected) {
        ONELog(@"播放相似音乐中...");
    }else{
        ONELog(@"暂停播放音乐...");
    }
}
@end
