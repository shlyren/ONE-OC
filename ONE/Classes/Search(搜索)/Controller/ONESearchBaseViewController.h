//
//  ONESearchBaseViewController.h
//  ONE
//
//  Created by 任玉祥 on 16/4/18.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ONEDataRequest.h"
#import "ONESearchTableViewCell.h"

@interface ONESearchBaseViewController : UITableViewController


/** 搜索的内容 */
@property (nonatomic, strong) NSString *searchKey;

@property (nonatomic, strong) NSArray *searchResult;


@end
