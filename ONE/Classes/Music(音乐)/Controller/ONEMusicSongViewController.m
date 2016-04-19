//
//  ONEMusicSongViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/7.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEMusicSongViewController.h"
#import "UITableView+Extension.h"
#import "ONEDataRequest.h"
#import "ONEMusicRelatedItem.h"
#import "ONESubTitleCell.h"
#import "ONEMusicViewController.h"
#import "MJRefresh.h"

@interface ONEMusicSongViewController ()

@property (nonatomic, strong) NSArray *songLists;

@end

@implementation ONEMusicSongViewController
- (instancetype)init
{
    return [[UIStoryboard storyboardWithName:NSStringFromClass([self class]) bundle:nil] instantiateInitialViewController];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 80, 0, 0)];

    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    [self.tableView.mj_header beginRefreshing];
    
}

/** 刷新数据 */
- (void)refreshData
{
    ONEWeakSelf
    if (_user_id) // 从个人详情push过来的
    {
        [ONEDataRequest requestPersonSong:_user_id parameters:nil success:^(NSArray<ONEMusicRelatedItem *> *musics) {
            
            if (musics.count) [weakSelf setupData:musics];
            [weakSelf.tableView.mj_header endRefreshing];
            
        } failure:^(NSError *error) {
            
             [weakSelf.tableView.mj_header endRefreshing];
        
        }];
    }
    
    if (_month) // 从往期列表push过来的
    {
        [ONEDataRequest requsetMusicByMonth:_month parameters:nil success:^(NSArray<ONEMusicRelatedItem *> *musics) {
            
            if (musics.count) [weakSelf setupData:musics];
            [weakSelf.tableView.mj_header endRefreshing];
            
        } failure:^(NSError *error) {
            
            [weakSelf.tableView.mj_header endRefreshing];
            
        }];
    }
}

- (void)setupData:(NSArray *)musics
{
    self.songLists = musics;
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   [tableView tableViewShowMessage:@"现在还没有数据哦~~" numberOfRows:self.songLists.count];
    return self.songLists.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   [tableView tableViewSetExtraCellLineHidden];
    
    static NSString *const songCellID = @"songCell";
    ONESubTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:songCellID];
    cell.songListItem = self.songLists[indexPath.row];
    
    return cell;
}

#pragma mark - Table view data delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    ONEMusicViewController *musicVc = [ONEMusicViewController new];
    ONEMusicRelatedItem *detail     = self.songLists[indexPath.row];
    musicVc.detailIdUrl             = detail.related_id;
    musicVc.title                   = detail.title;
    [self.navigationController pushViewController:musicVc animated:true];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
@end
