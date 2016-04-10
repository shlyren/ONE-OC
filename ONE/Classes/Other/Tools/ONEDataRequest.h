//
//  ONEDataRequest.h
//  ONE
//
//  Created by 任玉祥 on 16/4/2.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVProgressHUD.h"
#import "ONEConst.h"


@class ONEMusicDetailItem;
@class ONEMusicCommentItem;
@class ONEMusicRelatedItem;
@class ONEMusicAuthorItem;

@interface ONEDataRequest : NSObject

#pragma mark - 音乐
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
+ (void)requestUserInfo:(NSString *)url parameters:(id)parameters success:(void (^)(ONEMusicAuthorItem *autoItem))success failure:(void (^)(NSError *error))failure;

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
+ (void)requestMusic:(NSString *)url parameters:(id)paramnters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
@end
