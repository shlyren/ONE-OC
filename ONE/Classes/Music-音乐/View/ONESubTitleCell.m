//
//  ONESubTitleCell.m
//  ONE
//
//  Created by 任玉祥 on 16/4/10.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONESubTitleCell.h"
#import "ONEMusicRelatedItem.h"
#import "UIImageView+WebCache.h"

@interface ONESubTitleCell ()
@property (weak, nonatomic) IBOutlet UIImageView *coverImgView;
@property (weak, nonatomic) IBOutlet UILabel     *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel     *subTitleLabel;
@end

@implementation ONESubTitleCell

- (void)setSongListItem:(ONEMusicRelatedItem *)songListItem
{
    _songListItem = songListItem;
    
    [self.coverImgView sd_setImageWithURL:[NSURL URLWithString:songListItem.cover] placeholderImage:[UIImage imageNamed:@"music_cover_small"]];
    
    self.titleLabel.text = songListItem.title;
    self.subTitleLabel.text = songListItem.author.user_name;
}


@end
