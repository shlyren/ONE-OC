//
//  ONEDraggableCardView.m
//  ONE
//
//  Created by 任玉祥 on 16/4/17.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import "ONEDraggableCardView.h"
#import "ONEHomeSubtotalItem.h"
#import "UIImageView+WebCache.h"
#import "NSMutableAttributedString+string.h"

@interface ONEDraggableCardView ()

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *hp_titleLabel;
@property (weak, nonatomic) UILabel *hp_authorLabel;
@property (weak, nonatomic) UILabel *hp_contentLabel;
@property (weak, nonatomic) UILabel *hp_makettimeLabel;

@end
@implementation ONEDraggableCardView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor          = [UIColor whiteColor];
        
        /** 图片 */
        UIImageView *imageView        = [UIImageView new];
        CGFloat imageViewW            = self.width - 10;
        imageView.frame               = CGRectMake(5, 5, imageViewW, imageViewW * 0.75);
        _imageView                    = imageView;
        imageView.userInteractionEnabled  = true;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bigImage)]];
        [self addSubview: imageView];
        
        /** 标题 */
        UILabel *hp_titleLabel        = [UILabel new];
        hp_titleLabel.font            = [UIFont systemFontOfSize:10];
        hp_titleLabel.textColor       = [UIColor lightGrayColor];
        hp_titleLabel.x               = imageView.x;
        hp_titleLabel.y               = CGRectGetMaxY(imageView.frame) + 5;
        _hp_titleLabel                = hp_titleLabel;
        [self addSubview:hp_titleLabel];
        
        /** 用户 */
        UILabel *hp_authorLabel       = [UILabel new];
        hp_authorLabel.font           = [UIFont systemFontOfSize:10];
        hp_authorLabel.textColor      = [UIColor lightGrayColor];
        _hp_authorLabel               = hp_authorLabel;
        [self addSubview:hp_authorLabel];
        
        /** 内容 */
        UILabel *hp_contentLabel      = [UILabel new];
        hp_contentLabel.numberOfLines = 0;
        hp_contentLabel.width         = imageView.width - 2 * ONEDefaultMargin;
        hp_contentLabel.font          = [UIFont systemFontOfSize:14];
        hp_contentLabel.textColor     = [UIColor darkGrayColor];
        _hp_contentLabel              = hp_contentLabel;
        [self addSubview:hp_contentLabel];
        
        /** 发布时间 */
        UILabel *hp_makettimeLabel    = [UILabel new];
        hp_makettimeLabel.font        = [UIFont systemFontOfSize:10];
        hp_makettimeLabel.textColor   = [UIColor lightGrayColor];
        _hp_makettimeLabel            = hp_makettimeLabel;
        [self addSubview:hp_makettimeLabel];
    }
    return self;
}

/** 设置frame */
- (void)layoutSubviews
{
    [super layoutSubviews];
    /** 用户 */
    self.hp_authorLabel.x  = CGRectGetMaxX(self.imageView.frame) - self.hp_authorLabel.width;
    self.hp_authorLabel.y  = CGRectGetMaxY(self.imageView.frame) + 5;
    /** 发布时间 */
    self.hp_makettimeLabel.x =  CGRectGetMaxX(self.imageView.frame) - self.hp_makettimeLabel.width;
    self.hp_makettimeLabel.y = ONEScreenWidth * 1.2 - 15;
    /** 内容 */
    self.hp_contentLabel.x = self.imageView.x + ONEDefaultMargin;
    self.hp_contentLabel.centerY =  (CGRectGetMaxY(self.imageView.frame) + self.hp_makettimeLabel.y) * 0.5 + ONEDefaultMargin;
    
}

/** 设置数据 */
- (void)setSubtotalItem:(ONEHomeSubtotalItem *)subtotalItem
{
    _subtotalItem = subtotalItem;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:subtotalItem.hp_img_url] placeholderImage:[UIImage imageNamed:@"home"]];
    self.hp_titleLabel.text = subtotalItem.hp_title;
    [self.hp_titleLabel sizeToFit];
    
    self.hp_authorLabel.text = subtotalItem.hp_author;
    [self.hp_authorLabel sizeToFit];
    
    self.hp_makettimeLabel.text = subtotalItem.hp_makettime;
    [self.hp_makettimeLabel sizeToFit];
    
    self.hp_contentLabel.attributedText = [NSMutableAttributedString attributedStringWithString:subtotalItem.hp_content];
    [self.hp_contentLabel sizeToFit];
}


- (void)bigImage
{
    ONELogFunc
}

@end


@implementation YSLCardView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupCardView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupCardView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupCardView];
    }
    return self;
}

- (void)setupCardView {
    
    self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.layer.borderWidth = 0.4f;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    self.layer.cornerRadius = 7.0;
}





@end
