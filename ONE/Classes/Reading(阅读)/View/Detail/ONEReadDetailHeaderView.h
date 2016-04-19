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

@class ONEReadDetailHeaderView;

@protocol ONEReadDetailHeaderViewDelegate <NSObject>

@optional
- (void)readDetailHeaderView:(ONEReadDetailHeaderView *)detailHeaderView didChangedHeight:(CGFloat)height;

@end

@interface ONEReadDetailHeaderView : UIView

@property (nonatomic, strong) ONEEssayItem                       *essayItem;
@property (nonatomic, strong) ONESerialItem                      *serialItem;

@property (nonatomic, weak) id <ONEReadDetailHeaderViewDelegate> delegate;

+ (instancetype)detailHeaderView;
+ (instancetype)commentSectionHeader;
+ (instancetype)relatedSectionHeader;

@end
