//
//  ONEMeViewController.m
//  ONE
//
//  Created by 任玉祥 on 2016/11/9.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEMeViewController.h"
#import "UIScrollView+scaleImage.h"
#import "UIImage+image.h"
#import "UIButton+Extension.h"
#import "UIScrollView+MJRefresh.h"
#import "Masonry.h"
#import "ONENightModeTool.h"

@interface ONEMeViewController ()

@end

@implementation ONEMeViewController
- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:UITableViewStylePlain];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.yx_image = [UIImage imageNamed:@"personalBackgroundImage"];
    self.tableView.yx_height = 120;
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem new];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back_white"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    UIButton *iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    iconBtn.normalBgImg = [UIImage imageNamed:@"personal"];
    [iconBtn addTarget:self action:@selector(iconBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:iconBtn];
    
    [iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.centerX.equalTo(self.view);
    }];
   
    UILabel *nameL = [UILabel new];
    nameL.text = @"请登录";
    nameL.textColor = [UIColor whiteColor];
    nameL.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:nameL];
    
    [nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(iconBtn);
        make.top.equalTo(iconBtn.mas_bottom).offset(10);
    }];
    
    [self setupGroup];
    
}

- (void)iconBtnClick
{
    
}

- (void)dismiss
{
    [self.navigationController dismissViewControllerAnimated:true completion:nil];
}

- (void)setupGroup
{
    ONEDefaultCellItem *item0 = [ONEDefaultCellItem itemWithTitle:@"夜间模式"];
    ONESwitch *nightSwitch = [ONESwitch new];
    [nightSwitch setOn:[[NSUserDefaults standardUserDefaults] boolForKey: ONENightModelKey] animated:true];
    [nightSwitch addTarget:self action:@selector(nightSwitchChanged:) forControlEvents:UIControlEventValueChanged];
    item0.accessoryView = nightSwitch;
     [self.settingItems addObject:[ONEDefaultCellGroupItem groupWithItems:@[item0]]];
}
- (void)nightSwitchChanged:(ONESwitch *)nightSwitch
{
    
    [ONENightModeTool setNightMode:nightSwitch.isOn];
    [[NSUserDefaults standardUserDefaults] setBool:nightSwitch.isOn forKey: ONENightModelKey];
    
}

@end
