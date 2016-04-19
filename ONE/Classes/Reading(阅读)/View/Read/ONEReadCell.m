//
//  ONEReadCell.m
//  ONE
//
//  Created by 任玉祥 on 16/4/14.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEReadCell.h"


@interface ONEReadCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *makeTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation ONEReadCell


- (void)awakeFromNib
{
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_button_white"]];
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= ONEDefaultMargin;
    frame.origin.x    += ONEDefaultMargin;
    frame.size.width  -= ONEDefaultMargin * 2;
    
    [super setFrame:frame];
}

- (void)setEssay:(ONEEssayItem *)essay
{
    _essay = essay;
    
    self.titleLabel.text    = essay.hp_title;
    ONEAuthorItem *author   = essay.author.firstObject;
    self.nameLabel.text     = author.user_name;
    self.makeTimeLabel.text = essay.hp_makettime;
    self.contentLabel.text  = essay.guide_word;
    
}

- (void)setSerial:(ONESerialItem *)serial
{
    _serial = serial;
    
    self.titleLabel.text    = serial.title;
    self.makeTimeLabel.text = serial.maketime;
    self.nameLabel.text     = serial.author.user_name;
    self.contentLabel.text  = serial.excerpt;
}

- (void)setQuestion:(ONEQuestionItem *)question
{
    _question = question;
    
    self.titleLabel.text    = question.question_title;
    self.makeTimeLabel.text = question.question_maketiem;
    self.nameLabel.text     = question.answer_title;
    self.contentLabel.text  = question.answer_content;
    
}

@end
