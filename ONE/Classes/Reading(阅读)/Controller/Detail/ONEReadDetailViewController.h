//
//  ONEReadDetailViewController.h
//  ONE
//
//  Created by 任玉祥 on 16/4/14.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ONEReadDetailHeaderView.h"
#import "ONEDataRequest.h"

#import "ONEReadRelatedCell.h"


@interface ONEReadDetailViewController : UITableViewController
UIKIT_EXTERN NSString *const relatedCell;
/** id */
@property (nonatomic, strong) NSString *detail_id;
@property (nonatomic, weak) ONEReadDetailHeaderView *headerView;

@property (nonatomic, strong) NSArray *relatedItems;

/** 详情数据 */
- (void)loadDetailData;
/** 推荐数据 */
- (void)loadRelatedData;
/**
 *  获取不容类型的评论url
 *
 *  @return 评论类型的url 比如 短篇 "praiseandtime/essay"
 */
- (NSString *)commentUrl;

@end
