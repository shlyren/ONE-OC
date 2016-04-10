//
//  ONEHttpTool.h
//  ONE
//
//  Created by 任玉祥 on 16/4/2.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface ONEHttpTool : NSObject


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
