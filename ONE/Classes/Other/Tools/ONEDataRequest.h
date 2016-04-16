//
//  ONEDataRequest.h
//  ONE
//
//  Created by 任玉祥 on 16/4/2.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVProgressHUD.h"
#import "ONEURLlConst.h"

@class ONEAuthorItem;

@class ONEMusicDetailItem;
@class ONEMusicCommentItem;
@class ONEMusicRelatedItem;

@class ONEMovieDetailItem;
@class ONEMovieResultItem;

@class ONEEssayItem;
@class ONESerialItem;
@class ONEQuestionItem;

@interface ONEDataRequest : NSObject

#pragma mark - ↓↓↓↓↓↓↓↓↓↓↓↓ 音乐 ↓↓↓↓↓↓↓↓↓↓↓↓
/**
 *  请求音乐列表数据
 *
 *  @param url        请求地址 段地址
 *  @param parameters 请求参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
+ (void)requsetMusciIdList:(NSString *)url parameters:(id)parameters success:(void (^)(NSArray *musicIdList))success failure:(void (^)(NSError *error))failure;


/**
 *  请求音乐详情数据
 *
 *  @param url        请求地址 短地址
 *  @param parameters 请求参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
+ (void)requestMusicDetail:(NSString *)url parameters:(id)parameters success:(void (^)(ONEMusicDetailItem *musicDetailItem))success failure:(void (^)(NSError *error))failure;


/**
 *  请求评论数据
 *
 *  @param url        请求地址 短地址
 *  @param parameters 请求参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
+ (void)requestMusicComment:(NSString *)url parameters:(id)parameters success:(void (^)(NSArray <ONEMusicCommentItem *> *commentItems))success failure:(void (^)(NSError *error))failure;

/**
 *  请求相似歌曲数据
 *
 *  @param url        请求地址 短地址
 *  @param parameters 请求参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
+ (void)requestMusicRelated:(NSString *)url parameters:(id)parameters success:(void (^)(NSArray <ONEMusicRelatedItem *>*relatedItems))success failure:(void (^)(NSError *error))failure;

/**
 *  获取用户资料
 *
 *  @param url        请求地址 短地址
 *  @param parameters 请求参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
+ (void)requestUserInfo:(NSString *)url parameters:(id)parameters success:(void (^)(ONEAuthorItem *autoItem))success failure:(void (^)(NSError *error))failure;

/**
 *  喜欢
 *
 *  @param url        请求地址 短地址
 *  @param parameters 请求参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
+ (void)addPraise:(NSString *)url parameters:(id)parameters success:(void (^)(BOOL isSuccess, NSString *message))success failure:(void (^)(NSError *error))failure;

/**
 *  ta的歌曲
 *
 *  @param url        请求地址 短地址
 *  @param parameters 请求参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
+ (void)requestPersonSong:(NSString *)url parameters:(id)parameters success:(void (^)(NSArray <ONEMusicRelatedItem *>*relatedItems))success failure:(void (^)(NSError *error))failure;

/**
 *  获取一个月的歌单
 *
 *  @param url        请求地址 短地址
 *  @param parameters 请求参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
+ (void)requsetMusicByMonth:(NSString *)url parameters:(id)parameters success:(void (^)(NSArray <ONEMusicRelatedItem *>*relatedItems))success failure:(void (^)(NSError *error))failure;

/**
 *  获取音乐数据 <未实现>
 *
 *  @param url        请求地址 短地址
 *  @param parameters 请求参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
+ (void)requestMusic:(NSString *)url parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;



#pragma mark - ↓↓↓↓↓↓↓↓↓↓↓↓ 电影 ↓↓↓↓↓↓↓↓↓↓↓↓
/**
 *  获取电影列表数据
 *
 *  @param url        请求地址 短地址
 *  @param parameters 请求参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
+ (void)requestMovieList:(NSString *)url parameters:(id)parameters succes:(void (^)(NSArray *movieLists))success failure:(void(^)(NSError *error))failure;

/**
 *  获取电影详情数据
 *
 *  @param url        请求地址 短地址
 *  @param parameters 请求参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
+ (void)requestMovieDetail:(NSString *)url parameters:(id)parameters success:(void (^)(ONEMovieDetailItem *movieDetail))success failure:(void (^)(NSError *error))failure;

/**
 *  获取电影故事数据
 *
 *  @param url        请求地址 短地址
 *  @param parameters 请求参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
+ (void)requestMovieStory:(NSString *)url parameters:(id)patameters success:(void (^)(ONEMovieResultItem *movieStory))success failure:(void (^)(NSError *error))failure;

/**
 *  获取评审团
 *
 *  @param url        请求地址 短地址
 *  @param parameters 请求参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
+ (void)requestMovieReview:(NSString *)url parameters:(id)patameters success:(void (^)(ONEMovieResultItem *movieReview))success failure:(void (^)(NSError *error))failure;

/**
 *  获取电影用户评论
 *
 *  @param url        请求地址 短地址
 *  @param parameters 请求参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
+ (void)requestMovieComment:(NSString *)url parameters:(id)patameters success:(void (^)(NSMutableArray *movieComments))success failure:(void (^)(NSError *error))failure;





#pragma mark - 阅读
/**
 *  广告
 */
+ (void)requestReadAdSuccess:(void (^)(NSArray *adDatas))success failure:(void (^)(NSError *error))failure;

/**
 *  阅读列表]
 */
+ (void)requestReadList:(NSString *)url parameters:(id)parameters succsee:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
/**
 *  短篇详情
 */
+ (void)requestEssayDetail:(NSString *)url parameters:(id)parameters succsee:(void (^)(ONEEssayItem *essay))success failure:(void (^)(NSError *error))failure;
/**
 *  连载详情
 */
+ (void)requestSerialDetail:(NSString *)url parameters:(id)parameters succsee:(void (^)(ONESerialItem *serial))success failure:(void (^)(NSError *error))failure;
/**
 *  问题详情
 */
+ (void)requestQuestionDetail:(NSString *)url parameters:(id)parameters succsee:(void (^)(ONEQuestionItem *question))success failure:(void (^)(NSError *error))failure;

/**
 *  阅读评论数据
 */
+ (void)requestReadComment:(NSString *)url parameters:(id)parameters success:(void (^)(NSArray *commentItems))success failure:(void (^)(NSError *error))failure;

/** 短篇 推荐 */
+ (void)requestEssayRelated:(NSString *)url paramrters:(id)parameters success:(void (^)(NSArray *essayRelated))success failure:(void (^)(NSError *error))failure;
/** 连载 推荐 */
+ (void)requestSerialRelated:(NSString *)url paramrters:(id)parameters success:(void (^)(NSArray *serialRelated))success failure:(void (^)(NSError *error))failure;

/** 问题 推荐 */
+ (void)requestQuestionRelated:(NSString *)url paramrters:(id)parameters success:(void (^)(NSArray *questionRelated))success failure:(void (^)(NSError *error))failure;


/** carouselDetailItem */
+ (void)requestCarousel:(NSString *)url paramrters:(id)parameters success:(void (^)(NSArray *carouselDetailItem))success failure:(void (^)(NSError *error))failure;
@end
