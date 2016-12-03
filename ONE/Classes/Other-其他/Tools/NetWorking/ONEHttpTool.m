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

#pragma mark - network status
+ (void)startNotifier
{
    [[RealReachability sharedInstance] startNotifier];
}

+ (ONENetWorkStatus)currentNetWorkStatus
{
    switch ([[RealReachability sharedInstance] currentReachabilityStatus])
    {
        case RealStatusUnknown:
            return ONENetWorkStatusUnknown;
        case RealStatusNotReachable:
            return ONENetWorkStatusNoNetwork;
        case RealStatusViaWWAN:
            return ONENetWorkStatusIsWWAN;
        case RealStatusViaWiFi:
            return ONENetWorkStatusIsWiFi;
    }
    
//    return (ONENetWorkStatus)[[RealReachability sharedInstance] currentReachabilityStatus];
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


#pragma mark - 网络请求
+ (void)GET:(NSString *)url parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    [self requestMethod:RequestMethodGET url:url parameters:parameters success:success failure:failure];
}

+ (void)POST:(NSString *)url parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    [self requestMethod:RequestMethodPOST url:url parameters:parameters success:success failure:failure];
}

// 主要方法
+ (void)requestMethod:(RequestMethod)method url:(NSString *)url parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    // 成功的bolck
    void (^successBlock)(id responseObject) = ^(id res) {
        success(res);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = false;
        [SVProgressHUD dismiss];
    };
    
    //失败的block
    void (^failurBlock)(id responseObject) = ^(id responseObject) {
        failure(responseObject);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = false;
        [SVProgressHUD showErrorWithStatus:@"网络请求失败!"];
    };
    
    if (!self.haveNetwork)
    {
        [SVProgressHUD showWithStatus:@"没有网络,使用缓存..."];
        [ONEAutoCacheTool readFileAtPath:url completion:^(NSDictionary *responseObject) {
            successBlock(responseObject);
        }];
        return;
    }
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = true;
    [SVProgressHUD showWithStatus:@"加载中..."];
    
    if (method == RequestMethodGET)
    {
        [ONEHttpTool.shareHttpTool.manager GET:url
                                    parameters:parameters
                                      progress:nil
                                       success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
                                           
                                           if (success) successBlock(responseObject);
                                           
                                           // 缓存
                                           if (![url containsString:@"search"] && // 搜索无需缓存
                                               [[NSUserDefaults standardUserDefaults] boolForKey: ONEAutomaticCacheKey])
                                           {
                                               [ONEAutoCacheTool writeFile:responseObject withUrl:url];
                                           }
                                           
                                       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                           
                                           if (failure) failurBlock(error);
                                       }];
        
    }
    else if(method == RequestMethodPOST)
    {
        [ONEHttpTool.shareHttpTool.manager POST:url
                                     parameters:parameters
                                       progress:nil
                                        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                            
                                            if (success) successBlock(responseObject);
                                            
                                        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                            
                                            if (failure) failurBlock(error);
                                        }];
    }

}

+ (void)cancel
{
    [[ONEHttpTool shareHttpTool].manager.tasks makeObjectsPerformSelector:@selector(cancel)];
}

@end
