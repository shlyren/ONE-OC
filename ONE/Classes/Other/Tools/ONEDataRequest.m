//
//  ONEDataRequest.m
//  ONE
//
//  Created by 任玉祥 on 16/4/2.
//  Copyright © 2016年 任玉祥. All rights reserved.
//


#import "ONEDataRequest.h"
#import "ONEHttpTool.h"
#import "ONEMovieResultItem.h"

#import "ONEMusicResultItem.h"
#import "ONEAuthorItem.h"
#import "ONEMusicDetailItem.h"
#import "ONEMusicCommentItem.h"
#import "ONEMusicRelatedItem.h"
#import "ONEMovieListItem.h"
#import "ONEMovieDetailItem.h"
#import "ONEMovieStoryItem.h"
#import "ONEMovieCommentItem.h"

#import "ONEReadAdItem.h"
#import "ONEReadListItem.h"
#import "ONEReadCommentItem.h"
#import "ONECarouselDetailItem.h"

#import "ONEHomeSubtotalItem.h"

#import "ONESearchReadItem.h"
#import "ONESearchMusicItem.h"
#import "ONESearchMovieItem.h"

@implementation ONEDataRequest

#define fullUrl(centerUrl) [NSString stringWithFormat:@"%@/%@/%@", ONEBaseUrl, centerUrl, url]

#pragma mark - 音乐
/**
 *  请求音乐列表数据
 */
+ (void)requsetMusciIdList:(NSString *)url parameters:(id)parameters success:(void (^)(NSArray *musicIdList))success failure:(void (^)(NSError *error))failure
{
    
    NSString *fullUrl = fullUrl(music_idlist);

    [ONEHttpTool GET:fullUrl parameters:parameters success:^(NSDictionary *responseObject) {
        
        ONEMusicResultItem *result = [ONEMusicResultItem mj_objectWithKeyValues:responseObject];
        success(result.data);
    } failure:^(NSError *error) {
        if (failure) failure(error);
        ONELog(@"音乐列表获取失败 %@", error);
    }];
    
}

/**
 *  请求音乐详情数据
 */
+ (void)requestMusicDetail:(NSString *)url parameters:(id)parameters success:(void (^)(ONEMusicDetailItem *musicDetailItem))success failure:(void (^)(NSError *error))failure
{
    
    NSString *fullUrl = fullUrl(music_detail);
    
    [ONEHttpTool GET:fullUrl parameters:parameters success:^(NSDictionary *responseObject) {
        
        [ONEMusicDetailItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"detail_id" : @"id" };
        }];
        ONEMusicResultItem *result = [ONEMusicResultItem mj_objectWithKeyValues:responseObject];
        success([ONEMusicDetailItem mj_objectWithKeyValues:result.data]);
    } failure:^(NSError *error) {
        ONELog(@"音乐详情获取失败%@", error);
        if (failure) failure(error);
    }];
}


/**
 *  请求评论数据
 */
+ (void)requestMusicComment:(NSString *)url parameters:(id)parameters success:(void (^)(NSArray <ONEMusicCommentItem *> *commentItems))success failure:(void (^)(NSError *error))failure
{
    
    NSString *fullUrl = fullUrl(comment_music);

    [ONEHttpTool GET:fullUrl parameters:parameters success:^(NSDictionary *responseObject) {
        
        [ONEMusicCommentItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"comment_id" : @"id" };
        }];
        ONEMusicResultItem *commentResult = [ONEMusicResultItem mj_objectWithKeyValues:responseObject[@"data"]];
        if (success) success([ONEMusicCommentItem mj_objectArrayWithKeyValuesArray:commentResult.data]);
    } failure:^(NSError *error) {
        ONELog(@"评论数据获取失败%@", error);
        if (failure) failure(error);
    }];

}

/**
 *  请求相似歌曲数据
 */
+ (void)requestMusicRelated:(NSString *)url parameters:(id)parameters success:(void (^)(NSArray <ONEMusicRelatedItem *>*relatedItems))success failure:(void (^)(NSError *error))failure
{
    
    NSString *fullUrl = fullUrl(related_music);
    
    [ONEHttpTool GET:fullUrl parameters:parameters success:^(NSDictionary *responseObject) {
        
        [ONEMusicRelatedItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"related_id" : @"id"};
        }];
        ONEMusicResultItem *result = [ONEMusicResultItem mj_objectWithKeyValues:responseObject];
        success([ONEMusicRelatedItem mj_objectArrayWithKeyValuesArray:result.data]);
    } failure:^(NSError *error) {
        ONELog(@"音乐详情获取失败%@", error);
        if (failure) failure(error);
    }];

}

