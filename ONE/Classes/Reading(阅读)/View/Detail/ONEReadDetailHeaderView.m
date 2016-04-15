//
//  ONEReadDetailHeaderView.m
//  ONE
//
//  Created by 任玉祥 on 16/4/14.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import "ONEReadDetailHeaderView.h"
#import "ONEEssayItem.h"
#import "ONESerialItem.h"
#import "UIImageView+WebCache.h"
#import "UIImage+image.h"
#import "NSMutableAttributedString+string.h"


@interface ONEReadDetailHeaderView ()

/************************** 短篇,连载headerView *************************/
@property (weak, nonatomic) IBOutlet UIButton *audioBtn;
@property (weak, nonatomic) IBOutlet UIButton *listBtn;

@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *maketimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *chargeEdtLabel;


@end

@implementation ONEReadDetailHeaderView
+ (instancetype)detailHeaderView
{
    return self.viewsWithNib[0];
}

+ (instancetype)relatedSectionHeader
{
    return self.viewsWithNib[1];
}
+ (instancetype)commentSectionHeader
{
    return self.viewsWithNib[2];
}

+ (NSArray *)viewsWithNib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
}



- (void)awakeFromNib
{
    self.audioBtn.hidden = true;
    self.listBtn.hidden = true;
}

- (void)setEssayItem:(ONEEssayItem *)essayItem
{
    _essayItem = essayItem;
    
    self.audioBtn.hidden             = false;
    self.listBtn.hidden              = true;
    
    self.nameLabel.text              = essayItem.hp_author;
    self.maketimeLabel.text          = essayItem.hp_makettime;
    self.titleLabel.text             = essayItem.hp_title;
    self.contentLabel.attributedText = [NSMutableAttributedString attributedStringWithString:essayItem.hp_content];
    self.chargeEdtLabel.text         = essayItem.hp_author_introduce;
    
    [self.contentLabel sizeToFit];
    [self.titleLabel sizeToFit];
    [self layoutIfNeeded];
    
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:[essayItem.author.firstObject web_url]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.iconImgView.image = image.circleImage;
    }];
    
    if ([self.delegate respondsToSelector:@selector(readDetailHeaderView:didChangedHeight:)])
    {
        CGFloat height = 110 + self.contentLabel.height + self.titleLabel.height + 30;
        [self.delegate readDetailHeaderView:self didChangedHeight:height];
    }
    
    
}

-(void)setSerialItem:(ONESerialItem *)serialItem
{
    _serialItem = serialItem;
    
    self.audioBtn.hidden             = true;
    self.listBtn.hidden              = false;
   
    self.nameLabel.text              = serialItem.author.user_name;
    self.maketimeLabel.text          = serialItem.maketime;
    self.titleLabel.text             = serialItem.title;
    self.contentLabel.attributedText = [NSMutableAttributedString attributedStringWithString:serialItem.content];
    self.chargeEdtLabel.text         = serialItem.charge_edt;
    
    [self.contentLabel sizeToFit];
    [self.titleLabel sizeToFit];
    [self layoutIfNeeded];
    
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:[serialItem.author web_url]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.iconImgView.image = image.circleImage;
    }];
    
    if ([self.delegate respondsToSelector:@selector(readDetailHeaderView:didChangedHeight:)])
    {
        CGFloat height = 110 + self.contentLabel.height + self.titleLabel.height + 30;
        [self.delegate readDetailHeaderView:self didChangedHeight:height];
    }
}




@end
