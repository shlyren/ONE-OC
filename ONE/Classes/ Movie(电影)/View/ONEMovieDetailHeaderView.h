//
//  ONEMovieDetailHeaderView.h
//  ONE
//
//  Created by 任玉祥 on 16/4/11.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ONEMovieDetailHeaderView;

@protocol ONEMovieDetailHeaderViewDelegate <NSObject>

@required
- (void)movieDetailHeaderView:(ONEMovieDetailHeaderView *)movieDetailHeaderView didChangedStoryContent:(CGFloat)height;

@end

@interface ONEMovieDetailHeaderView : UIView


@property (nonatomic, weak) id<ONEMovieDetailHeaderViewDelegate> delegate;

@property (nonatomic, strong) NSString *movie_id;
@property (nonatomic, assign) NSInteger reviewCount;

/**
 *  tebleView的headerView
 */
+ (instancetype)tableHeaderView;

/**
 *  评审团的组头View
 */

+ (instancetype)reviewSectionHeaderView;

/**
 *  评审团的组尾View
 */
+ (instancetype)reviewSectionFooterView;

/**
 *  评论列表的组头View
 */
+ (instancetype)commentSectionHeaderView;
@end
