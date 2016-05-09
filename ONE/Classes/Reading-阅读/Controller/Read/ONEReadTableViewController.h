//
//  ONEReadTableViewController.h
//  ONE
//
//  Created by 任玉祥 on 16/4/14.
//  Copyright © 2016年 任玉祥. All rights reserved.
//


#import "ONEReadCell.h"

UIKIT_EXTERN NSString *const readCell;

@interface ONEReadTableViewController : UITableViewController

@property (nonatomic, strong) ONEReadListItem *readList;
/**
 *  阅读的模型数组
 */
- (NSArray *)readItems;
/**
 *  往期作品的截止时间
 */
- (NSString *)endDate;
/**
 *  阅读的类型
 */
- (NSString *)readType;

@end

