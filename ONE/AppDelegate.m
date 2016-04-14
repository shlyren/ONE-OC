//
//  AppDelegate.m
//  ONE
//
//  Created by 任玉祥 on 16/4/1.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import "AppDelegate.h"
#import "ONETabbarController.h"
#import "SVProgressHUD.h"
#import "ONEFPSLabel.h"
//#import "AFNetworking.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [ONETabbarController new];
    [self.window makeKeyAndVisible];
    
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
    
//    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
//    //设置manager在网络发生变化的时回调的Block
//    
//    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        NSLog(@"----当前网络状态---%zd", status);
//    }];
//    /**
//     * status：表示当前网络的状态，是个枚举类型变量，具有以下取值
//     *		AFNetworkReachabilityStatusUnknown = -1
//     *		AFNetworkReachabilityStatusNotReachable = 0
//     *		AFNetworkReachabilityStatusReachableViaWWAN = 1
//     *		AFNetworkReachabilityStatusReachableViaWiFi = 2
//     */
//    //开始监听
//    
//    [manager startMonitoring];
//    
    // 界面 FPS 代码
#if DEBUG
    [self.window addSubview: [[ONEFPSLabel alloc] initWithFrame: CGRectMake(15, ONEScreenHeight - 40, 55, 50)]];
#else
#endif
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
