//
//  ONEConst.h
//  ONE
//
//  Created by 任玉祥 on 16/4/1.
//  Copyright © 2016年 ONE. All rights reserved.
// 常量

#import <UIKit/UIKit.h>

 /*******************************************  requestUrl ****************************/

/** baseUrl http://v3.wufazhuce.com:8000/api */
UIKIT_EXTERN NSString *const ONEBaseUrl;

#pragma mark - ↓↓↓↓↓↓↓↓↓↓↓↓ 音乐 ↓↓↓↓↓↓↓↓↓↓↓↓

/** 音乐列表 music/idlist */
UIKIT_EXTERN NSString *const music_idlist;

/** 类似歌曲 related/music */
UIKIT_EXTERN NSString *const related_music;

/** 详情 music/detail */
UIKIT_EXTERN NSString *const music_detail;

/** 音乐评论 comment/praiseandtime/music */
UIKIT_EXTERN NSString *const comment_music;

/** 用户信息 */
UIKIT_EXTERN NSString *const user_info;

/** 文章喜欢 */
UIKIT_EXTERN NSString *const praise_add;

/** 评论喜欢喜欢 */
UIKIT_EXTERN NSString *const comment_praise;
/** 评论喜欢取消喜欢 */
UIKIT_EXTERN NSString *const comment_unpraise;

/** ta的歌曲列表 */
UIKIT_EXTERN NSString *const works_music;

/** 某个月的歌曲列表 */
UIKIT_EXTERN NSString *const music_bymonth;



#pragma mark - ↓↓↓↓↓↓↓↓↓↓↓↓ 电影 ↓↓↓↓↓↓↓↓↓↓↓↓

/** 电影列表 */
UIKIT_EXTERN NSString *const movie_list;

/** 电影详情 */
UIKIT_EXTERN NSString *const movie_detail;

/** 电影故事 */
UIKIT_EXTERN NSString *const movie;

/** 电影故事的喜欢 */
UIKIT_EXTERN NSString *const movie_praisestory;
/** 电影故事取消喜欢 */
UIKIT_EXTERN NSString *const movie_unpraisestory;

/** 审评团喜欢 */
UIKIT_EXTERN NSString *const movie_praisereview;
/** 审评团取消喜欢欢 */
UIKIT_EXTERN NSString *const movie_unpraisereview;

/** 用户评论 */
UIKIT_EXTERN NSString *const movie_comment;




/*******************************************  requestUrl ****************************/






UIKIT_EXTERN NSString *const ONEMovieDetailHeaderViewDidClickAllReview;















