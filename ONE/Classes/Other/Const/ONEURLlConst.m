//
//  ONEConst.m
//  ONE
//
//  Created by 任玉祥 on 16/4/1.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import <UIKIT/UIKit.h>

NSString *const ONEBaseUrl                      = @"http://v3.wufazhuce.com:8000/api";

#pragma mark - ↓↓↓↓↓↓↓↓↓↓↓↓ 音乐 ↓↓↓↓↓↓↓↓↓↓↓↓

/** 音乐列表 music/idlist */
NSString *const music_idlist                    = @"music/idlist";

/** 类似歌曲 related/music */
NSString *const related_music                   = @"related/music";

/** 详情 music/detail */
NSString *const music_detail                    = @"music/detail";

/** 音乐评论 comment/praiseandtime/music */
NSString *const comment_music                   = @"comment/praiseandtime/music";

NSString *const user_info                       = @"user/info";

/** 文章喜欢 */
NSString *const praise_add                      = @"praise/add";

/** 评论喜欢 */
NSString *const comment_praise                  = @"comment/praise";
/** 评论喜欢取消喜欢 */
NSString *const comment_unpraise                = @"comment/unpraise";

/** 歌曲列表 */
NSString *const works_music                     = @"works/music";

/** 某个月的歌曲列表 */
NSString *const music_bymonth                   = @"music/bymonth";



#pragma mark - ↓↓↓↓↓↓↓↓↓↓↓↓ 电影 ↓↓↓↓↓↓↓↓↓↓↓↓
NSString *const movie_list                      = @"movie/list";

NSString *const movie_detail                    = @"http://v3.wufazhuce.com:8000/api/movie/detail";

NSString *const movie                           = @"http://v3.wufazhuce.com:8000/api/movie";

/** 电影故事的喜欢 */
NSString *const movie_praisestory               = @"movie/praisestory";
/** 电影故事取消喜欢 */
NSString *const movie_unpraisestory             = @"movie/unpraisestory";

/** 审评团喜欢 */
NSString *const movie_praisereview              = @"movie/praisereview";
/** 审评团取消喜欢欢 */
NSString *const movie_unpraisereview            = @"movie/unpraisereview";
/** 用户评论 */
NSString *const movie_comment                   = @"comment/praiseandtime/movie";





#pragma mark - ↓↓↓↓↓↓↓↓↓↓↓↓ 阅读 ↓↓↓↓↓↓↓↓↓↓↓↓
/** 广告url 全路径 */
NSString *const readAdUrl = @"http://v3.wufazhuce.com:8000/api/reading/carousel";

NSString *const readIndexUrl = @"http://v3.wufazhuce.com:8000/api/reading/index";

/** 短篇 */
NSString *const essay = @"essay";
NSString *const relates_essay = @"related/essay";
NSString *const comment_essay = @"comment/praiseandtime/essay";

/** 连载 */
NSString *const serialcontent = @"serialcontent";
NSString *const related_seria = @"related/serial";
NSString *const commnet_serial = @"comment/praiseandtime/serial";


/** 问题 */
NSString *const question = @"question";
NSString *const related_question = @"related/question";
NSString *const commnet_question = @"comment/praiseandtime/question/1323";












