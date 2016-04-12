//
//  ONEMusicDetailView.m
//  ONE
//
//  Created by 任玉祥 on 16/4/2.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import "ONEMusicDetailView.h"
#import "ONEMusicDetailItem.h"
#import "UIImageView+WebCache.h"
#import "UIImage+image.h"
#import "NSMutableAttributedString+string.h"
#import "ONEDataRequest.h"
#import "ONEMusicPlayerView.h"

@interface ONEMusicDetailView ()
/**  图片 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** 简介 */
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
/** 歌手头像按钮 */
@property (weak, nonatomic) IBOutlet UIButton *stroyUserUrlBtn;
/** 名字 */
@property (weak, nonatomic) IBOutlet UILabel *name;
/** 标题 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/** 创作时间 */
@property (weak, nonatomic) IBOutlet UILabel *maketimeLabel;


/** storyLabel展示的类型 */
@property (nonatomic, weak) IBOutlet UILabel *typeLabel;
/** 故事的按钮 */
@property (nonatomic, weak) IBOutlet UIButton *storyBtn;
/** 歌词的按钮 */
@property (weak, nonatomic) IBOutlet UIButton *lyricBtn;
/** 歌曲信息 */
@property (weak, nonatomic) IBOutlet UIButton *infoBtn;


/** 故事标题 */
@property (weak, nonatomic) IBOutlet UILabel *storyTitleLabel;
/** 歌手名字 */
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
/** 故事内容 */
@property (weak, nonatomic) IBOutlet UILabel *storyLabel;
/** 编辑人 */
@property (weak, nonatomic) IBOutlet UILabel *chargeEdtLabel;


/** 喜欢 */
@property (weak, nonatomic) IBOutlet UIButton *heardBtn;
/** 评论 */
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
/** 分享 */
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;


/** 选中的btn */
@property (nonatomic, weak) UIButton *selectedBtn;

/** 存放故事详情label文字的内容类型(故事,歌词,信息)的数组 */
@property (nonatomic, strong) NSArray *typeArr;
/** 存放故事详情label文字的内容(故事,歌词,信息)的数组 */
@property (nonatomic, strong) NSArray *textArr;

@property (nonatomic, weak) ONEMusicPlayerView *playerView;

@end

@implementation ONEMusicDetailView


- (ONEMusicPlayerView *)playerView
{
    if (_playerView == nil)
    {
        ONEMusicPlayerView *playerView = [ONEMusicPlayerView new];
        playerView.frame = CGRectMake(0, 0, ONEScreenWidth, 250);
        playerView.hidden = true;
        [[UIApplication sharedApplication].keyWindow addSubview:playerView];
        _playerView = playerView;
    
    }
    return _playerView;
}

- (instancetype)init
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    _typeArr = @[@"音乐故事", @"歌词", @"歌曲信息"];
    
    self.descLabel.text = nil;
    self.titleLabel.text = nil;
    self.name.text = nil;
    self.maketimeLabel.text = nil;
    self.storyTitleLabel.text = nil;
    self.userNameLabel.text = nil;
    self.chargeEdtLabel.text = nil;

}

