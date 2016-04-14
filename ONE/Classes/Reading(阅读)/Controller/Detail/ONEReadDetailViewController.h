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

@interface ONEReadDetailViewController : UITableViewController

@property (nonatomic, strong) NSString *detail_id;
@property (nonatomic, weak) ONEReadDetailHeaderView *headerView;


- (void)loadDetailData;
@end