/**
 *  获取用户资料
 *  数据处理不完善
 */
+ (void)requestUserInfo:(NSString *)url parameters:(id)parameters success:(void (^)(ONEAuthorItem *autoItem))success failure:(void (^)(NSError *error))failure;
{
    NSString *fullUrl = fullUrl(user_info);

    [ONEHttpTool GET:fullUrl parameters:parameters success:^(NSDictionary *responseObject) {
        
        ONEAuthorItem *userInfoItem = [ONEAuthorItem mj_objectWithKeyValues:responseObject[@"data"]];
        success(userInfoItem);
    } failure:^(NSError *error) {
        ONELog(@"用户资料获取失败%@", error);
        if (failure) failure(error);
    }];
    
}

#pragma mark - 喜欢
/**
 *  喜欢
 */
+ (void)addPraise:(NSString *)url parameters:(id)parameters success:(void (^)(BOOL isSuccess, NSString *message))success failure:(void (^)(NSError *error))failure
{
    url = [ONEBaseUrl stringByAppendingPathComponent:url];
    [ONEHttpTool POST:url parameters:parameters success:^(NSDictionary *responseObject) {
        ONEMusicResultItem *result = [ONEMusicResultItem mj_objectWithKeyValues:responseObject];
        success(!result.res, result.msg);
    } failure:^(NSError *error) {
        if (failure) failure(error);
        ONELog(@"喜欢请求失败%@", error);
    }];
}


/**
 *  ta的歌曲
 */
+ (void)requestPersonSong:(NSString *)url parameters:(id)parameters success:(void (^)(NSArray <ONEMusicRelatedItem *>*musics))success failure:(void (^)(NSError *error))failure
{
    
    NSString *fullUrl = fullUrl(works_music);
    
    [ONEHttpTool GET:fullUrl parameters:parameters success:^(NSDictionary *responseObject) {
        success([ONEMusicRelatedItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"]]);
    } failure:^(NSError *error) {
        if (failure) failure(error);
        ONELog(@"ta的歌曲获取失败%@", error);
    }];
}


/**
 *  获取一个月的歌单
 */
+ (void)requsetMusicByMonth:(NSString *)url parameters:(id)parameters success:(void (^)(NSArray <ONEMusicRelatedItem *>*musics))success failure:(void (^)(NSError *error))failure
{
    
    NSString *fullUrl = fullUrl(music_bymonth);

    [ONEHttpTool GET:fullUrl parameters:parameters success:^(NSDictionary *responseObject) {
        
        [ONEMusicRelatedItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"related_id" : @"id"};
        }];
        success([ONEMusicRelatedItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"]]);
    } failure:^(NSError *error) {
        if (failure) failure(error);
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
 */
+ (void)requestMovieList:(NSString *)url parameters:(id)parameters succes:(void (^)(NSArray *movieLists))success failure:(void(^)(NSError *error))failure
{
    
    NSString *fullUrl = fullUrl(movie_list);

    [ONEHttpTool GET:fullUrl parameters:nil success:^(NSDictionary *responseObject) {
        
        [ONEMovieListItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"movie_id" : @"id"};
        }];
        success([ONEMovieListItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"]]);
        
    } failure:^(NSError *error) {
        if (failure) failure(error);
        ONELog(@"电影列表获取失败%@", error);
    }];
}

/**
 *  获取电影详情数据
 */
+ (void)requestMovieDetail:(NSString *)url parameters:(id)parameters success:(void (^)(ONEMovieDetailItem *movieDetail))success failure:(void (^)(NSError *error))failure
{
    NSString *fullUrl = [NSString stringWithFormat:@"%@/%@", movie_detail, url];
    
    [ONEHttpTool GET:fullUrl parameters:nil success:^(NSDictionary *responseObject) {
        
        [ONEMovieDetailItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"movie_detailId" : @"id"};
        }];
        success([ONEMovieDetailItem mj_objectWithKeyValues:responseObject[@"data"]]);
        
    } failure:^(NSError *error) {
        if (failure) failure(error);
        ONELog(@"电影详情获取失败%@",error);
    }];
}

/**
 *  获取电影故事数据
 */
+ (void)requestMovieStory:(NSString *)url parameters:(id)patameters success:(void (^)(ONEMovieResultItem *movieStory))success failure:(void (^)(NSError *))failure
{
     NSString *fullUrl = [NSString stringWithFormat:@"%@/%@", movie, url];
    [ONEHttpTool GET:fullUrl parameters:nil success:^(NSDictionary *responseObject) {

        [ONEMovieStoryItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"movie_story_id" : @"id"};
        }];
        
        [ONEMovieResultItem mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data" : [ONEMovieStoryItem class]};
        }];
        
        ONEMovieResultItem *result = [ONEMovieResultItem mj_objectWithKeyValues:responseObject[@"data"]];
        
        success(result);
        
    } failure:^(NSError *error) {
        if (failure) failure(error);
        ONELog(@"电影故事获取失败%@",error);
    }];
    
}

