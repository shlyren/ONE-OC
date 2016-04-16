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
#import "ONEPersonDetailViewController.h"
#import "ONENavigationController.h"
#import "UIViewController+topViewController.h"


@interface ONEReadDetailHeaderView ()<UINavigationControllerDelegate>

/************************** 短篇,连载headerView *************************/
@property (weak, nonatomic) IBOutlet UIButton *audioBtn;
@property (weak, nonatomic) IBOutlet UIButton *listBtn;

@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *maketimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *chargeEdtLabel;


/** bottom */
@property (weak, nonatomic) IBOutlet UIImageView *bottomIconImgView;
@property (weak, nonatomic) IBOutlet UILabel *bottomNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *weiboLabel;

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
    
    self.audioBtn.hidden             = !essayItem.audio.length;
    self.listBtn.hidden              = true;
    
    self.nameLabel.text              = essayItem.hp_author;
    self.maketimeLabel.text          = essayItem.hp_makettime;
    self.titleLabel.text             = essayItem.hp_title;
    self.contentLabel.attributedText = [NSMutableAttributedString attributedStringWithString:essayItem.hp_content];
    self.chargeEdtLabel.text         = essayItem.hp_author_introduce;
    
    self.bottomNameLabel.text        = essayItem.hp_author;
    
    NSString *weiboName              = [NSString stringWithFormat:@"weibo:%@", [essayItem.author.firstObject wb_name]];
    self.weiboLabel.text             = weiboName;
    self.weiboLabel.hidden           = !weiboName.length;
    
    self.descLabel.text              = [essayItem.author.firstObject desc];
    
    [self.contentLabel sizeToFit];
    [self.titleLabel sizeToFit];
    [self layoutIfNeeded];
    
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:[essayItem.author.firstObject web_url]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.iconImgView.image = image.circleImage;
        self.bottomIconImgView.image = image.circleImage;
    }];
    
    
    
    if ([self.delegate respondsToSelector:@selector(readDetailHeaderView:didChangedHeight:)])
    {
        CGFloat height = 110 + self.contentLabel.height + self.titleLabel.height + 30 + 100;
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
   
    self.bottomNameLabel.text        = self.nameLabel.text;

    NSString *weiboName              = [NSString stringWithFormat:@"weibo:%@", serialItem.author.wb_name];
    self.weiboLabel.text             = weiboName;
    self.weiboLabel.hidden           = !weiboName.length;
    
    self.descLabel.text              = serialItem.author.desc;
    
    [self.contentLabel sizeToFit];
    [self.titleLabel sizeToFit];
    [self layoutIfNeeded];
    
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:[serialItem.author web_url]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.iconImgView.image = image.circleImage;
        self.bottomIconImgView.image = image.circleImage;
    }];
    
    
    
    if ([self.delegate respondsToSelector:@selector(readDetailHeaderView:didChangedHeight:)])
    {
        CGFloat height = 110 + self.contentLabel.height + self.titleLabel.height + 30 + 100;
        [self.delegate readDetailHeaderView:self didChangedHeight:height];
    }
}

- (IBAction)botomIconClick
{

    [self iconBtnClick];
}

- (IBAction)iconBtnClick
{
    NSString *userid;
    if (self.essayItem.author.count) {
        userid = [self.essayItem.author.firstObject user_id];
    }
    if (self.serialItem) {
        userid = self.serialItem.author.user_id;
    }
    
    if (userid == nil) return;
    
    ONEPersonDetailViewController *detailVc = [ONEPersonDetailViewController new];
    detailVc.user_id = userid;
    ONENavigationController *nav = [[ONENavigationController alloc] initWithRootViewController:detailVc];
    nav.delegate = self;
   [self.window.rootViewController.topViewController presentViewController:nav animated:YES completion:nil];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [navigationController setNavigationBarHidden:[viewController isKindOfClass:[ONEPersonDetailViewController class]] animated:true];
}



@end
