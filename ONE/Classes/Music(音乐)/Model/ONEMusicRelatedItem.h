//
//  ONEMusicRelatedItem.h
//  ONE
//
//  Created by 任玉祥 on 16/4/2.
//  Copyright © 2016年 任玉祥. All rights reserved.
//  相关作品

#import "ONEAuthorItem.h"

@interface ONEMusicRelatedItem : NSObject

/** 图片 */
@property (nonatomic, strong) NSString *cover;

/** 作者详情 */
@property (nonatomic, strong) ONEAuthorItem *author;

/** 音乐id */
@property (nonatomic, strong) NSString *music_id;

/** 作品id */
@property (nonatomic, strong) NSString *related_id; // 返回数据 id

/** 作品标题 */
@property (nonatomic, strong) NSString *title;

/** <#注释#> */
@property (nonatomic, strong) NSString *platform;


@end