/**
 *  获取评审团
 */
+ (void)requestMovieReview:(NSString *)url parameters:(id)patameters success:(void (^)(ONEMovieResultItem *movieReview))success failure:(void (^)(NSError *error))failure
{
    NSString *fullUrl = [NSString stringWithFormat:@"%@/%@", movie, url];
    
    [ONEHttpTool GET:fullUrl parameters:nil success:^(NSDictionary *responseObject) {
        
        [ONEMusicCommentItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"comment_id" : @"id"};
        }];
        
        [ONEMovieResultItem mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data" : [ONEMovieCommentItem class]};
        }];
        
        ONEMovieResultItem *result = [ONEMovieResultItem mj_objectWithKeyValues:responseObject[@"data"]];
        
        success(result);
        
    } failure:^(NSError *error) {
        if (failure) failure(error);
        ONELog(@"电影故事获取失败%@",error);
    }];

}

/**
 *  获取用户评论
 */
+ (void)requestMovieComment:(NSString *)url parameters:(id)patameters success:(void (^)(NSMutableArray *movieComments))success failure:(void (^)(NSError *error))failure
{
    
    NSString *fullUrl = fullUrl(movie_comment);
    [ONEHttpTool GET:fullUrl parameters:patameters success:^(NSDictionary *responseObject) {
        
        [ONEMovieCommentItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"comment_id" : @"id"};
        }];
        success([ONEMovieCommentItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]]);
        
    } failure:^(NSError *error) {
        if (failure) failure(error);
        ONELog(@"电影评论获取失败%@",error);
        
    }];
}


#pragma mark - 阅读
/**
 *  广告
 */
+ (void)requestReadAdSuccess:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    
    NSString *fullUrl = readAdUrl;
    [ONEHttpTool GET:fullUrl parameters:nil success:^(NSDictionary *responseObject) {
         
        [ONEReadAdItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"ad_id" : @"id"};
        }];
        
        NSArray *ads = [ONEReadAdItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        if (success) success(ads);
        
    } failure:^(NSError *error) {
        if (failure) failure(error);
        ONELog(@"阅读广告获取失败%@",error);
    }];

}
/** 阅读轮播 */
+ (void)requestCarousel:(NSString *)url paramrters:(id)parameters success:(void (^)(NSArray *carouselDetailItem))success failure:(void (^)(NSError *error))failure
{
    NSString *fullUrl = fullUrl(reading_carousel);
    [ONEHttpTool GET:fullUrl parameters:nil success:^(NSDictionary *responseObject) {
        
        NSArray *carouselDetailItem = [ONECarouselDetailItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        if (success) success(carouselDetailItem);
        
    } failure:^(NSError *error) {
        if (failure) failure(error);
        ONELog(@"广告详情获取失败%@",error);
    }];
}

/**
 *  阅读列表
 */
+ (void)requestReadList:(NSString *)url parameters:(id)parameters succsee:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSString *fullUrl = readIndexUrl;
    
    [ONEHttpTool GET:fullUrl parameters:nil success:^(NSDictionary *responseObject) {
        
        [ONEReadListItem mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"essay" : [ONEEssayItem class],
                     @"serial" : [ONESerialItem class],
                     @"question" : [ONEQuestionItem class]
                     };
        }];
        
        [ONEEssayItem mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"author" : [ONEAuthorItem class]};
        }];
        
        [ONESerialItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"content_id" : @"id"};
        }];
        ONEReadListItem *item = [ONEReadListItem mj_objectWithKeyValues:responseObject[@"data"]];
        
        if (success) success(item);
        
    } failure:^(NSError *error) {
        if (failure) failure(error);
        ONELog(@"阅读列表获取失败%@",error);
        }];
    
}


/**
 *  短篇详情
 */
