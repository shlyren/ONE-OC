//
//  ONEPersonDetailViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/7.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import "ONEPersonDetailViewController.h"
#import "ONEPersonDetailTableView.h"
#import "ONEDataRequest.h"
#import "UIImageView+WebCache.m"
#import "UIImage+image.h"
#import "UITableView+Extension.h"
#import "ONEDefaultCellGroupItem.h"
#import "ONEDefaultCellArrItem.h"
#import "ONEMusicSongViewController.h"
#import "ONEMusicAuthorItem.h"

@interface ONEPersonDetailViewController ()<UITableViewDataSource,UITableViewDelegate, ONEPersonDetailTableViewDelegate>

@property (weak, nonatomic) IBOutlet ONEPersonDetailTableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *personTopView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewTop;


//@property (nonatomic, strong) ONEMusicAuthorItem *userInfoItem;

@property (nonatomic, strong) NSMutableArray *cellItems;

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
    return [[UIStoryboard storyboardWithName:NSStringFromClass([self class]) bundle:nil] instantiateInitialViewController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self setUpView];
    [self loadData];
    [self setUpTableVieData];
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
    _tableView.detailView = self.personTopView;
    _tableView.delegate_person = self;
    
    self.automaticallyAdjustsScrollViewInsets = false;
    self.tableView.contentInset = UIEdgeInsetsMake(370, 0, 0, 0);
}

- (void)loadData
{
    [ONEDataRequest requestUserInfo:_user_id parameters:nil success:^(ONEMusicAuthorItem *authorItem) {
        
        [_iconImageView sd_setImageWithURL:[NSURL URLWithString:authorItem.web_url] placeholderImage:[UIImage imageNamed:@"personal"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            _iconImageView.image = [image circleImage];
        }];
        
        _userNameLabel.text = authorItem.user_name;
        _scoreLabel.text = authorItem.score;
    } failure:nil];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    [tableView tableViewSetExtraCellLineHidden];
    return self.cellItems.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.cellItems[section] items].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *normalCellID = @"normalCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:normalCellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:normalCellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    ONEDefaultCellArrItem *item = [self.cellItems[indexPath.section] items][indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:item.image];
    cell.textLabel.text = item.title;
    return cell;
}


#pragma mark - tableview delagate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获取当前偏移量                                 // -367
    CGFloat offsetY = scrollView.contentOffset.y + 370;
    
    // 获取topview的高度
    CGFloat height = 370 - offsetY;
   // ONELog(@"y%.1f offsetY%.1f height%.1f image%.1f", scrollView.contentOffset.y, offsetY, height, _imageView.height);
    if (offsetY == 0) return;
    
    if (offsetY > 0)
    {
        _topViewTop.constant = -offsetY;
    }else{
        _topViewH.constant = height;
    }
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

#pragma mark - ONEPersonDetailTableViewDelegate
#pragma mark 点击小记时调用此方法
- (void)personDetailTableView:(ONEPersonDetailTableView *)detailTableView didChilckSubtotalBtn:(UIButton *)subtotalBtn
{
    UIViewController *subtotalVc = [UIViewController new];
    subtotalVc.navigationItem.title = @"小计";
    subtotalVc.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController pushViewController:subtotalVc animated:true];
}


#pragma mark 点击歌单时调用此方法
- (void)personDetailTableView:(ONEPersonDetailTableView *)detailTableView didChilckSonglistBtn:(UIButton *)songlistBtn
{
    UIViewController *songlistVc = [UIViewController new];
    songlistVc.navigationItem.title = @"ta的歌单";
    songlistVc.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController pushViewController:songlistVc animated:true];
}

@end
