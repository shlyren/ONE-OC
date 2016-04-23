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
    
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
    
    // 界面 FPS 代码
#if DEBUG
    [self.window addSubview: [[ONEFPSLabel alloc] initWithFrame:CGRectMake(15, ONEScreenHeight - 50, 0, 0)]];
#else
#endif
    
    return YES;
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
