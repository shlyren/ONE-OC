//
//  ONEMusicDetailItem.h
//  ONE
//
//  Created by 任玉祥 on 16/4/2.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import "ONEAuthorItem.h"

@interface ONEMusicDetailItem : NSObject

/** 编辑人 */
@property (nonatomic, strong) NSString *charge_edt;

/** 创建时间 */
@property (nonatomic, strong) NSString *maketime;


/** 歌手信息 */
@property (nonatomic, strong) ONEAuthorItem *author;

/** 关注,喜欢 */
@property (nonatomic, assign) NSInteger praisenum;

/** 种类 */
@property (nonatomic, strong) NSString *sort;

/** 标题 */
@property (nonatomic, strong) NSString *title;

/** 分享 */
@property (nonatomic, assign) NSInteger sharenum;

/** 平台 */
@property (nonatomic, strong) NSString *platform;

/** 图片url */
@property (nonatomic, strong) NSString *cover;

/**  */
@property (nonatomic, strong) NSString *related_to;

/** 阅读数 */
@property (nonatomic, strong) NSString *read_num;

/** 网页url */
@property (nonatomic, strong) NSString *web_url;

/** 歌词 */
@property (nonatomic, strong) NSString *lyric;

/** 故事标题 */
@property (nonatomic, strong) NSString *story_title;

/** 音乐url */
@property (nonatomic, strong) NSString *music_id;

/** 详情id */
@property (nonatomic, strong) NSString *detail_id; // 返回 id

/**  */
@property (nonatomic, strong) NSString *isfrist;


/** 文章作者 */
@property (nonatomic, strong) ONEAuthorItem *story_author;

/** 故事内容 */
@property (nonatomic, strong) NSString *story;

/** 歌曲信息 */
@property (nonatomic, strong) NSString *info;

/** 最后更新时间 */
@property (nonatomic, strong) NSString *last_update_date;

/** 评论数 */
@property (nonatomic, assign) NSInteger commentnum;


@end
