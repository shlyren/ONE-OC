//
//  AppDelegate.m
//  ONE
//
//  Created by 任玉祥 on 16/4/1.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "AppDelegate.h"
#import "ONETabbarController.h"
#import "SVProgressHUD.h"
#import "ONEFPSLabel.h"
#import "SDImageCache.h"
#import "ONEHttpTool.h"
#import "ONEShareTool.h"
#import "ONENightModeTool.h"

@interface AppDelegate ()
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [ONETabbarController new];
    [self.window makeKeyAndVisible];
   
    // 监听网络状态的通知
    [ONEHttpTool startNotifier];
    // 显示时间
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
    
    // 初始化分享工具
    [ONEShareTool setupShareTool];
    // 初始化夜间模式
    [ONENightModeTool setupNightMode];
    
    // 界面 FPS 代码
    [ONEFPSLabel setupFPSLabel];
    
    ONELog(@"当前环境: DEBUG")
    
    return YES;
}


- (BOOL)application:(UIApplication *)app openURL:(nonnull NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(nonnull id)annotation
{
    BOOL result = [ONEShareTool handleOpenURL:url];
    
    if (!result) {
        
    }
    
    return result;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // 前台 按下home键
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // 进入后台后
    [self stopTimer];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // 从后台进入程序时
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
     // 进入程序后
    [self startTimer];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    [self clearMemory];
}

- (void)startTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(clearMemory) userInfo:nil repeats:true];
    
}

- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)clearMemory
{
    [[SDImageCache sharedImageCache] clearMemory];
}



@end
