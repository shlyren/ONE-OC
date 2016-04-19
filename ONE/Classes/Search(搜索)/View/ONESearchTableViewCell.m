//
//  ONESearchTableViewCell.m
//  ONE
//
//  Created by 任玉祥 on 16/4/18.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONESearchTableViewCell.h"
#import "ONEHomeSubtotalItem.h"
#import "ONESearchMusicItem.h"
#import "UIImageView+WebCache.h"
#import "UIImage+image.h"

@interface ONESearchTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconImgViewWidth;

@end

@implementation ONESearchTableViewCell

- (void)setItem:(ONEHomeSubtotalItem *)item
{
    _item = item;
    self.iconImgViewWidth.constant = 65;
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:item.hp_img_url] placeholderImage:[UIImage imageNamed:@"home"]];
    self.nameLabel.text = item.hp_title;
    self.contentLabel.text = item.hp_content;
}

- (void)setMusicItem:(ONESearchMusicItem *)musicItem
{
    _musicItem = musicItem;
    self.iconImgViewWidth.constant = 65;
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:musicItem.cover] placeholderImage:[UIImage imageNamed:@"home"]];
    self.nameLabel.text = musicItem.title;
    self.contentLabel.text = musicItem.author.user_name;
}

- (void)setAuthor:(ONEAuthorItem *)author
{
    _author = author;
    self.iconImgViewWidth.constant = 50;
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:author.web_url] placeholderImage:[UIImage imageNamed:@"author_cover"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.imageView.image = image.circleImage;
    }];
    self.nameLabel.text = author.user_name;
    self.contentLabel.text = author.desc;

    
}

@end
