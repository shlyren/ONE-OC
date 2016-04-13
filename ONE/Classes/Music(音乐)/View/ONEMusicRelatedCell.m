//
//  ONEMusicRelatedCell.m
//  ONE
//
//  Created by 任玉祥 on 16/4/3.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import "ONEMusicRelatedCell.h"
#import "UIImageView+WebCache.h"
#import "ONEMusicRelatedItem.h"

@interface ONEMusicRelatedCell ()
/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *coverImgView;
/** 标题 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/** 歌手 */
@property (weak, nonatomic) IBOutlet UILabel *authorNameLabel;

@end

@implementation ONEMusicRelatedCell

- (void)setRelatedItem:(ONEMusicRelatedItem *)relatedItem
{
    _relatedItem = relatedItem;
    
//    self.activity.hidden = relatedItem;
    
    [self.coverImgView sd_setImageWithURL:[NSURL URLWithString:relatedItem.cover] placeholderImage:[UIImage imageNamed:@"music_more_collection"]];
    
    self.titleLabel.text = relatedItem.title;
    
    self.authorNameLabel.text = relatedItem.author.user_name;
    
}

@end
