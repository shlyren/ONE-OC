//
//  ONEMovieCommentCell.m
//  ONE
//
//  Created by 任玉祥 on 16/4/11.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import "ONEMovieCommentCell.h"
#import "ONEMovieCommentItem.h"
#import "UIImageView+WebCache.h"
#import "NSMutableAttributedString+string.h"
#import "UIImage+image.h"

@interface ONEMovieCommentCell ()
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
@end



@implementation ONEMovieCommentCell


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
    
    self.inputDateLabel.text = commentItem.input_date;
    
    ONEAuthorItem *author = commentItem.author;
    self.userNameLabel.text = author.user_name;
    
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:author.web_url] placeholderImage:[UIImage imageNamed:@"author_cover"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (image == nil) return ;
        self.iconImgView.image = image.circleImage;
    }];
    
}

- (CGFloat)rowHeight
{
    [self layoutIfNeeded];
    return CGRectGetMaxY(self.commentContectLabel.frame) + 15;
}
@end
