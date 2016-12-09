//
//  ONEMovieDetailHeaderView.m
//  ONE
//
//  Created by 任玉祥 on 16/4/11.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEMovieDetailHeaderView.h"
#import "ONEMovieDetailItem.h"
#import "ONEDataRequest.h"
#import "UIImageView+WebCache.h"
#import "ONEMovieDetailPhotoCell.h"
#import "ONEMovieStoryItem.h"
#import "ONEMovieResultItem.h"
#import "NSMutableAttributedString+string.h"
#import "ONEDataRequest.h"
#import "ONEPersonDetailViewController.h"
#import "ONENavigationController.h"
#import "UIViewController+Extension.h"
#import "ONEMovieScoreView.h"
#import "ONEShareTool.h"

#import "ONEHttpTool.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ONEMovieDetailHeaderView ()<UICollectionViewDelegate, UICollectionViewDataSource,UINavigationControllerDelegate>
@property (nonatomic, strong) ONEMovieDetailItem        *movieDetail;
@property (nonatomic, strong) ONEMovieResultItem        *movieStoryResult;
/** 顶部的image  */
@property (weak, nonatomic) IBOutlet UIImageView        *coverImgView;

@property (nonatomic, weak) ONEMovieScoreView *movieScoreView;

#pragma mark - 电影故事相关
/*************************  电影故事相关  *******************************/

/** 故事View 的CoverView */
@property (strong, nonatomic) IBOutlet UIView           *storyCoverView;
/** coverView的高度 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *storyCoverViewHeight;
/** 电影故事的view xib */
@property (strong, nonatomic) IBOutlet UIView           *movieStoryView;
/** 用户头像 */
@property (weak, nonatomic) IBOutlet UIButton           *userIconBtn;
@property (weak, nonatomic) IBOutlet UIImageView        *iconImageView;
/** 用户名字 */
@property (weak, nonatomic) IBOutlet UILabel            *userNamelbel;

@property (weak, nonatomic) IBOutlet UIButton           *praisenumBtn;

/** 创作时间 */
@property (weak, nonatomic) IBOutlet UILabel            *inputTimeLabel;
/** 标题 */
@property (weak, nonatomic) IBOutlet UILabel            *titleLabel;
/** 内容 */
@property (weak, nonatomic) IBOutlet UILabel            *contentLabel;
/** 共多少个电影故事 */
@property (weak, nonatomic) IBOutlet UILabel            *movieStoryCountLabel;


#pragma mark - 电影简介相关
/************************  电影简介相关  **************************/
/** 简介的coverView */
@property (weak, nonatomic) IBOutlet UIView             *movieStoryCoverView;
/** 电影按钮 */
@property (weak, nonatomic) IBOutlet UIButton           *movieBtn;
/** 关键字的view */
@property (strong, nonatomic) IBOutlet UIView           *keywordView;
/** 标题 */
@property (weak, nonatomic) IBOutlet UILabel            *oneMovieTitleLabel;
/** 存放标题的数组 */
@property (nonatomic, strong) NSArray                   *oneMovieTitles;
/** 选中的按钮 */
@property (nonatomic, weak) UIButton                    *selectedBtn;
/** photo Collection */
@property (nonatomic, strong) UICollectionView          *collectionView;
/** 简介的label */
@property (nonatomic, strong) UILabel                   *infoLabel;
/** 当前的View */
@property (nonatomic, weak) UIView                      *currentView;


@property (nonatomic, strong) UIView                    *bigImgCoverView;
@property (nonatomic, weak) UIImageView                 *bigImageView;

@end

@implementation ONEMovieDetailHeaderView

static NSString *const photoCellID = @"photoCell";
#pragma mark - lazy load
- (ONEMovieScoreView *)movieScoreView
{
    if (_movieScoreView == nil) {
        ONEMovieScoreView *movieScoreView = [[ONEMovieScoreView alloc] initWithFrame:CGRectMake(self.coverImgView.width - 90, self.coverImgView.height - 20, 90, 50)];
        
        [self addSubview:_movieScoreView = movieScoreView];
    }
    
    return _movieScoreView;
}

- (UIView *)bigImgCoverView
{
    if (_bigImgCoverView == nil) {
        
        UIView *coverView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        coverView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.9];
        coverView.alpha = 0.0;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverViewClick)];
        [coverView addGestureRecognizer:tap];
        _bigImgCoverView = coverView;
        
    }
    return _bigImgCoverView;
}

- (UIImageView *)bigImageView
{
    if (_bigImageView == nil)
    {
        UIImageView *bigImgView = [UIImageView new];
        [self.bigImgCoverView addSubview:_bigImageView = bigImgView];
    }
    return _bigImageView;
}


- (UICollectionView *)collectionView
{
    if (_collectionView == nil)
    {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(_movieStoryCoverView.height * 1.5, _movieStoryCoverView.height);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 5;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.movieStoryCoverView.bounds collectionViewLayout:layout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.showsHorizontalScrollIndicator = false;
        collectionView.scrollsToTop = false;
        [collectionView registerNib:[UINib nibWithNibName:@"ONEMovieDetailPhotoCell" bundle:nil] forCellWithReuseIdentifier:photoCellID];
           _collectionView = collectionView;
    }
    return _collectionView;
}

