//
//  ONEConst.m
//  ONE
//
//  Created by 任玉祥 on 16/4/1.
//  Copyright © 2016年 ONE. All rights reserved.
//  请求的url


/** ONEBaseHost */
NSString *const ONEBaseUrl                      = @"http://v3.wufazhuce.com:8000/api";
/** 评论喜欢 */
NSString *const comment_praise                  = @"comment/praise";
/** 评论喜欢取消喜欢 */
NSString *const comment_unpraise                = @"comment/unpraise";

#pragma mark - ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ 音乐 ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

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

/** 歌曲列表 */
NSString *const works_music                     = @"works/music";

/** 某个月的歌曲列表 */
NSString *const music_bymonth                   = @"music/bymonth";



#pragma mark - ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ 电影 ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
/** 电影的列表 全路径 */
NSString *const movie_list                      = @"movie/list";
/** 电影的详情 全路径 */
NSString *const movie_detail                    = @"http://v3.wufazhuce.com:8000/api/movie/detail";
/**  */
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




#pragma mark - ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ 阅读 ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
/** 广告url 全路径 */
NSString *const readAdUrl                       = @"http://v3.wufazhuce.com:8000/api/reading/carousel";
/** 阅读的列表 全路径 */
NSString *const readIndexUrl                    = @"http://v3.wufazhuce.com:8000/api/reading/index";

/** 短篇 */
NSString *const essay                           = @"essay";                             // 内容
NSString *const relates_essay                   = @"related/essay";                     // 推荐
NSString *const comment_essay                   = @"comment/praiseandtime/essay";       // 评论

/** 连载 */
NSString *const serialcontent                   = @"serialcontent";                     // 内容
NSString *const related_serial                   = @"related/serial";                    // 推荐
NSString *const commnet_serial                  = @"comment/praiseandtime/serial";      // 评论

/** 问题 */
NSString *const question                        = @"question";                          // 内容
NSString *const related_question                = @"related/question";                  // 推荐
NSString *const commnet_question                = @"comment/praiseandtime/question";    // 评论
/** 广告的点击 */
NSString *const reading_carousel                = @"reading/carousel";


#pragma mark - ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ 首页 ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
/** 首页rul */
NSString *const homeSubtotal                    = @"http://v3.wufazhuce.com:8000/api/hp";





