//
//  ONEReadDetailViewController.h
//  ONE
//
//  Created by 任玉祥 on 16/4/14.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ONEReadDetailHeaderView.h"
#import "ONEDataRequest.h"
#import "ONEReadRelatedCell.h"
#import "ONEReadToolBarView.h"

@interface ONEReadDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
UIKIT_EXTERN NSString *const relatedCellID;
/** id */
@property (nonatomic, strong) NSString *detail_id;
@property (nonatomic, weak) ONEReadDetailHeaderView *headerView;
@property (nonatomic, weak, readonly) ONEReadToolBarView *toolBarView;

@property (nonatomic, strong) NSArray *relatedItems;


@property (nonatomic, weak) UITableView *tableView;

/** 就是阅读的类型 essay serial question */
- (NSString *)commentType;

/** 详情数据 */
- (void)loadDetailData;
/** 推荐数据 */
- (void)loadRelatedData;
@end
