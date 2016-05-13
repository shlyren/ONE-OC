//
//  ONEMovieCommentCell.m
//  ONE
//
//  Created by 任玉祥 on 16/4/11.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEMovieCommentCell.h"
#import "ONEMovieCommentItem.h"
#import "UIImageView+WebCache.h"
#import "NSMutableAttributedString+string.h"
#import "UIImage+image.h"
#import "ONEDataRequest.h"
#import "ONEMovieStoryItem.h"
#import "ONEPersonDetailViewController.h"
#import "ONENavigationController.h"
#import "UIViewController+Extension.h"

@interface ONEMovieCommentCell ()<UINavigationControllerDelegate>
/** 评论内容 */
@property (weak, nonatomic) IBOutlet UILabel     *commentContectLabel;
/** 喜欢 按钮 */
@property (weak, nonatomic) IBOutlet UIButton    *praisenumBtn;
/** 评论时间 */
@property (weak, nonatomic) IBOutlet UILabel     *inputDateLabel;
/** 用户名 */
@property (weak, nonatomic) IBOutlet UILabel     *userNameLabel;
/** 头像图片 */
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;

@property (nonatomic, strong) ONEAuthorItem *author;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation ONEMovieCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self = [[NSBundle mainBundle] loadNibNamed:@"ONEMovieCommentCell" owner:nil options:nil].firstObject;
    }
    return self;
}

- (void)awakeFromNib
{
    self.commentContectLabel.preferredMaxLayoutWidth = ONEScreenWidth - 80;
}

- (void)setCommentItem:(ONEMovieCommentItem *)commentItem
{
    _commentItem = commentItem;
    
    self.commentContectLabel.attributedText = [NSMutableAttributedString attributedStringWithString:commentItem.content];
    [self.commentContectLabel sizeToFit];
    
    [self.praisenumBtn setTitle:[NSString stringWithFormat:@"%zd", commentItem.praisenum] forState:UIControlStateNormal];
    [self.praisenumBtn addTarget:self action:@selector(praisenumBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.inputDateLabel.text = commentItem.input_date;
    self.scoreLabel.text = commentItem.score;
    
    self.author = commentItem.author ? commentItem.author : commentItem.user;
   
    self.userNameLabel.text = self.author.user_name;
    
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:self.author.web_url] placeholderImage:[UIImage imageNamed:@"author_cover"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (image == nil) return;
        self.iconImgView.image = image.circleImage;
    }];
    
}

- (void)setMovieStoryItem:(ONEMovieStoryItem *)movieStoryItem
{
    _movieStoryItem = movieStoryItem;
    self.commentContectLabel.attributedText = [NSMutableAttributedString attributedStringWithString:movieStoryItem.content];
    [self.commentContectLabel sizeToFit];
    
    [self.praisenumBtn setTitle:[NSString stringWithFormat:@"%zd", movieStoryItem.praisenum] forState:UIControlStateNormal];
    [self.praisenumBtn addTarget:self action:@selector(praisenumBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.inputDateLabel.text = movieStoryItem.input_date;
    
    self.author = movieStoryItem.user;
    
    self.userNameLabel.text = self.author.user_name;
    
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:self.author.web_url] placeholderImage:[UIImage imageNamed:@"author_cover"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (image == nil) return;
        self.iconImgView.image = image.circleImage;
    }];

}

- (CGFloat)rowHeight
{
    [self layoutIfNeeded];
    return CGRectGetMaxY(self.commentContectLabel.frame) + ONEDefaultMargin;
}


- (IBAction)iconBtnClick
{
    ONEPersonDetailViewController *detailVc = [ONEPersonDetailViewController new];
    detailVc.user_id = self.author.user_id;
    ONENavigationController *nav = [[ONENavigationController alloc] initWithRootViewController:detailVc];
    nav.delegate = self;
    [self.window.rootViewController.topViewController presentViewController:nav animated:true completion:nil];

}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [navigationController setNavigationBarHidden:[viewController isKindOfClass:[ONEPersonDetailViewController class]] animated:true];
}


- (void)praisenumBtnClick
{
    NSDictionary *dict = nil;
    NSString *url = nil;

    switch (self.commentCellType)
    {
        case 0: // 电影故事
        {
            url = self.praisenumBtn.selected ? movie_unpraisestory : movie_praisestory;
            dict = @{ @"movieid"  : self.movie_id,
                      @"storyid"  : self.movieStoryItem.movie_story_id};
            break;
        }

        case 1: // 评审团
        {
            url = self.praisenumBtn.selected ? movie_unpraisereview : movie_praisereview;
            dict = @{ @"movieid"  : self.movie_id,
                      @"reviewid" : self.commentItem.comment_id};
            break;
        }

        case 2: // 评论
        {
            url = self.praisenumBtn.selected ? comment_unpraise : comment_praise;
            dict = @{ @"itemid"   : self.movie_id,
                      @"cmtid"    : self.commentItem.comment_id,
                      @"type"     : @"movie"};
            break;
        }
        
        default:break;
    }
    
    [self addPraise:url parameters:dict];
}


- (void)addPraise:(NSString *)url parameters:(NSDictionary *)parameters
{
    
    [ONEDataRequest addPraise:url parameters:parameters success:^(BOOL isSuccess, NSString *message) {
        if (isSuccess)
        {
            _praisenumBtn.selected = !_praisenumBtn.selected;
            NSInteger praisenum = _praisenumBtn.titleLabel.text.integerValue;
            praisenum = _praisenumBtn.selected ? ++praisenum : --praisenum;
            [_praisenumBtn setTitle:[NSString stringWithFormat:@"%zd", praisenum] forState:UIControlStateNormal];
            
        }else{
            [SVProgressHUD showErrorWithStatus:message];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"操作失败"];
    }];
}

@end
