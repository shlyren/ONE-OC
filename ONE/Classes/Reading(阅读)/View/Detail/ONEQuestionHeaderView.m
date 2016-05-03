//
//  ONEQuestionHeaderView.m
//  ONE
//
//  Created by 任玉祥 on 16/4/15.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEQuestionHeaderView.h"
#import "ONEQuestionItem.h"
#import "NSMutableAttributedString+string.h"

@interface ONEQuestionHeaderView ()

/************************* 问题 headerView *************************/

@property (weak, nonatomic) IBOutlet UILabel *questionTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *questionContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerContentLabel;

@property (weak, nonatomic) IBOutlet UILabel *q_charegeEdtLabel;
@property (weak, nonatomic) IBOutlet UILabel *questionMaketimeLabel;
@end
@implementation ONEQuestionHeaderView

+ (instancetype)questionDetailHeaderView
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
}
- (void)setQuestionItem:(ONEQuestionItem *)questionItem
{
    _questionItem = questionItem;
    
    self.questionTitleLabel.text = questionItem.question_title;
    self.questionContentLabel.attributedText = [NSMutableAttributedString attributedStringWithString:questionItem.question_content];
    [self.questionContentLabel sizeToFit];
    self.questionMaketimeLabel.text = questionItem.last_update_date;
    self.answerTitleLabel.text = questionItem.answer_title;
    self.answerContentLabel.text = questionItem.answer_content;
    self.answerContentLabel.attributedText = [NSMutableAttributedString attributedStringWithString:questionItem.answer_content];
    [self.answerContentLabel sizeToFit];
    [self layoutIfNeeded];
    
    self.q_charegeEdtLabel.text = questionItem.charge_edt;
    
    
    if (self.contentChangeBlock) {
         CGFloat height = CGRectGetMaxY(self.questionContentLabel.frame) + self.questionContentLabel.height + 50 + self.answerTitleLabel.height + 20+ self.answerContentLabel.height + self.q_charegeEdtLabel.height + 20;
        self.contentChangeBlock(height);
    }
}


@end
