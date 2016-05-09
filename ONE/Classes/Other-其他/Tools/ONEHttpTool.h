//
//  ONEHttpTool.h
//  ONE
//
//  Created by 任玉祥 on 16/4/2.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, RequestMethod) {
    RequestMethodGET,
    RequestMethodPOST
};

typedef NS_ENUM(NSInteger, ONENetWorkStatus) {
    ONENetWorkStatusUnknown = -1, // 未知
    ONENetWorkStatusNoNetwork = 0, // 无网络
    ONENetWorkStatusIsWWAN = 1,  // 蜂窝网
    ONENetWorkStatusIsWiFi = 2  // wifi
};

@interface ONEHttpTool : NSObject

/**
 *  是否有网络
 */
+ (BOOL)haveNetwork;

/**
 *  网络状态
 */
+ (ONENetWorkStatus)currentNetWorkStatus;

+ (void)cancel;


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

+ (void)requestMethod:(RequestMethod)method url:(NSString *)url parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
