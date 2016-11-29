//
//  ONESearchViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/18.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONESearchViewController.h"
#import "ONESearchBaseViewController.h"
#import "ONESearchHpViewController.h"
#import "ONESearchReadViewController.h"
#import "ONESearchMovieViewController.h"
#import "ONESearchAuthorViewController.h"
#import "ONESearchMusicViewController.h"
#import "ONEReadTitleButton.h"

@interface ONESearchViewController ()<UISearchBarDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@property (nonatomic, weak) UIScrollView        *scrollView;
@property (nonatomic, weak) UIView              *titlesView;
@property (nonatomic, weak) UIView              *titlesLineView;
@property (nonatomic, weak) ONEReadTitleButton  *selectedBtn;

@property (nonatomic, strong) NSString          *searhKey;

@end

@implementation ONESearchViewController

- (UIScrollView *)scrollView
{
    if (_scrollView == nil)
    {
        NSArray *titles = @[@"插图", @"阅读", @"音乐", @"影视", @"作者"];
        
        // scrollView
        {
            UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 65, ONEScreenWidth, ONEScreenHeight - 65)];
            scrollView.delegate = self;
            scrollView.contentSize = CGSizeMake(scrollView.width * titles.count, 0);
            scrollView.pagingEnabled = true;
            scrollView.scrollsToTop = false;
            scrollView.showsVerticalScrollIndicator = false;
            scrollView.showsHorizontalScrollIndicator = false;
            [self.view addSubview:_scrollView = scrollView];
        }
        
        // titlesView
        {
            UIView *titlesView = [[UIView alloc] initWithFrame:CGRectMake(0, _scrollView.y, ONEScreenWidth, 30)];
            titlesView.backgroundColor = ONEColor(248, 248, 248, 0.9);
            [self.view addSubview: _titlesView = titlesView];
        }
        
        // titleBtn
        {
            CGFloat titleButtonW = ONEScreenWidth / titles.count;
            for (NSInteger i = 0; i < titles.count; i++)
            {
                ONEReadTitleButton *titleBtn = [[ONEReadTitleButton alloc] initWithFrame:CGRectMake(i * titleButtonW, 0, titleButtonW, _titlesView.height)];
                titleBtn.titleLabel.font = [UIFont systemFontOfSize:12];
                titleBtn.tag = i;
                [titleBtn setTitle:titles[i] forState:UIControlStateNormal];
                [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [_titlesView addSubview:titleBtn];
                
                if (i == 0) [self titleBtnClick:titleBtn];
            }
        }
        
        // titleLineView
        {
            CGFloat titleLineViewH = 2;
            CGFloat titleLineViewY = _titlesView.height - titleLineViewH;
            
            UIView *titlesLineView = [UIView new];
            titlesLineView.backgroundColor = [_selectedBtn titleColorForState:UIControlStateSelected];
            titlesLineView.frame = CGRectMake(0, titleLineViewY, 0, titleLineViewH);
            [self.titlesView addSubview:_titlesLineView = titlesLineView];
            
            [_selectedBtn.titleLabel sizeToFit];
            titlesLineView.width = _selectedBtn.titleLabel.width;
            titlesLineView.centerX = _selectedBtn.width * 0.5;
        }
    
    }
    return _scrollView;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupAllViewController];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.searchBar becomeFirstResponder];
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


- (void)setupAllViewController
{
    [self addChildViewController:ONESearchHpViewController.new];
    [self addChildViewController:ONESearchReadViewController.new];
    [self addChildViewController:ONESearchMusicViewController.new];
    [self addChildViewController:ONESearchMovieViewController.new];
    [self addChildViewController:ONESearchAuthorViewController.new];

}

#pragma mark - Events
- (void)titleBtnClick:(ONEReadTitleButton *)btn
{
    if (self.selectedBtn == btn) return;
    
    self.selectedBtn.selected = false;
    btn.selected = true;
    self.selectedBtn = btn;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.titlesLineView.centerX = btn.centerX;
        self.titlesLineView.width = btn.titleLabel.width;
        
        CGPoint offset = self.scrollView.contentOffset;
        offset.x = btn.tag * self.scrollView.width;
        [self.scrollView setContentOffset:offset animated:false];
        
    } completion:^(BOOL finished) {
        // 懒加载
        ONESearchBaseViewController *childVc = self.childViewControllers[btn.tag];
        childVc.view.frame = self.scrollView.bounds;
        childVc.searchKey = [self.searhKey stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet controlCharacterSet]];
        [self.scrollView addSubview:childVc.view];
        
    }];
    
    // 设置滚动到顶部
    for (NSInteger i = 0; i < self.childViewControllers.count; i++)
    {
        UIViewController *childVc = self.childViewControllers[i];
        
        if (!childVc.isViewLoaded) continue;
        if (![childVc.view isKindOfClass:[UIScrollView class]]) continue;
        
        UIScrollView *scrollView = (UIScrollView *)childVc.view;
        scrollView.scrollsToTop = i == btn.tag;
        
    }
}

- (IBAction)cancel
{
    [self.view endEditing:true];
    [self dismissViewControllerAnimated:true completion:nil];
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:true];
    if ([searchBar.text isEqualToString:self.searhKey]) return;
    
    self.searhKey = searchBar.text;
    NSInteger index = self.scrollView.contentOffset.x / ONEScreenWidth;
    ONESearchBaseViewController *childVc = self.childViewControllers[index];
    childVc.view.frame = self.scrollView.bounds;
    childVc.searchKey = [searchBar.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet controlCharacterSet]];
    [self.scrollView addSubview:childVc.view];
    
    self.bgImageView.hidden = true;
}

#pragma mark - scrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / ONEScreenWidth;
    [self titleBtnClick:self.titlesView.subviews[index]];
}


@end
