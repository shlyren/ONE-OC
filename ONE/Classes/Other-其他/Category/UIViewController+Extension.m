//
//  UIViewController+Extension.m
//  ONE
//
//  Created by 任玉祥 on 16/4/16.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "UIViewController+Extension.h"

@implementation UIViewController (Extension)


- (UIViewController *)topViewController
{
    return [self topViewControllerWithRootViewController:self];
}

- (UIViewController *)topViewControllerWithRootViewController:(UIViewController*)rootViewController
{
    if ([rootViewController isKindOfClass:[UITabBarController class]])
    {

        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    }
    else if ([rootViewController isKindOfClass:[UINavigationController class]])
    {
        
        UINavigationController *navigationController = (UINavigationController *)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
        
    }
    else if (rootViewController.presentedViewController)
    {
        
        return [self topViewControllerWithRootViewController:rootViewController.presentedViewController];
        
    }
    else
    {
        return rootViewController;
    }
}

@end
