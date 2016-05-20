//
//  ONEHttpTool.h
//  ONE
//
//  Created by 任玉祥 on 16/4/2.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  请求方式
 */
typedef NS_ENUM(NSInteger, RequestMethod) {
    /** get */
    RequestMethodGET,
    /** post */
    RequestMethodPOST
};

/**
 *  网络状态
 */
typedef NS_ENUM(NSInteger, ONENetWorkStatus) {
    /** 未知 */
    ONENetWorkStatusUnknown = -1,
    /** 无网络 */
    ONENetWorkStatusNoNetwork = 0,
    /** 蜂窝网 */
    ONENetWorkStatusIsWWAN = 1,
    /** wifi */
    ONENetWorkStatusIsWiFi = 2,
};

@interface ONEHttpTool : NSObject

+ (void)startNotifier;
/**
 *  是否有网络
 */
+ (BOOL)haveNetwork;

/**
 *  网络状态
 */
+ (ONENetWorkStatus)currentNetWorkStatus;

+ (void)cancel;


+ (void)requestMethod:(RequestMethod)method url:(NSString *)url parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;


/**
 *  GET 请求
 *
 *  @param url        请求地址
 *  @param parameters 请求参数
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (void)GET:(NSString *)url parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;



/**
 *  POST 请求
 *
 *  @param url        请求地址
 *  @param parameters 请求参数
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (void)POST:(NSString *)url parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;


@end
