//
//  ONEBaseSettingViewController.h
//  ONE
//
//  Created by 任玉祥 on 16/5/20.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ONEDefaultCellGroupItem.h"
#import "ONESwitch.h"
#import "ONENavigationController.h"

@interface ONEBaseSettingViewController : UITableViewController
/** 组的模型 */
@property (nonatomic, strong) NSMutableArray<ONEDefaultCellGroupItem *> *settingItems;

- (UITableViewStyle)tableViewStyle;
@end
