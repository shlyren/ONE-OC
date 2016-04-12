//
//  ONEDataRequest.m
//  ONE
//
//  Created by 任玉祥 on 16/4/2.
//  Copyright © 2016年 ONE. All rights reserved.
//


#import "ONEDataRequest.h"
#import "ONEHttpTool.h"

#import "ONEMusicResultItem.h"
#import "ONEAuthorItem.h"
#import "ONEMusicDetailItem.h"
#import "ONEMusicCommentItem.h"
#import "ONEMusicRelatedItem.h"
#import "ONEMovieListItem.h"
#import "ONEMovieDetailItem.h"
#import "ONEMovieStoryItem.h"
#import "ONEMovieCommentItem.h"

#import "ONEMovieResultItem.h"
@implementation ONEDataRequest
/**
 *  请求音乐列表数据
 */
+ (void)requsetMusciIdList:(NSString *)url parameters:(id)parameters success:(void (^)(NSArray *musicIdList))success failure:(void (^)(NSError *error))failure
{
    url = [[ONEBaseUrl stringByAppendingPathComponent:music_idlist] stringByAppendingPathComponent:url];
    [ONEHttpTool GET:url parameters:parameters success:^(id responseObject) {
        ONEMusicResultItem *result = [ONEMusicResultItem mj_objectWithKeyValues:responseObject];
        success(result.data);
    } failure:^(NSError *error) {
        failure(error);
        ONELog(@"音乐列表获取失败 %@", error);
    }];
}

/**
 *  请求音乐我详情数据
 */
+ (void)requestMusicDetail:(NSString *)url parameters:(id)parameters success:(void (^)(ONEMusicDetailItem *musicDetailItem))success failure:(void (^)(NSError *error))failure{
    
    url = [[ONEBaseUrl stringByAppendingPathComponent:music_detail] stringByAppendingPathComponent:url];
    [ONEHttpTool GET:url parameters:parameters success:^(id responseObject) {
        [ONEMusicDetailItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"detail_id" : @"id" };
        }];
        ONEMusicResultItem *result = [ONEMusicResultItem mj_objectWithKeyValues:responseObject];
        success([ONEMusicDetailItem mj_objectWithKeyValues:result.data]);
    } failure:^(NSError *error) {
        ONELog(@"音乐详情获取失败%@", error);
        failure(error);
    }];
}


/**
 *  请求评论数据
 */
+ (void)requestMusicComment:(NSString *)url parameters:(id)parameters success:(void (^)(NSArray <ONEMusicCommentItem *> *commentItems))success failure:(void (^)(NSError *error))failure
{
    url = [[ONEBaseUrl stringByAppendingPathComponent:comment_music] stringByAppendingPathComponent:url];
    [ONEHttpTool GET:url parameters:parameters success:^(id responseObject) {
        [ONEMusicCommentItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"comment_id" : @"id" };
        }];
        ONEMusicResultItem *commentResult = [ONEMusicResultItem mj_objectWithKeyValues:responseObject[@"data"]];
        if (success) success([ONEMusicCommentItem mj_objectArrayWithKeyValuesArray:commentResult.data]);
    } failure:^(NSError *error) {
        ONELog(@"评论数据获取失败%@", error);
        failure(error);
    }];
}

/**
 *  请求相似歌曲数据
 */
+ (void)requestMusicRelated:(NSString *)url parameters:(id)parameters success:(void (^)(NSArray <ONEMusicRelatedItem *>*relatedItems))success failure:(void (^)(NSError *error))failure
{
    url = [[ONEBaseUrl stringByAppendingPathComponent:related_music] stringByAppendingPathComponent:url];
    [ONEHttpTool GET:url parameters:parameters success:^(id responseObject) {
        [ONEMusicRelatedItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"related_id" : @"id"};
        }];
        ONEMusicResultItem *result = [ONEMusicResultItem mj_objectWithKeyValues:responseObject];
        success([ONEMusicRelatedItem mj_objectArrayWithKeyValuesArray:result.data]);
    } failure:^(NSError *error) {
        ONELog(@"音乐详情获取失败%@", error);
        failure(error);
    }];
}

/**
 *  获取用户资料
 *  数据处理不完善
 */
+ (void)requestUserInfo:(NSString *)url parameters:(id)parameters success:(void (^)(ONEAuthorItem *autoItem))success failure:(void (^)(NSError *error))failure;
{
    url = [[ONEBaseUrl stringByAppendingPathComponent:user_info] stringByAppendingPathComponent:url];
    [ONEHttpTool GET:url parameters:parameters success:^(id responseObject) {
        ONEAuthorItem *userInfoItem = [ONEAuthorItem mj_objectWithKeyValues:responseObject[@"data"]];
        success(userInfoItem);
    } failure:^(NSError *error) {
        ONELog(@"用户资料获取失败%@", error);
        failure(error);
    }];
}

/**
 *  喜欢
 */
+ (void)addPraise:(NSString *)url parameters:(id)parameters success:(void (^)(BOOL isSuccess, NSString *message))success failure:(void (^)(NSError *error))failure
{
    url = [ONEBaseUrl stringByAppendingPathComponent:url];
    [ONEHttpTool POST:url parameters:parameters success:^(id responseObject) {
        ONEMusicResultItem *result = [ONEMusicResultItem mj_objectWithKeyValues:responseObject];
        success(!result.res, result.msg);
    } failure:^(NSError *error) {
        failure(error);
        ONELog(@"喜欢请求失败%@", error);
    }];
}


