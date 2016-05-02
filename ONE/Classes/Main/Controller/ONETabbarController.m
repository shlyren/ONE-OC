//
//  ONETabbarController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/1.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONETabbarController.h"
#import "ONENavigationController.h"
#import "ONEHomeViewController.h"
#import "ONEReadViewController.h"
#import "ONEMusicScrollViewController.h"
#import "ONEMovieViewController.h"
#import "ONETabBar.h"

@interface ONETabbarController ()<UITabBarDelegate>
@property (nonatomic, weak) UITabBarItem *tabBarItem;
@end

@implementation ONETabbarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpAllChildViewController];

    [self setupTabBar];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if ([UIApplication sharedApplication].isNetworkActivityIndicatorVisible) return;
        
    if (self.tabBarItem == item)
    {
        // 发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:ONETabBarItemDidRepeatClickNotification object:nil];
    }
    self.tabBarItem = item;
}

- (void)setupTabBar
{
    ONETabBar *tabBar = [ONETabBar new];
    tabBar.delegate = self;
    [self setValue:tabBar forKey:@"tabBar"];
    
}

// 添加所有子控制器
- (void)setUpAllChildViewController
{
    // 主页
    [self setUpOneChildViewController:[ONEHomeViewController new]
                                title:@"首页"
                                image:@"tab_home_default"
                        selectedImage:@"tab_home_selected"];
    // 阅读
    [self setUpOneChildViewController:[ONEReadViewController new]
                                title:@"阅读"
                                image:@"tab_reading_default"
                        selectedImage:@"tab_reading_selected"];
    
    // 音乐
    [self setUpOneChildViewController:[ONEMusicScrollViewController new]
                                title:@"音乐"
                                image:@"tab_music_default"
                        selectedImage:@"tab_music_selected"];
    // 电影
    [self setUpOneChildViewController:[ONEMovieViewController new]
                                title:@"电影"
                                image:@"tab_movie_default"
                        selectedImage:@"tab_movie_selected"];
    
}


// 添加一个子控制器
- (void)setUpOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)imageName selectedImage:(NSString *)selectedImageName
{
    
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    if ([vc isKindOfClass:[ONEHomeViewController class]]) 
    {
        vc.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_title"]];
    }else {
        vc.title = title;
    }
    
    [self addChildViewController:[[ONENavigationController alloc] initWithRootViewController:vc]];
}


@end
