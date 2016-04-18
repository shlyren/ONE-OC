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

/** 就是阅读的类型 essay serial question */
@property (nonatomic, strong, readonly) NSString *commentType;

/** 详情数据 */
- (void)loadDetailData;
/** 推荐数据 */
- (void)loadRelatedData;
@end