/**
 *  ta的歌曲
 */
+ (void)requestPersonSong:(NSString *)url parameters:(id)parameters success:(void (^)(NSArray <ONEMusicRelatedItem *>*musics))success failure:(void (^)(NSError *error))failure
{
    url = [[ONEBaseUrl stringByAppendingPathComponent:works_music] stringByAppendingPathComponent:url];
    [ONEHttpTool GET:url parameters:parameters success:^(id responseObject) {
        success([ONEMusicRelatedItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"]]);
    } failure:^(NSError *error) {
        failure(error);
        ONELog(@"ta的歌曲获取失败%@", error);
    }];
}


/**
 *  获取一个月的歌单
 */
+ (void)requsetMusicByMonth:(NSString *)url parameters:(id)parameters success:(void (^)(NSArray <ONEMusicRelatedItem *>*musics))success failure:(void (^)(NSError *error))failure
{
    NSString *fullUrl = [[ONEBaseUrl stringByAppendingPathComponent:music_bymonth] stringByAppendingPathComponent:url];
    [ONEHttpTool GET:fullUrl parameters:parameters success:^(id responseObject) {
        [ONEMusicRelatedItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"related_id" : @"id"};
        }];
        success([ONEMusicRelatedItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"]]);
    } failure:^(NSError *error) {
        failure(error);
        ONELog(@"%@歌曲 获取失败%@",url, error);
    }];

}

/**
 *  获取音乐数据
 */
+ (void)requestMusic:(NSString *)url parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
}

#pragma mark - ↓↓↓↓↓↓↓↓↓↓↓↓ 电影 ↓↓↓↓↓↓↓↓↓↓↓↓
/**
 *  获取电影列表数据
 *
 *  @param url        请求地址 短地址
 *  @param parameters 请求参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
+ (void)requestMovieList:(NSString *)url parameters:(id)parameters succes:(void (^)(NSArray *movieLists))success failure:(void(^)(NSError *error))failure
{
    url = [[ONEBaseUrl stringByAppendingPathComponent:movie_list] stringByAppendingPathComponent:url];
    [ONEHttpTool GET:url parameters:nil success:^(id responseObject) {
        [ONEMovieListItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"movie_id" : @"id"};
        }];
        success([ONEMovieListItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"]]);
        
    } failure:^(NSError *error) {
        failure(error);
        ONELog(@"电影列表获取失败%@", error);
    }];
}

/**
 *  获取电影详情数据
 */
+ (void)requestMovieDetail:(NSString *)url parameters:(id)parameters success:(void (^)(ONEMovieDetailItem *movieDetail))success failure:(void (^)(NSError *error))failure
{
    url = [movie_detail stringByAppendingPathComponent:url];
    [ONEHttpTool GET:url parameters:nil success:^(id responseObject) {
        [ONEMovieDetailItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"movie_detailId" : @"id"};
        }];
        success([ONEMovieDetailItem mj_objectWithKeyValues:responseObject[@"data"]]);
        
    } failure:^(NSError *error) {
        failure(error);
        ONELog(@"电影详情获取失败%@",error);
    }];
}

/**
 *  获取电影故事数据
 */
+ (void)requestMovieStory:(NSString *)url parameters:(id)patameters success:(void (^)(ONEMovieResultItem *movieStory))success failure:(void (^)(NSError *))failure
{
    url = [movie stringByAppendingPathComponent:url];
    
    [ONEHttpTool GET:url parameters:nil success:^(id responseObject) {
        [ONEMovieStoryItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"movie_story_id" : @"id"};
        }];
        
        [ONEMovieResultItem mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data" : [ONEMovieStoryItem class]};
        }];
        
        ONEMovieResultItem *result = [ONEMovieResultItem mj_objectWithKeyValues:responseObject[@"data"]];
       
        success(result);
        
    } failure:^(NSError *error) {
        failure(error);
        ONELog(@"电影故事获取失败%@",error);
    }];
}

/**
 *  获取评审团
 */
+ (void)requestMovieReview:(NSString *)url parameters:(id)patameters success:(void (^)(ONEMovieResultItem *movieReview))success failure:(void (^)(NSError *error))failure
{
    url = [movie stringByAppendingPathComponent:url];
    
    [ONEHttpTool GET:url parameters:nil success:^(id responseObject) {
        [ONEMusicCommentItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"comment_id" : @"id"};
        }];
        
        [ONEMovieResultItem mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data" : [ONEMovieCommentItem class]};
        }];
        
        [ONEMusicCommentItem mj_setupIgnoredPropertyNames:^NSArray *{
            return @[@"user", @"type"];
        }];
        
        ONEMovieResultItem *result = [ONEMovieResultItem mj_objectWithKeyValues:responseObject[@"data"]];
        
        success(result);
        
    } failure:^(NSError *error) {
        failure(error);
        ONELog(@"电影故事获取失败%@",error);
    }];

}

@end
