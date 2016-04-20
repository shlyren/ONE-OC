//
//  ONEReadDetailHeaderView.m
//  ONE
//
//  Created by 任玉祥 on 16/4/14.
//  Copyright © 2016年 任玉祥. All rights reserved.
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
#import "ONEDataRequest.h"

@interface ONEReadDetailHeaderView ()<UINavigationControllerDelegate>

/************************** 短篇,连载headerView *************************/
/** 播放按钮 */
@property (weak, nonatomic) IBOutlet UIButton *audioBtn;
/** 列表按钮 */
@property (weak, nonatomic) IBOutlet UIButton *listBtn;
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
/** 用户名 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 创作时间 */
@property (weak, nonatomic) IBOutlet UILabel *maketimeLabel;
/** 标题 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/** 内容 */
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
/** 编辑人 */
@property (weak, nonatomic) IBOutlet UILabel *chargeEdtLabel;


/// 点击列表弹出的view
@property (nonatomic, weak) UIView *listView;
/** 列表的数组 */
@property (nonatomic, strong) NSArray *serialList;
/** 列表的title */
@property (nonatomic, weak) UILabel *listTitleLabel;
/** scrollView */
@property (nonatomic, weak) UIScrollView *listScrollView;

/******************************** bottom *********************/
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *bottomIconImgView;
/** 用户名 */
@property (weak, nonatomic) IBOutlet UILabel *bottomNameLabel;
/** 简介 */
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
/** 微博 */
@property (weak, nonatomic) IBOutlet UILabel *weiboLabel;

@end

@implementation ONEReadDetailHeaderView


#define listViewH 90
#define listScrollViewH (listViewH - 60)

#pragma maek - lazy load
- (UIView *)listView
{
    if (_listView == nil)
    {
        UIView *listView = [UIView new];
        listView.width = self.width;
        listView.x = self.x;
        listView.height = listViewH;
        listView.y = self.y - listView.height;
        listView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
        listView.userInteractionEnabled = true;
        
        UILabel *listTitleLabel = [UILabel new];
        listTitleLabel.frame = CGRectMake(30, 0, listView.width - 60, 60);
        listTitleLabel.textAlignment = NSTextAlignmentCenter;
        listTitleLabel.numberOfLines = 0;
        listTitleLabel.font = ONEDefaultFont;
        listTitleLabel.textColor = [UIColor colorWithWhite:0.6 alpha:1];
        [listView addSubview: _listTitleLabel = listTitleLabel];
        
        UIScrollView *listScrollView = [UIScrollView new];
        listScrollView.frame = CGRectMake(0, listTitleLabel.height, self.width, listScrollViewH);
        listScrollView.showsVerticalScrollIndicator = false;
        listScrollView.showsHorizontalScrollIndicator = false;
        [listView addSubview:_listScrollView = listScrollView];

        [self addSubview:_listView = listView];
    }
    
    return _listView;
}

