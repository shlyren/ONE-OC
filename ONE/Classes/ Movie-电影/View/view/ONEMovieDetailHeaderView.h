//
//  ONEMovieDetailHeaderView.h
//  ONE
//
//  Created by 任玉祥 on 16/4/11.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ONEMovieDetailHeaderView;

@protocol ONEMovieDetailHeaderViewDelegate <NSObject>

@optional
/** 电影故事内容更新时调用 */
- (void)movieDetailHeaderView:(ONEMovieDetailHeaderView *)movieDetailHeaderView didChangedStoryContent:(CGFloat)height;
/** 点击全部按钮(全部电影&全部短评)调用 */
- (void)movieDetailHeaderView:(ONEMovieDetailHeaderView *)movieDetailHeaderView didClickAllBtn:(NSString *)title;

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
