//
//  ONEPastListViewController.h
//  ONE
//
//  Created by 任玉祥 on 16/4/10.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ONEPastListViewController : UITableViewController
@property (nonatomic, strong, readonly) NSArray *pastLists;
/** 结束的时间 格式为 yyyy-MM */
@property (nonatomic, strong) NSString *endMonth;

@end
