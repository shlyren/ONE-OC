//
//  ONECarouselDetailCell.m
//  ONE
//
//  Created by 任玉祥 on 16/4/16.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import "ONECarouselDetailCell.h"
#import "ONECarouselDetailItem.h"
#import "NSMutableAttributedString+string.h"

@interface ONECarouselDetailCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation ONECarouselDetailCell

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.contentLabel.preferredMaxLayoutWidth = ONEScreenWidth - 20 - 30 * 2;
}

- (void)setCarouselDetailItem:(ONECarouselDetailItem *)carouselDetailItem
{
    _carouselDetailItem = carouselDetailItem;
    self.titleLabel.text = [NSString stringWithFormat:@"%@  %@", carouselDetailItem.number, carouselDetailItem.title];
    self.nameLabel.text = carouselDetailItem.author;
    
    self.contentLabel.attributedText = [NSMutableAttributedString attributedStringWithString:carouselDetailItem.introduction];
    [self.contentLabel sizeToFit];
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x += 30;
    frame.size.width -= 60;
    frame.origin.y += 20;
    
    [super setFrame:frame];
}


- (CGFloat)rowHeight
{
    [self layoutIfNeeded];
    
    _rowHeight = self.titleLabel.height + ONEDefaultMargin + self.nameLabel.height + ONEDefaultMargin + self.contentLabel.height + 30;
    return _rowHeight;
}


@end
