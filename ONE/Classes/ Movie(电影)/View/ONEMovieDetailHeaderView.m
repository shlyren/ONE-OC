//
//  ONEMovieDetailHeaderView.m
//  ONE
//
//  Created by 任玉祥 on 16/4/11.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import "ONEMovieDetailHeaderView.h"
#import "ONEMovieDetailItem.h"
#import "ONEDataRequest.h"
#import "UIImageView+WebCache.h"
#import "ONEMovieDetailPhotoCell.h"
#import "ONEMovieStoryItem.h"
#import "ONEMovieResultItem.h"
#import "NSMutableAttributedString+string.h"

@interface ONEMovieDetailHeaderView ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) ONEMovieDetailItem        *movieDetail;
@property (nonatomic, strong) ONEMovieResultItem        *movieStoryResult;
/** 顶部的image  */
@property (weak, nonatomic) IBOutlet UIImageView        *coverImgView;

#pragma mark - 电影故事相关
/*************************  电影故事相关  *******************************/

/** 故事View 的CoverView */
@property (strong, nonatomic) IBOutlet UIView           *storyCoverView;
/** coverView的高度 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *storyCoverViewHeight;
/** 电影故事的view xib */
@property (strong, nonatomic) IBOutlet UIView             *movieStoryView;
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



/** 评审团 */
/** 共X条评审团短评 */
//@property (strong, nonatomic) IBOutlet UILabel *reviewCountLabel;


@end

@implementation ONEMovieDetailHeaderView
static NSString *const photoCellID = @"photoCell";
#pragma mark - lazy loading
- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
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
    if (_infoLabel == nil) {
        UILabel *infoLabel = [[UILabel alloc] initWithFrame:self.movieStoryCoverView.bounds];
        infoLabel.text = _movieDetail.info;
        infoLabel.x += 10;
        infoLabel.width = ONEScreenWidth - infoLabel.x;
        infoLabel.numberOfLines = 0;
        infoLabel.font = [UIFont systemFontOfSize:14];
        _infoLabel = infoLabel;
    }
    return _infoLabel;
}

- (void)awakeFromNib
{
    self.keywordView.frame = CGRectMake(0, 0, ONEScreenWidth, 110);
    self.movieStoryView.frame = CGRectMake(0, 0, ONEScreenWidth, 110);
    self.contentLabel.preferredMaxLayoutWidth = ONEScreenWidth - 60;
    self.movieStoryCoverView.backgroundColor = [UIColor whiteColor];
}

#pragma mark - 加载数据
- (void)setMovie_id:(NSString *)movie_id
{
    _movie_id = movie_id;
    _oneMovieTitles = @[@"一个电影表", @"剧照", @"演职人员"];
    ONEWeakSelf
    
    [ONEDataRequest requestMovieStory:[movie_id stringByAppendingPathComponent:@"story/1/0"] parameters:nil success:^(ONEMovieResultItem *movieStory) {
        if (movieStory) {
            weakSelf.movieStoryResult = movieStory;
            [weakSelf setupStoryView];
        }
        
    } failure:nil];
    
    [ONEDataRequest requestMovieDetail:movie_id parameters:nil success:^(ONEMovieDetailItem *movieDetail) {
        if (movieDetail) {
            weakSelf.movieDetail = movieDetail;
            [weakSelf setupDetailView];
        }
    } failure:nil];
}


- (void)setupStoryView
{
    [self.storyCoverView addSubview:self.movieStoryView];
    
    self.movieStoryCountLabel.text = [NSString stringWithFormat:@"共%zd个电影故事",self.movieStoryResult.count];
    
    ONEMovieStoryItem *movieStory = self.movieStoryResult.data[0];
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:movieStory.user.web_url] placeholderImage:[UIImage imageNamed:@"author_cover"]];
    self.userNamelbel.text = movieStory.user.user_name;
    self.titleLabel.text = movieStory.title;
    self.inputTimeLabel.text = movieStory.input_date;
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

- (void)setupDetailView
{
    [self.coverImgView sd_setImageWithURL:[NSURL URLWithString:_movieDetail.detailcover] placeholderImage:[UIImage imageNamed:@"movie"]];
    
    for (NSInteger i = 0; i < self.keywordView.subviews[1].subviews.count; i++)
    {
        UILabel *textLabel = self.keywordView.subviews[1].subviews[i];
        textLabel.text = [self cutoffString:_movieDetail.keywords byString:@";"][i];
    }
    [self oneMovieBtnClick:_movieBtn];
}


- (void)setReviewCount:(NSInteger)reviewCount
{
    _reviewCount = reviewCount;
}

- (IBAction)storyViewLikeBtnClick:(UIButton *)btn
{
    ONELog(@"点击了喜欢")
}



- (IBAction)allMovieStoryBtnClick
{
    ONELog(@"点击了全部电影")
}



- (IBAction)oneMovieBtnClick:(UIButton *)btn
{
    if (self.selectedBtn == btn) return;
    
    self.oneMovieTitleLabel.text = self.oneMovieTitles[btn.tag];
    self.selectedBtn.selected = false;
    self.selectedBtn = btn;
    btn.selected = true;
    
    [self.currentView removeFromSuperview];
    if (btn.tag == 0) self.currentView = self.keywordView;
    if (btn.tag == 1) self.currentView = self.collectionView;
    if (btn.tag == 2) self.currentView = self.infoLabel;
    [self.movieStoryCoverView addSubview: self.currentView];
    
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

/**
 *  通过一个字符截取整个字符串
 *
 *  @param string 需要截取的字符串
 *  @param str
 *
 *  @return 截取后的数组
 */
- (NSArray *)cutoffString:(NSString *)string byString:(NSString *)str
{
    NSMutableString *mutableStr = [[NSMutableString alloc] initWithString:[string stringByAppendingString:str]];
    NSMutableArray *mutableArr = [NSMutableArray array];
    NSRange range = [mutableStr rangeOfString:@";"];
    
    while (range.location != NSNotFound)
    {
        [mutableArr addObject:[mutableStr substringToIndex:range.location]];
        [mutableStr deleteCharactersInRange:NSMakeRange(0, range.location + range.length)];
        range = [mutableStr rangeOfString:@";"];
    }
    
    return mutableArr;
}
@end
