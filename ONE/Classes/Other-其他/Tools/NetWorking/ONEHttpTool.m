//
//  ONEHttpTool.m
//  ONE
//
//  Created by 任玉祥 on 16/4/2.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEHttpTool.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "ONEAutoCacheTool.h"
#import "RealReachability.h"

@interface ONEHttpTool ()
@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end


@implementation ONEHttpTool
- (AFHTTPSessionManager *)manager
{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];
    }
    return _manager;
}



+ (instancetype)shareHttpTool
{
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static ONEHttpTool *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (void)startNotifier
{
    [[RealReachability sharedInstance] startNotifier];
}

+ (ONENetWorkStatus)currentNetWorkStatus
{
    switch ([[RealReachability sharedInstance] currentReachabilityStatus]) {
        case RealStatusUnknown:
            return ONENetWorkStatusUnknown;
        case RealStatusNotReachable:
            return ONENetWorkStatusNoNetwork;
        case RealStatusViaWWAN:
            return ONENetWorkStatusIsWWAN;
        case RealStatusViaWiFi:
            return ONENetWorkStatusIsWiFi;
    }
}

+ (BOOL)haveNetwork
{
    ONENetWorkStatus status = [self currentNetWorkStatus];
    
    if (status == ONENetWorkStatusIsWWAN || status == ONENetWorkStatusIsWiFi)
    {
        return true;
    }else {
        [SVProgressHUD dismiss];
        return false;
    }
}

+ (void)cancel
{
    [[ONEHttpTool shareHttpTool].manager.tasks makeObjectsPerformSelector:@selector(cancel)];
}


+ (void)GET:(NSString *)url parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    if ([self haveNetwork])
    {
        [self requestMethod:RequestMethodGET url:url parameters:parameters success:^(id responseObject) {
            if (![url containsString:@"search"] && // 搜索无需缓存
                [[NSUserDefaults standardUserDefaults] boolForKey: ONEAutomaticCacheKey])
            {
                [ONEAutoCacheTool writeFile:responseObject withUrl:url];
            }
            if (success) success(responseObject);

        } failure:^(NSError *error) {
            if (failure) failure(error);
        }];
        
    }else {
        [ONEAutoCacheTool readFileAtPath:url completion:^(NSDictionary *responseObject) {
            success(responseObject);
        }];
    }
}

+ (void)POST:(NSString *)url parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    
    [self requestMethod:RequestMethodPOST url:url parameters:parameters success:^(id responseObject) {
        if (success) success(responseObject);
    } failure:^(NSError *error) {
        if (failure) failure(error);
    }];
}


+ (void)requestMethod:(RequestMethod)method url:(NSString *)url parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    void (^successBlock)(id responseObject) = ^(id responseObject) {
        success(responseObject);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = false;
        [SVProgressHUD dismiss];
    };
    
    void (^failurBlock)(id responseObject) = ^(id responseObject) {
        failure(responseObject);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = false;
        [SVProgressHUD dismiss];
    };
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = true;

    if (method == RequestMethodGET) {
        
        [[ONEHttpTool shareHttpTool].manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
            
            if (success) successBlock(responseObject);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (failure) failurBlock(error);
        }];
    }
    else {
        
        [[ONEHttpTool shareHttpTool].manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (success) successBlock(responseObject);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (failure) failurBlock(error);
        }];
    }
}

@end
