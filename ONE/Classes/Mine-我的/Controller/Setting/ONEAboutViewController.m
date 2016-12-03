//
//  ONEAboutViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/5/20.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEAboutViewController.h"
#import "ONEURLConst.h"
#import "ONEWebViewController.h"

@implementation ONEAboutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"关于";
    [self setupGroup1];
    [self setupGroup2];
    [self setupGroup3];
    [self setupGroup4];
}

- (void)setupGroup1
{
    ONEDefaultCellItem *item1 = [ONEDefaultCellItem itemWithTitle:@"用户协议" accessoryType:UITableViewCellAccessoryDisclosureIndicator action:^(id parameter) {
        [self openUrl:procotolUrl];
    }];
    [self.settingItems addObject:[ONEDefaultCellGroupItem groupWithItems:@[item1]]];
}

- (void)setupGroup2;
{
    ONEDefaultCellItem *item1 = [ONEDefaultCellItem itemWithTitle:@"SouceCode" accessoryType:UITableViewCellAccessoryDisclosureIndicator action:^(id parameter) {
        
        [self openUrl:@"https://github.com/shlyren/ONE-OC"];
    }];
    
    ONEDefaultCellItem *item2 = [ONEDefaultCellItem itemWithTitle:@"Homepage" accessoryType:UITableViewCellAccessoryDisclosureIndicator action:^(id parameter) {
        
        [self openUrl:@"https://shlyren.com"];
        
    }];
    ONEDefaultCellItem *item3 = [ONEDefaultCellItem itemWithTitle:@"Blog" accessoryType:UITableViewCellAccessoryDisclosureIndicator action:^(id parameter) {
        
        [self openUrl:@"https://yuxiang.ren"];
        
    }];
    
    ONEDefaultCellItem *item4 = [ONEDefaultCellItem itemWithTitle:@"Resume" accessoryType:UITableViewCellAccessoryDisclosureIndicator action:^(id parameter) {
        [self openUrl:@"https://shlyren.com/resume"];
    }];

    ONEDefaultCellGroupItem *item = [ONEDefaultCellGroupItem groupWithItems:@[item1, item2, item3, item4]];
    item.headerTitle = @"Website";
    [self.settingItems addObject:item];
}

- (void)setupGroup3
{
    ONEDefaultCellItem *item1 = [ONEDefaultCellItem itemWithTitle:@"Weibo" accessoryType:UITableViewCellAccessoryDisclosureIndicator action:^(id parameter) {
        
        [self openUrl:@"https://weibo.com/shlyjen"];
        
    }];
    
    ONEDefaultCellItem *item2 = [ONEDefaultCellItem itemWithTitle:@"Github" accessoryType:UITableViewCellAccessoryDisclosureIndicator action:^(id parameter) {
        
        [self openUrl:@"https://github.com/shlyren"];
        
    }];
    
    ONEDefaultCellItem *item3 = [ONEDefaultCellItem itemWithTitle:@"Twitter" accessoryType:UITableViewCellAccessoryDisclosureIndicator action:^(id parameter) {
        
        [self openUrl:@"https://twitter.com/shlyren"];
        
    }];
    
    ONEDefaultCellItem *item4 = [ONEDefaultCellItem itemWithTitle:@"Facebook" accessoryType:UITableViewCellAccessoryDisclosureIndicator action:^(id parameter) {
        
        [self openUrl:@"https://facebook.com/goodlinessL"];
        
    }];
    
    ONEDefaultCellGroupItem *item = [ONEDefaultCellGroupItem groupWithItems:@[item1, item2, item3, item4]];
    item.headerTitle = @"Social";
    [self.settingItems addObject:item];
}

- (void)setupGroup4
{
    ONEDefaultCellItem *item1 = [ONEDefaultCellItem itemWithTitle:@"E-mail" accessoryType:UITableViewCellAccessoryNone action:^(id parameter) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto://mail@yuxiang.ren"]];
    }];
    [self.settingItems addObject:[ONEDefaultCellGroupItem groupWithItems:@[item1]]];
}

- (void)openUrl:(NSString *)urlStr
{
    [self.navigationController pushViewController:[ONEWebViewController webViewControllerWithUrl:urlStr] animated:true];
}

@end
