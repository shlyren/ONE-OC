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
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *hp_titleLable;

@property (weak, nonatomic) IBOutlet UILabel *hp_contentLabel;
@end

@implementation ONEMoreSubtotalCell


- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.layer.borderWidth = 0.4f;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    self.layer.cornerRadius = 5;
}

- (void)setSubtotalItem:(ONEHomeSubtotalItem *)subtotalItem
{
    _subtotalItem = subtotalItem;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:subtotalItem.hp_img_url] placeholderImage:[UIImage imageNamed:@"home"]];
    self.hp_titleLable.text = subtotalItem.hp_title;
    self.hp_contentLabel.text = subtotalItem.hp_content;
}

@end
