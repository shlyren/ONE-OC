//
//  ONEMeSettingViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/5/7.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEMeSettingViewController.h"
#import "ONELoginViewController.h"
#import "ONEFileManager.h"
#import "SVProgressHUD.h"
#import "ONESwitch.h"
#import "ONENightModeTool.h"
#import "ONEAboutViewController.h"

@interface ONEMeSettingViewController ()<UINavigationControllerDelegate>

@end

@implementation ONEMeSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self setupGroups];
}


- (void)setupGroups
{
    [self setupGroup1];
    [self setupGroup2];
    [self setupGroup3];
}

- (void)setupGroup1
{
     ONEDefaultCellItem *item1 = [ONEDefaultCellItem itemWithTitle:@"登录ONE" action:^(id parameter) {
         ONENavigationController *nav = [[ONENavigationController alloc] initWithRootViewController:[ONELoginViewController new]];
         nav.delegate = self;
         [self presentViewController:nav animated:true completion:nil];
     }];
    
    item1.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.settingItems addObject:[ONEDefaultCellGroupItem groupWithItems:@[item1]]];
}

- (void)setupGroup2
{

    ONEDefaultCellItem *item0 = [ONEDefaultCellItem itemWithTitle:@"夜间模式"];
    ONESwitch *nightSwitch = [ONESwitch new];
    [nightSwitch setOn:[[NSUserDefaults standardUserDefaults] boolForKey: ONENightModelKey] animated:true];
    [nightSwitch addTarget:self action:@selector(nightSwitchChanged:) forControlEvents:UIControlEventValueChanged];
    item0.accessoryView = nightSwitch;
    
    ONEDefaultCellItem *item1 = [ONEDefaultCellItem itemWithTitle:@"缓存到本地"];
    ONESwitch *autoCacheSwitch = [ONESwitch new];
    [autoCacheSwitch setOn:[[NSUserDefaults standardUserDefaults] boolForKey: ONEAutomaticCacheKey] animated:true];
    [autoCacheSwitch addTarget:self action:@selector(autoCacheSwitchChanged:) forControlEvents:UIControlEventValueChanged];
    item1.accessoryView = autoCacheSwitch;
    
    ONEDefaultCellItem *item2 = [ONEDefaultCellItem itemWithTitle:[ONEFileManager getDirectorySizeByMBAtCaches] action:^(NSIndexPath *indexPath) {
        
        [self showAlertControllerHandler:^(UIAlertAction * _Nonnull action) {
            [SVProgressHUD showWithStatus:@"清除中..."];
            if ([ONEFileManager removeDirectoryAtCaches]) {
                [SVProgressHUD showSuccessWithStatus:@"清除成功"];
                ONEDefaultCellItem *item = self.settingItems[indexPath.section].items[indexPath.row];
                item.title = [ONEFileManager getDirectorySizeByMBAtCaches];
                [self.tableView reloadData];
            }else {
                [SVProgressHUD showErrorWithStatus:@"清除失败"];
            }
        }];
    
    }];
    item2.accessoryType = UITableViewCellAccessoryNone;
    
    [self.settingItems addObject:[ONEDefaultCellGroupItem groupWithItems:@[item0,item1, item2]]];
}

- (void)setupGroup3
{
    ONEDefaultCellArrItem *item1 = [ONEDefaultCellArrItem itemWithTitle:@"关于" accessoryType:UITableViewCellAccessoryDisclosureIndicator action:nil];
    item1.pushClass = [ONEAboutViewController class];
    
    [self.settingItems addObject:[ONEDefaultCellGroupItem groupWithItems:@[item1]]];

}

- (void)nightSwitchChanged:(ONESwitch *)nightSwitch
{
    
    [ONENightModeTool setNightMode:nightSwitch.isOn];
    [[NSUserDefaults standardUserDefaults] setBool:nightSwitch.isOn forKey: ONENightModelKey];

}

- (void)autoCacheSwitchChanged:(UISwitch *)autoCacheSwitch
{
    [[NSUserDefaults standardUserDefaults] setBool:autoCacheSwitch.isOn forKey: ONEAutomaticCacheKey];
}


- (void)showAlertControllerHandler:(void(^)(UIAlertAction *action))action;
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"真的要清除缓存么?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"清除" style:UIAlertActionStyleDestructive handler:action];
    
    [alertController addAction:action1];
    [alertController addAction:action2];
    [self presentViewController:alertController animated:true completion:nil];
    
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [navigationController setNavigationBarHidden:[viewController isKindOfClass:[ONELoginViewController class]] animated:true];
}

@end