+ (void)requestEssayDetail:(NSString *)url parameters:(id)parameters succsee:(void (^)(ONEEssayItem *essay))success failure:(void (^)(NSError *error))failure
{
    
    NSString *fullUrl = fullUrl(essay);
    
    [ONEHttpTool GET:fullUrl parameters:parameters success:^(NSDictionary *responseObject) {
        
        [ONEEssayItem mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"author" : [ONEAuthorItem class]};
        }];
        
        ONEEssayItem *essay = [ONEEssayItem mj_objectWithKeyValues:responseObject[@"data"]];
        if (success) success(essay);
        
    } failure:^(NSError *error) {
        if (failure) failure(error);
        ONELog(@"问题详情获取失败%@",error);
    }];
}

/**
 *  连载详情
 */
+ (void)requestSerialDetail:(NSString *)url parameters:(id)parameters succsee:(void (^)(ONESerialItem *serial))success failure:(void (^)(NSError *error))failure
{
    NSString *fullUrl = fullUrl(serialcontent);
    [ONEHttpTool GET:fullUrl parameters:parameters success:^(NSDictionary *responseObject) {
        
        [ONESerialItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"content_id" : @"id"};
        }];
        
        ONESerialItem *serial = [ONESerialItem mj_objectWithKeyValues:responseObject[@"data"]];
        if (success) success(serial);
        
    } failure:^(NSError *error) {
        if (failure) failure(error);
        ONELog(@"问题详情获取失败%@",error);
    }];
}


/**
 *  问题详情
 */
+ (void)requestQuestionDetail:(NSString *)url parameters:(id)parameters succsee:(void (^)(ONEQuestionItem *question))success failure:(void (^)(NSError *error))failure
{
    NSString *fullUrl = fullUrl(question);

    [ONEHttpTool GET:fullUrl parameters:parameters success:^(NSDictionary *responseObject) {
        
        
        ONEQuestionItem *question = [ONEQuestionItem mj_objectWithKeyValues:responseObject[@"data"]];
        if (success) success(question);
        
    } failure:^(NSError *error) {
        if (failure) failure(error);
        ONELog(@"问题详情获取失败%@",error);
    }];
    
}

/**
 *  阅读评论数据
 */
+ (void)requestReadComment:(NSString *)url parameters:(id)parameters success:(void (^)(NSArray *commentItems))success failure:(void (^)(NSError *error))failure
{
     NSString *fullUrl = [NSString stringWithFormat:@"%@/%@",ONEBaseUrl, url];
    [ONEHttpTool GET:fullUrl parameters:parameters success:^(NSDictionary *responseObject) {
        
        [ONEReadCommentItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"comment_id" : @"id" };
        }];
        
        NSArray *Item = [ONEReadCommentItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
        if (success) success(Item);
    } failure:^(NSError *error) {
        ONELog(@"评论数据获取失败%@", error);
        if (failure) failure(error);
    }];
    
}


/** 短篇 推荐 */
+ (void)requestEssayRelated:(NSString *)url paramrters:(id)parameters success:(void (^)(NSArray *essayRelated))success failure:(void (^)(NSError *error))failure
{
    
    NSString *fullUrl = [NSString stringWithFormat:@"%@/%@",ONEBaseUrl, url];
    [ONEHttpTool GET:fullUrl parameters:nil success:^(NSDictionary *responseObject) {
        
        [ONEEssayItem mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"author" : [ONEAuthorItem class]};
        }];
        
        NSArray *essay = [ONEEssayItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        if (success) success(essay);
        
    } failure:^(NSError *error) {
        if (failure) failure(error);
        ONELog(@"短篇推荐获取失败%@",error);
    }];
}

/** 连载 推荐 */
+ (void)requestSerialRelated:(NSString *)url paramrters:(id)parameters success:(void (^)(NSArray *serialRelated))success failure:(void (^)(NSError *error))failure
{
     NSString *fullUrl = [NSString stringWithFormat:@"%@/%@",ONEBaseUrl, url];
    [ONEHttpTool GET:fullUrl parameters:nil success:^(NSDictionary *responseObject) {
        
        [ONESerialItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"content_id" : @"id"};
        }];
        
        NSArray *serialRelated = [ONESerialItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        if (success) success(serialRelated);
        
    } failure:^(NSError *error) {
        if (failure) failure(error);
        ONELog(@"连载推荐获取失败%@",error);
    }];
}

