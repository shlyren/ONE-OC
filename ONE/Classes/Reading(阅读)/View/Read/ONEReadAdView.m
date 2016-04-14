//
//  ONEReadAdView.m
//  ONE
//
//  Created by 任玉祥 on 16/4/14.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import "ONEReadAdView.h"
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
        [self addSubview: _imageView = imageView];
    }
    return self;
}

@end

@interface ONEReadAdView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong)  UICollectionViewFlowLayout *layout;

@property (nonatomic, weak) UIPageControl *pageControl;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ONEReadAdView

static NSString *const readAdCell = @"readAdCell";

#define COLLECTION_MAX_SECTION 10
#define PAGECONTROL_HEIGHT 30
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = self.bounds.size;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _layout = layout;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor orangeColor];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.scrollsToTop = false;
        collectionView.showsVerticalScrollIndicator = false;
        collectionView.showsHorizontalScrollIndicator = false;
        collectionView.pagingEnabled = true;
        [collectionView registerClass:[ONEReadAdCell class] forCellWithReuseIdentifier:readAdCell];
        [self addSubview:self.collectionView = collectionView];
        
        UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.height - PAGECONTROL_HEIGHT, self.width, PAGECONTROL_HEIGHT)];
        pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        
        [self addSubview:_pageControl = pageControl];
    }
    
    return self;
}

- (void)setImageNames:(NSArray<NSString *> *)imageNames
{
    _imageNames = imageNames;
    
    self.pageControl.numberOfPages = imageNames.count;
    self.pageControl.currentPage = 0;
    self.collectionView.pagingEnabled = imageNames.count;
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:COLLECTION_MAX_SECTION / 2] atScrollPosition:UICollectionViewScrollPositionLeft animated:false];
    
    [self.collectionView performBatchUpdates:^{
        
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
    } completion:^(BOOL finished) {
        
        [self startTimer];
    }];
}

-(NSIndexPath*)resetPage
{
    NSIndexPath *currentIndexPath = [self.collectionView indexPathsForVisibleItems].lastObject;
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:COLLECTION_MAX_SECTION / 2];
    [_collectionView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:false];
    return currentIndexPathReset;
}

- (void)showNextPage
{
    NSIndexPath * currentPage = self.resetPage;
    NSInteger nextItem = currentPage.item + 1;
    NSInteger nextScetion = currentPage.section;
    if (nextItem >= _imageNames.count) {
        nextItem = 0;
        nextScetion++;
    }
    
    NSIndexPath * nextPagePath = [NSIndexPath indexPathForItem:nextItem inSection:nextScetion];
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
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:self.imageNames[indexPath.row]]];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(readAdView:didSelectItemAtIndexPath:)])
    {
        NSIndexPath *currentIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
        [self.delegate readAdView:self didSelectItemAtIndexPath:currentIndexPath];
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
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.intervalTime target:self selector:@selector(showNextPage) userInfo:nil repeats:true];
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
