//
//  ONEPracticalToolViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/5/28.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEPracticalToolViewController.h"
#import "ONEFPSLabel.h"

@interface ONEPracticalToolViewController ()

@end

@implementation ONEPracticalToolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"实用工具";
    [self setupGroups];
}

- (void)setupGroups
{
    ONEDefaultCellItem *item1 = [ONEDefaultCellItem itemWithTitle:@"显示FPS"];
    ONESwitch *fpsSwitch = [ONESwitch new];
    [fpsSwitch setOn:[[NSUserDefaults standardUserDefaults] boolForKey:ONEFPSLabelKey] animated:true];
    [fpsSwitch addTarget:self action:@selector(fpsSwitchValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    item1.accessoryView = fpsSwitch;

    [self.settingItems addObject:[ONEDefaultCellGroupItem groupWithItems:@[item1]]];
}

- (void)fpsSwitchValueChanged:(ONESwitch *)fpsSwitch
{
    [fpsSwitch setOn:fpsSwitch.isOn animated:true];
    [[NSUserDefaults standardUserDefaults] setBool:fpsSwitch.isOn forKey:ONEFPSLabelKey];
    [ONEFPSLabel setupFPSLabel];
}


@end
