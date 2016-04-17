//
//  ONECarouselDetailViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/16.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import "ONECarouselDetailViewController.h"
#import "ONENavigationController.h"
#import "UIColor+Hex.h"
#import "ONEReadAdItem.h"
#import "ONEDataRequest.h"
#import "ONECarouselDetailCell.h"
#import "ONECarouselDetailItem.h"
#import "ONESerialDetailViewController.h"
#import "ONEEssayDetailViewController.h"

@interface ONECarouselDetailViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *carouselDetailItems;

@property (nonatomic, weak) UILabel *headerLabel;

@property (nonatomic, weak) UILabel *footerLabel;
@property (nonatomic, weak) UIView *footerView;

@end

@implementation ONECarouselDetailViewController

static NSString *const carouselDetailCell = @"carouselDetailCell";

#pragma mark - lazy load
- (UILabel *)headerLabel
{
    if (_headerLabel == nil)
    {
        UILabel *headerLabel = [UILabel new];
        headerLabel.backgroundColor = [UIColor clearColor];
        headerLabel.textColor = [UIColor whiteColor];
        headerLabel.height = 50;
        headerLabel.textAlignment = NSTextAlignmentCenter;
        self.tableView.tableHeaderView = _headerLabel = headerLabel;
    }
    return _headerLabel;
}

- (UILabel *)footerLabel
{
    if (_footerLabel == nil)
    {
        UIView *footerView = [UIView new];
        footerView.backgroundColor = [UIColor clearColor];
        footerView.height = 500;
        self.tableView.tableFooterView = _footerView = footerView;
       
        UILabel *footerLabel = [[UILabel alloc] init];
        footerLabel.backgroundColor = [UIColor clearColor];
        footerLabel.textColor = [UIColor whiteColor];
        footerLabel.numberOfLines = 0;
        footerLabel.x = 30;
        footerLabel.width = [UIScreen mainScreen].bounds.size.width - 2 * 30;
        footerLabel.centerY = _footerView.height * 0.5 - 50;
        footerLabel.textAlignment = NSTextAlignmentCenter;
        [footerView addSubview:_footerLabel = footerLabel];
        
    }
    return _footerLabel;
}


#pragma mark - initial
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView
{
    self.automaticallyAdjustsScrollViewInsets = false;
    self.tableView.contentInset = UIEdgeInsetsMake(40, 0, 0, 0);
    self.tableView.separatorInset = self.tableView.contentInset;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"ONECarouselDetailCell" bundle:nil] forCellReuseIdentifier:carouselDetailCell];
}

#pragma mark - data
- (void)setAdItem:(ONEReadAdItem *)adItem
{
    _adItem = adItem;
    self.view.backgroundColor = [UIColor colorWithHexString:adItem.bgcolor];
    self.headerLabel.text = adItem.title;
    self.footerLabel.text = adItem.bottom_text;
    [self.headerLabel sizeToFit];
    [self.footerLabel sizeToFit];
    
    ONEWeakSelf
    [ONEDataRequest requestCarousel:adItem.ad_id paramrters:nil success:^(NSArray *carouselDetailItem) {
        if (carouselDetailItem.count)
        {
            weakSelf.carouselDetailItems = carouselDetailItem;
            [weakSelf.tableView reloadData];
        }
    } failure:nil];
    
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.carouselDetailItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    ONECarouselDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:carouselDetailCell];
    ONECarouselDetailItem *item = self.carouselDetailItems[indexPath.row];
    
    item.number = [NSString stringWithFormat:@"%zd", indexPath.row + 1];
    cell.carouselDetailItem = item;
    
    return cell;
}
#pragma mark - table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ONECarouselDetailItem *item = self.carouselDetailItems[indexPath.row];
    
    if ([item.type isEqualToString:@"1"])
    {
        ONEEssayDetailViewController *essayVc = [ONEEssayDetailViewController new];
        essayVc.detail_id = item.item_id;
        [self.navigationController pushViewController:essayVc animated:true];
    }
    
    if ([item.type isEqualToString:@"2"])
    {
        ONESerialDetailViewController *serialVc = [ONESerialDetailViewController new];
        serialVc.detail_id = item.item_id;
        [self.navigationController pushViewController:serialVc animated:true];
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ONECarouselDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:carouselDetailCell];
    cell.carouselDetailItem = self.carouselDetailItems[indexPath.row];
    return cell.rowHeight;
}

#pragma mark - events
- (IBAction)closeBtnClick
{
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
