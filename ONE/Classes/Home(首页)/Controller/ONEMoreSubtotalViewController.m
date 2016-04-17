//
//  ONEMoreSubtotalViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/17.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import "ONEMoreSubtotalViewController.h"
#import "ONEMoreSubtotalCell.h"
#import "ONEDataRequest.h"
#import "ONEMoreSubtotalLayout.h"

@interface ONEMoreSubtotalViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) ONEMoreSubtotalLayout *subtotalLayout;
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *subtotalArr;

@end

@implementation ONEMoreSubtotalViewController

static NSString * const moreSubtotalCell = @"moreSubtotalCell";

#pragma mark - lazy load
- (ONEMoreSubtotalLayout *)subtotalLayout
{
    if (_subtotalLayout == nil)
    {
       ONEMoreSubtotalLayout *layout =  [ONEMoreSubtotalLayout new];
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:_subtotalLayout = layout];
        collectionView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.8];
        [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(ONEMoreSubtotalCell.class) bundle:nil] forCellWithReuseIdentifier:moreSubtotalCell];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.contentInset = UIEdgeInsetsMake(ONENavBMaxY + ONEDefaultMargin, 0, ONEDefaultMargin, 0);
        collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(ONENavBMaxY, 0, 0, 0);
        [self.view addSubview:_collectionView = collectionView];
    }
    
    return _subtotalLayout;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = false;
    [self loadData];
}

- (void)loadData
{
    ONEWeakSelf
    NSString *url = [@"bymonth" stringByAppendingPathComponent:self.month];
    [SVProgressHUD show];
    [ONEDataRequest requestHomeSubtotal:url paramrters:nil success:^(NSArray *homeSubtotal) {
        [SVProgressHUD dismiss];
        if (!homeSubtotal.count) return;
        
        weakSelf.subtotalArr = homeSubtotal;
        weakSelf.subtotalLayout.subtotalArr = homeSubtotal;
        [weakSelf.collectionView reloadData];
        
    } failure:nil];
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.subtotalArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ONEMoreSubtotalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:moreSubtotalCell forIndexPath:indexPath];
    cell.subtotalItem = self.subtotalArr[indexPath.row];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:true];
}

@end
