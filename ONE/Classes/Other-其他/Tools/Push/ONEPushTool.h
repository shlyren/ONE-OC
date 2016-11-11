//
//  ONEPushTool.h
//  ONE
//
//  Created by 任玉祥 on 2016/11/8.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ONEPushTool : NSObject
+ (void)registerForRemoteNotificationApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
+ (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
+ (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error;

+ (void)resetBadge;
@end
