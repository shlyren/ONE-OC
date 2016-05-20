//
//  ONEBaseSettingViewController.h
//  ONE
//
//  Created by 任玉祥 on 16/5/20.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ONEDefaultCellGroupItem.h"
#import "ONENavigationController.h"

@interface ONEBaseSettingViewController : UITableViewController 
@property (nonatomic, strong) NSMutableArray<ONEDefaultCellGroupItem *> *settingItems;
@end