#pragma mark - Mdthods
- (void)setMusicDetailItem:(ONEMusicDetailItem *)musicDetailItem
{
    _musicDetailItem = musicDetailItem;
    
    // 设置存放故事详情label文字的内容
    _textArr = @[_musicDetailItem.story, _musicDetailItem.lyric, _musicDetailItem.info];
    
    //顶部图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:musicDetailItem.cover] placeholderImage:[UIImage imageNamed:@"music_cover"]];
    
    // 歌手
    ONEAuthorItem *author = musicDetailItem.author;
    self.descLabel.text = author.desc;
    // 歌手头像
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *urlData =[NSData dataWithContentsOfURL:[NSURL URLWithString:author.web_url]];
        
        UIImage *iconImage = [UIImage imageWithData:urlData];
        
        if (iconImage)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.stroyUserUrlBtn setImage:[iconImage circleImage] forState:UIControlStateNormal];
            });
        }
    });
    
    self.name.text = author.user_name;
    self.titleLabel.text = musicDetailItem.title;

    
    // 时间格式化 2016-04-01 17:56:38
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *inputDate = [formatter dateFromString:musicDetailItem.maketime];
    [formatter setDateFormat:@"MM.dd,yyyy"];
    self.maketimeLabel.text = [formatter stringFromDate:inputDate];
    
    // 故事标题
    self.storyTitleLabel.text = musicDetailItem.story_title;
    self.userNameLabel.text = author.user_name;
    
    // 
    BOOL noStroy = [musicDetailItem.story isEqualToString:@""];
    _storyBtn.hidden = noStroy;
    [self storyBtn:noStroy ? _lyricBtn : _storyBtn];
    
    self.chargeEdtLabel.text = musicDetailItem.charge_edt;
    
    // 按钮
    [self.heardBtn   setTitle:[NSString stringWithFormat:@"%zd", musicDetailItem.praisenum] forState:UIControlStateNormal];
    [self.commentBtn setTitle:[NSString stringWithFormat:@"%zd", musicDetailItem.commentnum] forState:UIControlStateNormal];
    [self.shareBtn   setTitle:[NSString stringWithFormat:@"%zd", musicDetailItem.sharenum] forState:UIControlStateNormal];
    
}


#pragma mark - Event
- (IBAction)storyBtn:(UIButton *)btn
{
    if (_textArr == nil) return;
    // 按钮业务逻辑处理
    if (btn == self.selectedBtn) return;
    self.selectedBtn.selected = false;
    btn.selected = true;
    self.selectedBtn = btn;
    
    self.typeLabel.text = _typeArr[btn.tag];
    
    // 故事详情label的文字设置
    self.storyLabel.attributedText = [NSMutableAttributedString attributedStringWithString:_textArr[btn.tag]];
    [self.storyLabel sizeToFit];
    
    [self layoutIfNeeded];
    
    CGFloat height = self.storyLabel.y + self.storyLabel.height + self.heardBtn.height + self.chargeEdtLabel.height + 40;
    if (height < 450) return; // 默认高度为500
    if ([self.delegate respondsToSelector:@selector(musicDetailView:didChangedContent:)])
    {
        [self.delegate musicDetailView:self didChangedContent:height];
    }
}


- (IBAction)iconBtnClick
{
    self.playerView.hidden = true;
    if ([self.delegate respondsToSelector:@selector(musicDetailView:didClickStoryUserIcon:)])
    {
        [self.delegate musicDetailView:self didClickStoryUserIcon:_musicDetailItem.author.user_id];
    }
}

- (IBAction)praiseBtnclick:(UIButton *)sender
{
    if (_musicDetailItem == nil) return;
    sender.selected = !sender.selected;

    NSDictionary *parameters = @{
                                 @"deviceid"    : [[NSUUID UUID] UUIDString],
                                 @"devicetype"  : @"ios",
                                 @"itemid"      : _musicDetailItem.detail_id,
                                 @"type"        : @"music"
                                 };
    //ONELog(@"%@", parameters);
    [ONEDataRequest addPraise:praise_add parameters:parameters success:^(BOOL isSuccess, NSString *message) {
        if (!isSuccess) {
            [SVProgressHUD showErrorWithStatus:message];
            sender.selected = !sender.selected;
        }else{
            NSInteger praisenum = sender.selected ? ++_musicDetailItem.praisenum : --_musicDetailItem.praisenum;
            [sender setTitle:[NSString stringWithFormat:@"%zd", praisenum] forState:UIControlStateNormal];
        }
        
    } failure:nil];
}


- (IBAction)playerBtnClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
    
    
    self.playerView.hidden = false;


//    if ([self.delegate respondsToSelector:@selector(musicDetailViwe:didClickPlayerBtn:)])
//    {
//        [self.delegate musicDetailViwe:self didClickPlayerBtn:btn];
//    }
    
    //    [ONEDataRequest requestMusic:_musicDetailItem.music_id parameters:nil success:^(id responseObject) {
    //
    //    } failure:^(NSError *error) {
    //
    //    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.playerView.hidden = true;

}



@end
