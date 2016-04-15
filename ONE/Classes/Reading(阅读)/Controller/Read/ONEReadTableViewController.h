//
//  ONEReadTableViewController.h
//  ONE
//
//  Created by 任玉祥 on 16/4/14.
//  Copyright © 2016年 ONE. All rights reserved.
//


#import "ONEReadCell.h"

UIKIT_EXTERN NSString *const readCell;

@interface ONEReadTableViewController : UITableViewController

@property (nonatomic, strong) ONEReadListItem *readList;

- (NSArray *)readItems;

@end

