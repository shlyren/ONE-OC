//
//  ONECommentCell.m
//  ONE
//
//  Created by 任玉祥 on 16/4/2.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import "ONECommentCell.h"
#import "ONEMusicCommentItem.h"
#import "ONEMusicAuthorItem.h"
#import "UIImage+MultiFormat.h"
#import "NSMutableAttributedString+string.h"
#import "ONEDataRequest.h"

@interface ONECommentCell ()
/** 评论内容 */
@property (weak, nonatomic) IBOutlet UILabel *commentContectLabel;
/** 喜欢 按钮 */
@property (weak, nonatomic) IBOutlet UIButton *praisenumBtn;

/** 评论时间 */
@property (weak, nonatomic) IBOutlet UILabel *inputDateLabel;
/** 用户名 */
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
/** 头像 */
@property (weak, nonatomic) IBOutlet UIButton *webUrlBtn;

@end

@implementation ONECommentCell

- (void)setCommentIteme:(ONEMusicCommentItem *)commentIteme
{
    _commentIteme = commentIteme;
    
    self.commentContectLabel.attributedText = [NSMutableAttributedString attributedStringWithString:commentIteme.content];
    [self.commentContectLabel sizeToFit];
    
    [self.praisenumBtn setTitle:[NSString stringWithFormat:@"%zd", commentIteme.praisenum] forState:UIControlStateNormal];
    
    self.inputDateLabel.text = commentIteme.input_date;
    
    ONEMusicAuthorItem *author = commentIteme.user;
    self.userNameLabel.text = author.user_name;
    

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *iconData = [NSData dataWithContentsOfURL:[NSURL URLWithString:author.web_url]] ;
        
        if (iconData)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.webUrlBtn setImage:[UIImage imageWithData:iconData] forState:UIControlStateNormal];
            });
        }
        
    });
    
    
}

#pragma mark - Event
- (IBAction)praisenumBtnClick
{
    self.praisenumBtn.selected = !self.praisenumBtn.selected;
    
    
    NSDictionary *parameters = @{
                                 @"cmtid" : _commentIteme.comment_id,
                                 @"itemid" : _detail_id,  // detailID
                                 @"type" : @"music",
                                 };
    //ONELog(@"%@", parameters);
    [ONEDataRequest addPraise:comment_praise parameters:parameters success:^(BOOL isSuccess, NSString *message) {
        if (!isSuccess)
        {
            [SVProgressHUD showErrorWithStatus:message];
            _praisenumBtn.selected = !_praisenumBtn.selected;
        }else{
             NSInteger praisenum = _praisenumBtn.selected ? ++_commentIteme.praisenum : --_commentIteme.praisenum;
            
            [_praisenumBtn setTitle:[NSString stringWithFormat:@"%zd", praisenum] forState:UIControlStateNormal];
        }
    } failure:nil];
    
}

- (IBAction)iconBtnClick
{
    if ([self.delegate respondsToSelector:@selector(commentCell:didClickIcon:)]) {
        [self.delegate commentCell:self didClickIcon:_commentIteme.user.user_id];
    }
}

- (CGFloat)rowHeight
{
    [self layoutIfNeeded];
    return CGRectGetMaxY(self.commentContectLabel.frame) + 15;
}
@end
