//
//  ONESearchBaseViewController.h
//  ONE
//
//  Created by 任玉祥 on 16/4/18.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ONESearchTableViewCell.h"


typedef NS_ENUM(NSInteger, ONESearchContentType) {
    ONESearchContentTypeNone,
    ONESearchContentTypeHp,
    ONESearchContentTypeRead,
    ONESearchContentTypeMusic,
    ONESearchContentTypeMovie,
    ONESearchContentTypeAuthor
};

@interface ONESearchBaseViewController : UITableViewController


/** 搜索的内容 */
@property (nonatomic, strong) NSString *searchKey;



- (ONESearchContentType)searchContentType;
- (NSArray *)searchResult;
@end
