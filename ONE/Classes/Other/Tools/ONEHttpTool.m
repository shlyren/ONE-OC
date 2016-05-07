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

static ONEHttpTool *_instance;

+ (instancetype)shareHttpTool
{
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
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
    
    if (status == ONENetWorkStatusIsWWAN || status == ONENetWorkStatusIsWiFi) {
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
    if ([ONEHttpTool haveNetwork]) {
        
        [[ONEHttpTool shareHttpTool] GET:url parameters:parameters success:^(id responseObject) {
            
            if ([[NSUserDefaults standardUserDefaults] boolForKey: ONEAutomaticCacheKey]) {
                [ONEAutoCacheTool writeFile:responseObject withUrl:url];
            }
            if (success) success(responseObject);
            
        } failure:^(NSError *error) {
            
            if (failure) failure(error);
        }];
    }else {
//        success([ONEAutoCacheTool readFileAtPath:url]);
        
        [ONEAutoCacheTool readFileAtPath:url completion:^(NSDictionary *responseObject) {
            success(responseObject);
        }];
    }
}

+ (void)POST:(NSString *)url parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    
    [[ONEHttpTool shareHttpTool] POST:url parameters:parameters success:^(id responseObject) {
        
        if (success) success(responseObject);
        
    } failure:^(NSError *error) {
       
        if (failure) failure(error);
        
    }];
}

- (void)GET:(NSString *)url parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = true;

    
    [self.manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = false;
        if (success) success(responseObject);
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = false;
        if (failure) failure(error);
    }];

}

- (void)POST:(NSString *)url parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = true;
    
    [self.manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = false;
        if (success) success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = false;
        if (failure) failure(error);
    }];

}


@end