- (UILabel *)infoLabel
{
    if (_infoLabel == nil)
    {
        UILabel *infoLabel = [[UILabel alloc] initWithFrame:self.movieStoryCoverView.bounds];
        infoLabel.text     = _movieDetail.info;
        infoLabel.x       += ONEDefaultMargin;
        infoLabel.width    = ONEScreenWidth - infoLabel.x;
        infoLabel.font     = [UIFont systemFontOfSize:14];
        infoLabel.numberOfLines = 0;
        _infoLabel = infoLabel;
    }
    return _infoLabel;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.keywordView.frame                    = CGRectMake(0, 0, ONEScreenWidth, 110);
    self.movieStoryView.frame                 = CGRectMake(0, 0, ONEScreenWidth, 110);
    self.contentLabel.preferredMaxLayoutWidth = ONEScreenWidth - 60;
    self.movieStoryCoverView.backgroundColor  = [UIColor whiteColor];

}

- (IBAction)imageViewTarget:(UITapGestureRecognizer *)sender
{
    
    if (!self.movieDetail.video) return;
    
    if ([ONEHttpTool currentNetWorkStatus] != ONENetWorkStatusIsWiFi)
    {
        [self showAlertController];
        
    } else {
        
        [self playVideo];
    }
}

- (void)playVideo
{
    
    AVPlayerViewController *playerVc = [AVPlayerViewController new];
    playerVc.allowsPictureInPicturePlayback = true;

    NSURL *url = [NSURL URLWithString:self.movieDetail.video];
    playerVc.player = [AVPlayer playerWithURL:url];
    

    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:playerVc animated:true completion:^{
        [playerVc.player play];
    }];
}


- (void)showAlertController
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"网络流量提醒" message:@"当前网络为非WI-FI状态,在线播放将消耗您的网络流量" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"继续播放" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self playVideo];
    }];
    
    [alertController addAction:action1];
    [alertController addAction:action2];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:true completion:nil];
}

#pragma mark - 加载数据
- (void)setMovie_id:(NSString *)movie_id
{
    _movie_id = movie_id;
    _oneMovieTitles = @[@"一个电影表", @"剧照", @"演职人员"];
    ONEWeakSelf
    
    [ONEDataRequest requestMovieStory:[movie_id stringByAppendingPathComponent:@"story/1/0"] parameters:nil success:^(ONEMovieResultItem *movieStory) {
        if (movieStory)
        {
            weakSelf.movieStoryResult = movieStory;
            [weakSelf setupStoryView];
        }
    } failure:nil];
    

    [ONEDataRequest requestMovieDetail:movie_id parameters:nil success:^(ONEMovieDetailItem *movieDetail) {
        if (movieDetail)
        {
            weakSelf.movieDetail = movieDetail;
            [weakSelf movieIntroduce];
        }
    } failure:nil];
}


#pragma mark 电影故事的view
- (void)setupStoryView
{
    [self.storyCoverView addSubview: self.movieStoryView];
    
    self.movieStoryCountLabel.text = [NSString stringWithFormat:@"共%zd个电影故事",self.movieStoryResult.count];
    
    ONEMovieStoryItem *movieStory = self.movieStoryResult.data[0];
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:movieStory.user.web_url] placeholderImage:[UIImage imageNamed:@"author_cover"]];
    
    self.userNamelbel.text           = movieStory.user.user_name;
    self.titleLabel.text             = movieStory.title;
    self.inputTimeLabel.text         = movieStory.input_date;
    self.contentLabel.attributedText = [NSMutableAttributedString attributedStringWithString:movieStory.content];
    
    [self.praisenumBtn setTitle:[NSString stringWithFormat:@"%zd", movieStory.praisenum] forState:UIControlStateNormal];
    [self.contentLabel sizeToFit];
    [self layoutIfNeeded];

    self.storyCoverViewHeight.constant = self.contentLabel.height + 110;
    
    if ([self.delegate respondsToSelector:@selector(movieDetailHeaderView:didChangedStoryContent:)])
    {
        [self.delegate movieDetailHeaderView:self didChangedStoryContent:self.contentLabel.height];
    }
    
}

#pragma mark 电影简介
- (void)movieIntroduce
{
    [self.coverImgView sd_setImageWithURL:[NSURL URLWithString:_movieDetail.detailcover] placeholderImage:[UIImage imageNamed:@"movie"]];
    
    [self.movieScoreView setScoreTitle:_movieDetail.score];
    
    for (NSInteger i = 0; i < self.keywordView.subviews[1].subviews.count; i++)
    {
        UILabel *textLabel = self.keywordView.subviews[1].subviews[i];
        textLabel.text = [_movieDetail.keywords componentsSeparatedByString:@";"][i];
    }
    [self oneMovieBtnClick:_movieBtn];
}

