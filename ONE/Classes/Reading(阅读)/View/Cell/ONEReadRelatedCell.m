//
//  ONEReadRelatedCell.m
//  ONE
//
//  Created by 任玉祥 on 16/4/15.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEReadRelatedCell.h"
#import "ONEEssayItem.h"
#import "ONEQuestionItem.h"
#import "ONESerialItem.h"
#import "NSMutableAttributedString+string.h"

@interface ONEReadRelatedCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *typeImgView;

@end

@implementation ONEReadRelatedCell

- (void)awakeFromNib
{
    self.contentLabel.preferredMaxLayoutWidth = ONEScreenWidth - 2 * ONEDefaultMargin;
    self.titleLabel.preferredMaxLayoutWidth = ONEScreenWidth - 61;
}

- (void)setEssayItem:(ONEEssayItem *)essayItem
{
    _essayItem = essayItem;
    self.titleLabel.text = essayItem.hp_title;
    self.nameLabel.text = [essayItem.author.firstObject user_name];
    self.contentLabel.attributedText = [NSMutableAttributedString attributedStringWithString:essayItem.guide_word];
    self.typeImgView.image = [UIImage imageNamed:@"essay"];
}

- (void)setQuestionItem:(ONEQuestionItem *)questionItem
{
    _questionItem = questionItem;
    self.titleLabel.text = questionItem.question_title;
    self.nameLabel.text = questionItem.answer_title;
    self.contentLabel.attributedText = [NSMutableAttributedString attributedStringWithString:questionItem.answer_content];
    self.typeImgView.image = [UIImage imageNamed:@"question"];
    
}
- (void)setSerialItem:(ONESerialItem *)serialItem
{
    _serialItem = serialItem;
    self.titleLabel.text    = serialItem.title;
    self.nameLabel.text     = serialItem.author.user_name;
    self.contentLabel.text  = serialItem.excerpt;
    self.typeImgView.image = [UIImage imageNamed:@"serialcontent"];

}

- (CGFloat)rowHeight
{
    [self layoutIfNeeded];
    return CGRectGetMaxY(self.nameLabel.frame) + ONEDefaultMargin + self.contentLabel.height + 15;
}

@end
