//
//  ONEMoreSubtotalCell.m
//  ONE
//
//  Created by 任玉祥 on 16/4/17.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import "ONEMoreSubtotalCell.h"
#import "ONEHomeSubtotalItem.h"
#import "UIImageView+WebCache.h"

@interface ONEMoreSubtotalCell ()
/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** 标题 */
@property (weak, nonatomic) IBOutlet UILabel *hp_titleLable;
/** 内容 */
@property (weak, nonatomic) IBOutlet UILabel *hp_contentLabel;
@end

@implementation ONEMoreSubtotalCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithWhite:0.98 alpha:0.9];
    self.layer.shouldRasterize = true;
    self.layer.rasterizationScale = UIScreen.mainScreen.scale;
    self.layer.cornerRadius = 5;
}

- (void)setSubtotalItem:(ONEHomeSubtotalItem *)subtotalItem
{
    _subtotalItem = subtotalItem;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:subtotalItem.hp_img_url] placeholderImage:[UIImage imageNamed:@"home"]];
    self.hp_titleLable.text = [NSString stringWithFormat:@" %@", subtotalItem.hp_title];
    self.hp_contentLabel.text = subtotalItem.hp_content;
}

@end
