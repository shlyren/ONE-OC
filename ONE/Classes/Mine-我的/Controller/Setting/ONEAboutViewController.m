//
//  ONEAboutViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/5/20.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEAboutViewController.h"


@implementation ONEAboutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"关于";
    [self setupGroup];
}

- (void)setupGroup;
{
    ONEDefaultCellItem *item1 = [ONEDefaultCellItem itemWithTitle:@"源代码" accessoryType:UITableViewCellAccessoryDisclosureIndicator action:^(id parameter) {
        
        [self openUrl:@"https://github.com/shlyren/ONE-OC"];
    }];
    
    ONEDefaultCellItem *item2 = [ONEDefaultCellItem itemWithTitle:@"作者微博" accessoryType:UITableViewCellAccessoryDisclosureIndicator action:^(id parameter) {
                                                               
        [self openUrl:@"http://weibo.com/shlyjen"];
                                                               
    }];
    
    ONEDefaultCellItem *item3 = [ONEDefaultCellItem itemWithTitle:@"作者首页" accessoryType:UITableViewCellAccessoryDisclosureIndicator action:^(id parameter) {
        
        [self openUrl:@"http://yuxiang.ren"];
        
    }];
    
    [self.settingItems addObject:[ONEDefaultCellGroupItem groupWithItems:@[item1,item2,item3]]];
}

- (void)openUrl:(NSString *)urlStr
{
    NSURL *url = [NSURL URLWithString:urlStr];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

@end
