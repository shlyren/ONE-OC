//
//  ONEMoreSubtotalViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/17.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEMoreSubtotalViewController.h"
#import "ONEMoreSubtotalCell.h"
#import "ONEDataRequest.h"
#import "ONEMoreSubtotalLayout.h"
#import "ONESubtotalDetailViewController.h"

@interface ONEMoreSubtotalViewController ()<UICollectionViewDataSource,
                                            UICollectionViewDelegate,
                                            ONEMoreSubtotalLayoutDelegate>

@property (nonatomic, weak) UICollectionView      *collectionView;
@property (nonatomic, strong) NSArray             *subtotalArr;

@end

@implementation ONEMoreSubtotalViewController

static NSString *const moreSubtotalCell = @"moreSubtotalCell";

#pragma mark - lazy load
- (UICollectionView *)collectionView
{
    if (_collectionView == nil)
    {
        ONEMoreSubtotalLayout *layout =  [ONEMoreSubtotalLayout new];
        layout.delegate = self;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.8];
        [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(ONEMoreSubtotalCell.class) bundle:nil] forCellWithReuseIdentifier:moreSubtotalCell];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.contentInset = UIEdgeInsetsMake(ONENavBMaxY, 0, 0, 0);
        collectionView.scrollIndicatorInsets = collectionView.contentInset;
        [self.view addSubview:_collectionView = collectionView];
        
    }
    return _collectionView;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = false;
    [self loadData];
}

/**
 *  加载数据
 */
- (void)loadData
{
    ONEWeakSelf
    NSString *url = [@"bymonth" stringByAppendingPathComponent:self.month];
    
    [ONEDataRequest requestHomeSubtotal:url paramrters:nil success:^(NSArray *homeSubtotal) {
        [SVProgressHUD dismiss];
        if (!homeSubtotal.count) return;
        
        weakSelf.subtotalArr = homeSubtotal;
        [weakSelf.collectionView reloadData];
        
    } failure:nil];
}

#pragma mark - ONEMoreSubtotalLayoutDelegate
- (CGFloat)subtotallowLayout:(ONEMoreSubtotalLayout *)subtotallowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath
{
    return [self.subtotalArr[indexPath.row] height];
}

#pragma mark - <UICollectionViewDataSource>
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

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:true];
    
    ONESubtotalDetailViewController *detailVc = [ONESubtotalDetailViewController new];
    detailVc.subtotalItem = self.subtotalArr[indexPath.row];
    [self.navigationController pushViewController:detailVc animated:true];
}

@end