// 初始化列表里面的的按钮
- (void)setupListBtn
{
    
    for (UIView *childView in self.listScrollView.subviews)
    {
        if ([childView isKindOfClass:UIButton.class]) return;
    }
    
    CGFloat margin = 20;
    for (NSInteger i = 0; i < self.serialList.count; i ++ )
    {
        UIButton *listBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [listBtn setFrame:CGRectMake(margin + i * (listScrollViewH + margin), 0, listScrollViewH, listScrollViewH)];
        [listBtn setTag:i];
        [listBtn addTarget:self action:@selector(listBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [listBtn setTitle:[self.serialList[i] number] forState:UIControlStateNormal];
        [listBtn setTitleColor:ONEDefaultColor forState:UIControlStateNormal];
        [listBtn setTitleEdgeInsets:UIEdgeInsetsMake(-7, 0, 0, 0)];
        [self.listScrollView addSubview:listBtn];
        self.listScrollView.contentSize = CGSizeMake(self.serialList.count * (margin + listScrollViewH) + margin, 0);
    }
}


- (void)awakeFromNib
{
    self.audioBtn.hidden = true;
    self.listBtn.hidden = true;
    [self.listBtn addTarget:self action:@selector(listBtnClick) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark -  设置数据
#pragma mark 短篇数据
- (void)setEssayItem:(ONEEssayItem *)essayItem
{
    _essayItem = essayItem;
    
    self.audioBtn.hidden             = !essayItem.has_aduio;
    self.listBtn.hidden              = true;
    
    self.nameLabel.text              = essayItem.hp_author;
    self.maketimeLabel.text          = essayItem.hp_makettime;
    self.titleLabel.text             = essayItem.hp_title;
    self.contentLabel.attributedText = [NSMutableAttributedString attributedStringWithString:essayItem.hp_content];
    self.chargeEdtLabel.text         = essayItem.hp_author_introduce;
    
    self.bottomNameLabel.text        = essayItem.hp_author;
    
    NSString *weiboName              = [essayItem.author.firstObject wb_name];
    self.weiboLabel.text             = [NSString stringWithFormat:@"weibo:%@",weiboName];
    self.weiboLabel.hidden           = !weiboName.length;
    
    self.descLabel.text              = [essayItem.author.firstObject desc];
    
    [self.contentLabel sizeToFit];
    [self.titleLabel sizeToFit];
    [self layoutIfNeeded];
    
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:[essayItem.author.firstObject web_url]] placeholderImage:[UIImage imageNamed:@"author_cover"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.iconImgView.image = image.circleImage;
        self.bottomIconImgView.image = image.circleImage;
    }];
    
    if (self.contentChangeBlock) {
        CGFloat height = 110 + self.contentLabel.height + self.titleLabel.height + 30 + listViewH;
        self.contentChangeBlock(height);
    }
}

#pragma mark 连载
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

    NSString *weiboName              =  serialItem.author.wb_name;;
    self.weiboLabel.text             = [NSString stringWithFormat:@"weibo:%@",weiboName];
    self.weiboLabel.hidden           = !weiboName.length;
    
    self.descLabel.text              = serialItem.author.desc;
    
    [self.contentLabel sizeToFit];
    [self.titleLabel sizeToFit];
    [self layoutIfNeeded];
    
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:[serialItem.author web_url]] placeholderImage:[UIImage imageNamed:@"author_cover"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.iconImgView.image = image.circleImage;
        self.bottomIconImgView.image = image.circleImage;
    }];
    
    if (self.contentChangeBlock) {
        CGFloat height = 110 + self.contentLabel.height + self.titleLabel.height + 30 + listViewH;
        self.contentChangeBlock(height);
    }
}

#pragma mark - Events
#pragma mark 列表的点击事件
// 连载详情的列表按钮点击事件处理
- (void)listBtnClick
{
    self.listView.hidden = false;
    if (self.listView.y == -listViewH) {
        [UIView animateWithDuration:0.4 animations:^{
            self.listView.y += listViewH;
            self.listView.alpha = 0.95;
        }];
    }else{
        [self hiddenListView];
    }
    self.listTitleLabel.text = _serialItem.title;
    
    ONEWeakSelf
    if (self.serialList.count) return;
    
    [ONEDataRequest requestSeriaList:self.serialItem.serial_id paramrters:nil success:^(NSArray *serialList) {
        
        if (serialList.count) {
            weakSelf.serialList = serialList;
            [weakSelf setupListBtn];
        }
    } failure:nil];
}

// 列表里面的按钮的点击事件处理
//通知控制器更新数据
- (void)listBtnClick:(UIButton *)listBtn
{
    if (self.clickListBtnBlock) {
        ONESerialItem *itme = self.serialList[listBtn.tag];
        self.clickListBtnBlock(itme.content_id);
    }
    
    [self hiddenListView];
}

// 点击屏幕隐藏列表
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.listView.y == 0) [self hiddenListView];
}
// 隐藏列表
- (void)hiddenListView
{
    [UIView animateWithDuration:0.4 animations:^{
        self.listView.y -= listViewH;
        self.listView.alpha = 0;
    }];
}

#pragma mark 头像点击事件
// 详情上面的个人信息的头像的按钮点击事件
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

// 详情下面的个人信息的头像的按钮点击事件
- (IBAction)botomIconClick
{
    [self iconBtnClick];
}

#pragma mark - UINavigationController delegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [navigationController setNavigationBarHidden:[viewController isKindOfClass:[ONEPersonDetailViewController class]] animated:true];
}

#pragma mark - load Nib
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


@end