/** 问题 推荐 */
+ (void)requestQuestionRelated:(NSString *)url paramrters:(id)parameters success:(void (^)(NSArray *questionRelated))success failure:(void (^)(NSError *error))failure
{
     NSString *fullUrl = [NSString stringWithFormat:@"%@/%@",ONEBaseUrl, url];
    [ONEHttpTool GET:fullUrl parameters:nil success:^(NSDictionary *responseObject) {
        
        NSArray *questionRelated = [ONEQuestionItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        if (success) success(questionRelated);
        
    } failure:^(NSError *error) {
        if (failure) failure(error);
        ONELog(@"问题推荐获取失败%@",error);
    }];

}

/** 连载列表 */
+ (void)requestSeriaList:(NSString *)url paramrters:(id)parameters success:(void (^)(NSArray *serialList))success failure:(void (^)(NSError *error))failure
{
    NSString *fullUrl = fullUrl(serial_list);
    
    [ONEHttpTool GET:fullUrl parameters:parameters success:^(NSDictionary *responseObject) {
        
        [ONESerialItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"content_id" : @"id"};
        }];
        
        NSArray *serialList = [ONESerialItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
        if (success) success(serialList);
        
    } failure:^(NSError *error) {
        if (failure) failure(error);
        ONELog(@"连载列表获取失败%@",error);
    }];
}

#pragma mark - 首页
/** 首页 小记 */
+ (void)requestHomeSubtotal:(NSString *)url paramrters:(id)parameters success:(void (^)(NSArray *homeSubtotal))success failure:(void (^)(NSError *error))failure
{
     NSString *fullUrl = [NSString stringWithFormat:@"%@/hp/%@",ONEBaseUrl, url];
    [ONEHttpTool GET:fullUrl parameters:nil success:^(NSDictionary *responseObject) {
        
        NSArray *homeSubtotal = [ONEHomeSubtotalItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        if (success) success(homeSubtotal);
        
    } failure:^(NSError *error) {
        if (failure) failure(error);
        ONELog(@"首页数据获取失败%@",error);
    }];
}


#pragma mark - 搜索
/** 插图 */
+ (void)requestSearchHp:(NSString *)url success:(void (^)(NSArray *hpResult))success failure:(void (^)(NSError *error))failure
{
    url = [search_hp stringByAppendingPathComponent:url];
    [ONEHttpTool GET:url parameters:nil success:^(id responseObject) {
        
        NSArray *hpResult = [ONEHomeSubtotalItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        if (success) success(hpResult);
        
    } failure:^(NSError *error) {
        if (failure) failure(error);
        ONELog(@"插图数据搜索失败%@",error);
    }];

}

/** 阅读 */
+ (void)requestSearchRead:(NSString *)url success:(void (^)(NSArray *readResult))success failure:(void (^)(NSError *error))failure
{
    url = [search_reading stringByAppendingPathComponent:url];
    [ONEHttpTool GET:url parameters:nil success:^(id responseObject) {
        
        [ONESearchReadItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"read_id" : @"id"};
        }];
        
        NSArray *readResult = [ONESearchReadItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        if (success) success(readResult);
        
    } failure:^(NSError *error) {
        if (failure) failure(error);
        ONELog(@"阅读数据搜索失败%@",error);
    }];

}

/** 音乐 */
+ (void)requestSearchMusic:(NSString *)url success:(void (^)(NSArray *musicResult))success failure:(void (^)(NSError *error))failure
{
    url = [search_music stringByAppendingPathComponent:url];
    [ONEHttpTool GET:url parameters:nil success:^(id responseObject) {
        //music_detail_id
        [ONESearchMusicItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"music_detail_id" : @"id"};
        }];
        NSArray *musicResult = [ONESearchMusicItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        if (success) success(musicResult);
        
    } failure:^(NSError *error) {
        if (failure) failure(error);
        ONELog(@"音乐数据搜索失败%@",error);
    }];

}

/** 影视 */
+ (void)requestSearchMovie:(NSString *)url success:(void (^)(NSArray *movieResult))success failure:(void (^)(NSError *error))failure
{
    url = [search_movie stringByAppendingPathComponent:url];
    [ONEHttpTool GET:url parameters:nil success:^(id responseObject) {
        //movie_id
        
        [ONESearchMovieItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"movie_id" : @"id"};
        }];
        NSArray *movieResult = [ONESearchMovieItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        success(movieResult);
        
    } failure:^(NSError *error) {
        if (failure) failure(error);
        ONELog(@"影视数据搜索失败%@",error);
    }];

}

/** 用户 */
+ (void)requestSearchAuthor:(NSString *)url success:(void (^)(NSArray *authorResult))success failure:(void (^)(NSError *error))failure
{
    url = [search_author stringByAppendingPathComponent:url];
    [ONEHttpTool GET:url parameters:nil success:^(id responseObject) {
        
        NSArray *homeSubtotal = [ONEAuthorItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        if (success) success(homeSubtotal);
        
    } failure:^(NSError *error) {
        if (failure) failure(error);
        ONELog(@"用户数据搜索失败%@",error);
    }];

}
@end
