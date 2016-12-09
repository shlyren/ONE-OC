//
//  ONEPersonDetailViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/7.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEPersonDetailViewController.h"
#import "ONEDataRequest.h"
#import "UIImageView+WebCache.m"
#import "UIImage+image.h"
#import "UITableView+Extension.h"
#import "ONEDefaultCellGroupItem.h"
#import "ONEMusicSongViewController.h"
#import "ONEAuthorItem.h"
#import "ZYScaleHeader.h"
#import "ONEPersionHeaderView.h"

#define persionDetailHeader 360
@interface ONEPersonDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *cellItems;
@property (nonatomic, weak) ONEPersionHeaderView *personHeaderView;
@end

@implementation ONEPersonDetailViewController

- (NSMutableArray *)cellItems
{
    if (_cellItems == nil) {
        _cellItems = [NSMutableArray arrayWithCapacity:2];
    }
    
    return _cellItems;
}

- (instancetype)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
    [self loadData];
    [self setUpTableVieData];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:true];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:false];

}

- (void)setUpTableVieData
{
    // 第一组的数据
    {
        ONEDefaultCellArrItem *item0 = [ONEDefaultCellArrItem itemWithTitle:@"ta的文章" image:@"other_writter_reading"];
        ONEDefaultCellArrItem *item1 = [ONEDefaultCellArrItem itemWithTitle:@"ta的歌曲" image:@"other_singer_song"];
        
        ONEWeakSelf
        __weak ONEDefaultCellArrItem *weakItem = item1;
        item1.actionBlock = ^(id parameter) {
            ONEMusicSongViewController *songVc =  [ONEMusicSongViewController new];
            songVc.user_id = parameter;
            songVc.title = weakItem.title;
            [weakSelf.navigationController pushViewController:songVc animated:true];
        };
        
        ONEDefaultCellGroupItem *group0 = [ONEDefaultCellGroupItem groupWithItems: @[item0, item1]];
        
        [self.cellItems addObject:group0];
        
    }
    
    // 第二组的数据
    {
        ONEDefaultCellArrItem *item0 = [ONEDefaultCellArrItem itemWithTitle:@"图文" image:@"center_image_collection"];
        ONEDefaultCellArrItem *item1 = [ONEDefaultCellArrItem itemWithTitle:@"文章" image:@"center_reading_collection"];
        ONEDefaultCellArrItem *item2 = [ONEDefaultCellArrItem itemWithTitle:@"影库" image:@"center_movie_collection"];

        ONEDefaultCellGroupItem *group1 = [ONEDefaultCellGroupItem groupWithItems:@[item0, item1, item2]];
        group1.headerTitle = @"ta的收藏";
        
        [self.cellItems addObject:group1];
    }
}

- (void)setUpView
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"ta的资料";
    self.automaticallyAdjustsScrollViewInsets = false;
    
    ZYScaleHeader *headerView = [ZYScaleHeader headerWithImage:[UIImage imageNamed:@"personalBackgroundImage"] height:300];
    [headerView addSubview: _personHeaderView = [ONEPersionHeaderView persionHeaderViewFrame:headerView.bounds]];
    self.tableView.zy_header = headerView;
}

- (void)loadData
{
    [ONEDataRequest requestUserInfo:_user_id parameters:nil success:^(ONEAuthorItem *authorItem) {
        self.personHeaderView.author = authorItem;
    } failure:nil];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cellItems.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.cellItems[section] items].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *normalCellID = @"normalCell";
    [tableView tableViewSetExtraCellLineHidden];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:normalCellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:normalCellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.separatorInset = UIEdgeInsetsZero;
    }
    
    ONEDefaultCellArrItem *item = [self.cellItems[indexPath.section] items][indexPath.row];
    cell.imageView.image = [UIImage imageNamed:item.image];
    cell.textLabel.text = item.title;
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    ONEDefaultCellArrItem *item = [self.cellItems[indexPath.section] items][indexPath.row];
    
    if (item.actionBlock) {
        item.actionBlock(_user_id);
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) return nil;
    return @"ta的收藏";
}

- (IBAction)close
{
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
