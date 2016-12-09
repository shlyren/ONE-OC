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
#import "ONEPushTool.h"
#import "ONESearchViewController.h"
#import "ONENavigationController.h"

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
    
    [ONEPushTool registerForRemoteNotificationApplication:application didFinishLaunchingWithOptions:launchOptions];
    
    
//    if (self.window.rootViewController.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable)
//    {
//        [self setup3DTouchItems:application];
//    }
//    if ([UIDevice currentDevice]) {
//        
//    }
//    [self setup3DTouchItems:application];
    
    return YES;
}

#pragma mark - 设置3DTouch
- (void)setup3DTouchItems:(UIApplication *)application
{
    UIApplicationShortcutItem *share = [[UIApplicationShortcutItem alloc] initWithType: @"shareONE" localizedTitle: @"分享" localizedSubtitle: nil icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeShare] userInfo: nil];
    UIApplicationShortcutItem *clear = [[UIApplicationShortcutItem alloc] initWithType: @"clearIcon" localizedTitle: @"任玉祥" localizedSubtitle: nil icon: [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeFavorite] userInfo: nil];
    UIApplicationShortcutItem *search = [[UIApplicationShortcutItem alloc] initWithType: @"searchItem" localizedTitle: @"搜索" localizedSubtitle: nil icon: [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeSearch] userInfo: nil];
    application.shortcutItems = @[search, clear, share];
    
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
{
    NSString *type = shortcutItem.type;
    if ([type isEqualToString: @"shareONE"])
    {
        [ONEShareTool showShareView:application.keyWindow.rootViewController content:@"ONE by Yuxiang" url:@"https://yuxiang.ren" image:nil];
    }
    else if([type isEqualToString: @"searchItem"])
    {
        ONENavigationController *nav = [[ONENavigationController alloc] initWithRootViewController:[ONESearchViewController new]];
        [application.keyWindow.rootViewController presentViewController:nav animated:true completion:nil];

    }
    else if([type isEqualToString: @"clearIcon"])
    {
        application.applicationIconBadgeNumber = 0;
        [ONEPushTool resetBadge];
    }
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

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [ONEPushTool application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    [ONEPushTool application:application didFailToRegisterForRemoteNotificationsWithError:error];
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