- (IBAction)storyViewLikeBtnClick:(UIButton *)btn
{
    ONEMovieStoryItem *movieStory = self.movieStoryResult.data[0];
    NSString *url = _praisenumBtn.selected ? movie_unpraisestory : movie_praisestory;
    
    NSDictionary *parameters = @{
                                 @"movieid" : movieStory.movie_id,
                                 @"storyid" : movieStory.movie_story_id // detailID
                                 };
    [ONEDataRequest addPraise:url parameters:parameters success:^(BOOL isSuccess, NSString *message) {
        if (!isSuccess)
        {
            [SVProgressHUD showErrorWithStatus:message];
            return;
        }
        _praisenumBtn.selected = !_praisenumBtn.selected;
        NSInteger praisenum = _praisenumBtn.selected ? ++movieStory.praisenum : --movieStory.praisenum;
        
        [_praisenumBtn setTitle:[NSString stringWithFormat:@"%zd", praisenum] forState:UIControlStateNormal];
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"操作失败"];
    }];
    
}
- (IBAction)shareBtnClick {
    [ONEShareTool showShareView:self.window.rootViewController
                        content:self.movieDetail.title
                            url:self.movieDetail.web_url
                          image:self.coverImgView.image];

}

- (IBAction)iconBtnClick
{
    ONEPersonDetailViewController *detailVc = [ONEPersonDetailViewController new];
    detailVc.user_id = [self.movieStoryResult.data[0] user_id];
    ONENavigationController *nav = [[ONENavigationController alloc] initWithRootViewController:detailVc];
    [self.window.rootViewController.topViewController presentViewController:nav animated:true completion:nil];

}

- (IBAction)allMovieStoryBtnClick
{
    if ([self.delegate respondsToSelector:@selector(movieDetailHeaderView:didClickAllBtn:)])
    {
        [self.delegate movieDetailHeaderView:self didClickAllBtn:@"电影故事"];
    }
}


- (IBAction)oneMovieBtnClick:(UIButton *)btn
{
    if (self.selectedBtn == btn) return;
    
    self.oneMovieTitleLabel.text = self.oneMovieTitles[btn.tag];
    self.selectedBtn.selected    = false;
    self.selectedBtn             = btn;
    btn.selected                 = true;
    
    [self.currentView removeFromSuperview];
    if (btn.tag == 0) self.currentView = self.keywordView;
    if (btn.tag == 1) self.currentView = self.collectionView;
    if (btn.tag == 2) self.currentView = self.infoLabel;
    [self.movieStoryCoverView addSubview:self.currentView];
    
}

#pragma mark - collectionView data source
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.movieDetail.photo.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ONEMovieDetailPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:photoCellID forIndexPath:indexPath];
    cell.photoName = self.movieDetail.photo[indexPath.row];
    return cell;
}

#pragma mark - collectionVoew delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *imageName = self.movieDetail.photo[indexPath.row];
    [self didClickPhoto:imageName];
    
}

- (void)didClickPhoto:(NSString *)imageName
{
    [[UIApplication sharedApplication].keyWindow addSubview:self.bigImgCoverView];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.bigImgCoverView.alpha  = 1;
    }];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = true;
    
    
    [self.bigImageView sd_setImageWithURL:[NSURL URLWithString:imageName] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        CGFloat height = image.size.height / image.size.width * ONEScreenWidth;
        self.bigImageView.size = CGSizeMake(ONEScreenWidth, height);
        self.bigImageView.center = self.bigImgCoverView.center;
        
        [SVProgressHUD dismiss];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = false;
    }];
    
}

- (void)coverViewClick
{
    [UIView animateWithDuration:0.5 animations:^{
        
        self.bigImgCoverView.alpha   = 0;
        
    } completion:^(BOOL finished) {
        
        [self.bigImgCoverView removeFromSuperview];
        
    }];
}

#pragma  mark - 加载nib
+ (NSArray *)loadViewsFromNib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
}

+ (instancetype)tableHeaderView
{
    return self.loadViewsFromNib[0];
}
+ (instancetype)reviewSectionHeaderView
{
    return self.loadViewsFromNib[1];
}
+ (instancetype)reviewSectionFooterView
{
    return self.loadViewsFromNib[2];
}
+ (instancetype)commentSectionHeaderView
{
    return self.loadViewsFromNib[3];
}
//
///**
// *  通过一个字符截取整个字符串
// *
// *  @param string 需要截取的字符串
// *  @param str
// *
// *  @return 截取后的数组
// */
//- (NSArray<NSString *> *)cutoffString:(NSString *)string byString:(NSString *)str
//{
//    NSMutableString *mutableStr = [[NSMutableString alloc] initWithString:[string stringByAppendingString:str]];
//    NSMutableArray *mutableArr  = [NSMutableArray array];
//    NSRange range               = [mutableStr rangeOfString:str];
//    
//   // [string componentsSeparatedByString:str];
//    
//    while (range.location != NSNotFound)
//    {
//        [mutableArr addObject:[mutableStr substringToIndex:range.location]];
//        [mutableStr deleteCharactersInRange:NSMakeRange(0, range.location + range.length)];
//        range = [mutableStr rangeOfString:str];
//    }
//    
//    return mutableArr;
//}
@end
