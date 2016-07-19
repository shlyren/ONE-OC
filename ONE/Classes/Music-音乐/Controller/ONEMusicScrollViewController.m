//
//  ONEMusicScrollViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/2.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEMusicScrollViewController.h"
#import "ONEMusicViewController.h"
#import "ONEDataRequest.h"
#import "ONEPastListViewController.h"

@interface ONEMusicScrollViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *musicListArray;

@property (nonatomic, weak) ONEMusicViewController *musicVc;
@end

@implementation ONEMusicScrollViewController

#pragma mark - lazy load
- (ONEMusicViewController *)musicVc
{
    if (_musicVc == nil)
    {
        ONEMusicViewController *musicVc = [ONEMusicViewController new];
        [self addChildViewController:_musicVc = musicVc];
    }
    return _musicVc;
}

#pragma mark - initial
#pragma mark initial view
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = false;
    [self setUpData];
}

- (void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.contentSize = CGSizeMake(self.musicListArray.count * ONEScreenWidth, 0);
    scrollView.pagingEnabled = true;
    scrollView.delegate = self;
    scrollView.alwaysBounceHorizontal = true;
    scrollView.scrollsToTop = false;
    
    [self.view addSubview:scrollView];
    
    self.musicVc.detailIdUrl = self.musicListArray[0];
    self.musicVc.view.frame = self.view.bounds;
    [scrollView addSubview:self.musicVc.view];
    
}

#pragma mark data
- (void)setUpData
{
    ONEWeakSelf
    [SVProgressHUD show];
    [ONEDataRequest requsetMusciIdList:@"0" parameters:nil success:^(NSArray *musicIdList) {
        if (musicIdList.count)
        {
            weakSelf.musicListArray = musicIdList;
            [weakSelf setupScrollView];
        }
    } failure:nil];
}

#pragma mark - scrollView delegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //ONELog(@"%.1f > %.1f",scrollView.contentOffset.x, (self.musicListArray.count - 0.8)* scrollView.width)
    
    if (scrollView.contentOffset.x > (self.musicListArray.count - 0.8) * scrollView.width)
    {
        ONEPastListViewController *pastListVc = [ONEPastListViewController new];
        pastListVc.endMonth = @"2016-01";
        [self.navigationController pushViewController:pastListVc animated:true];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    static NSInteger preIndex = 0;
    NSInteger index = scrollView.contentOffset.x / ONEScreenWidth;
    ONELog(@"%zd", index)
    if (preIndex == index) return;
    
    for (UIView *subView in scrollView.subviews)
    {
        [subView removeFromSuperview];
    }
    [self.musicVc removeFromParentViewController];
    
    self.musicVc.detailIdUrl = self.musicListArray[index];
    self.musicVc.view.frame = scrollView.bounds;
    [scrollView addSubview:self.musicVc.view];

    preIndex = index;
}

@end
