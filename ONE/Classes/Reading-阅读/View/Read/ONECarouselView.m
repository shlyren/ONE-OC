//
//  ONECarouselView.m
//  ONE
//
//  Created by 任玉祥 on 16/4/14.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONECarouselView.h"
#import "UIImageView+WebCache.h"

@interface ONEReadAdCell : UICollectionViewCell
@property (nonatomic, weak) UIImageView *imageView;
@end

@implementation ONEReadAdCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview: _imageView = imageView];
    }
    return self;
}

@end

@interface ONECarouselView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) UIPageControl    *pageControl;
@property (nonatomic, weak) NSTimer          *timer;

@end

@implementation ONECarouselView

static NSString *const readAdCell = @"readAdCell";

#define COLLECTION_MAX_SECTION 10
#define PAGECONTROL_HEIGHT 25

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = self.bounds.size;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.scrollsToTop = false;
        collectionView.showsVerticalScrollIndicator = false;
        collectionView.showsHorizontalScrollIndicator = false;
        collectionView.pagingEnabled = true;
        [collectionView registerClass:[ONEReadAdCell class]
           forCellWithReuseIdentifier:readAdCell];
        [self addSubview:self.collectionView = collectionView];
        
        UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.height - PAGECONTROL_HEIGHT, self.width, PAGECONTROL_HEIGHT)];
        pageControl.currentPageIndicatorTintColor = ONEDefaultColor;
        pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:0.8 alpha:0.8];
        
        [self addSubview:_pageControl = pageControl];
    }
    
    return self;
}

- (void)setImageNames:(NSArray *)imageNames
{
    _imageNames = imageNames;
    
    // 如果是url
    if ([imageNames.firstObject isKindOfClass:[NSString class]]) {
        if (![imageNames.firstObject hasPrefix:@"http"]) return;
    }
    
    self.pageControl.numberOfPages = imageNames.count;
    self.pageControl.currentPage = 0;
    self.collectionView.pagingEnabled = imageNames.count;
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:COLLECTION_MAX_SECTION / 2] atScrollPosition:UICollectionViewScrollPositionLeft animated:false];
    
    [self.collectionView performBatchUpdates:^{
        [self stopTimer];
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
    } completion:^(BOOL finished) {
        [self startTimer];
    }];
}

/** 重置页面索引 */
- (NSIndexPath *)resetPage
{
    // 获取当前显示的item 索引
    NSIndexPath *currentIndexPath = [self.collectionView indexPathsForVisibleItems].lastObject;
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:COLLECTION_MAX_SECTION / 2];
    
    [_collectionView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:false];
    return currentIndexPathReset;
}

/** 显示下一页 */
- (void)showNextPage
{
    NSIndexPath *currentPage = self.resetPage;
    NSInteger nextItem = currentPage.item + 1;
    NSInteger nextSection = currentPage.section;
    if (nextItem >= _imageNames.count)
    {
        nextItem = 0;
        nextSection++;
    }
    
    NSIndexPath *nextPagePath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    [_collectionView scrollToItemAtIndexPath:nextPagePath atScrollPosition:UICollectionViewScrollPositionLeft animated:true];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return COLLECTION_MAX_SECTION;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageNames.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ONEReadAdCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:readAdCell forIndexPath:indexPath];
    
    // url
    if ([self.imageNames[indexPath.row] isKindOfClass:[NSString class]])
    {
           [cell.imageView sd_setImageWithURL:[NSURL URLWithString:self.imageNames[indexPath.row]] placeholderImage:[UIImage imageNamed:@"top10"]];
    }
    // UIImage对象
    else if ([self.imageNames[indexPath.row] isKindOfClass:[UIImage class]])
    {
        cell.imageView.image = self.imageNames[indexPath.row];
    }

    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(carouselView:didSelectItemAtIndexPath:)])
    {
        NSIndexPath *currentIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
        [self.delegate carouselView:self didSelectItemAtIndexPath:currentIndexPath];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offfsetx = scrollView.contentOffset.x;
    NSInteger page = (NSInteger)(offfsetx / self.width + 0.5) % (self.imageNames.count);
    
    if (self.pageControl.currentPage !=page)
    {
        self.pageControl.currentPage = page;
    }

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}

- (NSTimeInterval)intervalTime
{
    if (_intervalTime <= 0) return 2.0;
    return _intervalTime;
}

- (void)startTimer
{
    if (_imageNames.count < 2) return;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.intervalTime
                                                  target:self
                                                selector:@selector(showNextPage)
                                                userInfo:nil
                                                 repeats:true];
}

- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)dealloc
{
    [self stopTimer];
    self.collectionView.delegate = nil;
}

@end
