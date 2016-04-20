//
//  ONEReadDetailHeaderView.h
//  ONE
//
//  Created by 任玉祥 on 16/4/14.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ONEEssayItem;
@class ONESerialItem;

@interface ONEReadDetailHeaderView : UIView

@property (nonatomic, strong) ONEEssayItem                       *essayItem;
@property (nonatomic, strong) ONESerialItem                      *serialItem;

@property (nonatomic, strong) void (^contentChangeBlock)(CGFloat height);
@property (nonatomic, strong) void (^clickListBtnBlock) (NSString *content_id);

+ (instancetype)detailHeaderView;
+ (instancetype)commentSectionHeader;
+ (instancetype)relatedSectionHeader;

@end
