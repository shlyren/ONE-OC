//
//  ONEPersonDetailTableView.h
//  ONE
//
//  Created by 任玉祥 on 16/4/7.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ONEPersonDetailTableView;
@protocol ONEPersonDetailTableViewDelegate <NSObject>

@optional
/**
 *  点击小记时调用此方法
 *
 *  @param detailTableView detailTableView
 *  @param subtotalBtn     subtotalBtn
 */
- (void)personDetailTableView:(ONEPersonDetailTableView *)detailTableView didChilckSubtotalBtn:(UIButton *)subtotalBtn;

/**
 *  点击歌单时调用此方法
 *
 *  @param detailTableView detailTableView
 *  @param subtotalBtn     songlistBtn
 */
- (void)personDetailTableView:(ONEPersonDetailTableView *)detailTableView didChilckSonglistBtn:(UIButton *)songlistBtn;

@end

@interface ONEPersonDetailTableView : UITableView

/** 详情的view */
@property (nonatomic, weak) UIView *detailView;

/** ONEPersonDetailTableViewDelegate */
@property (nonatomic, weak) id<ONEPersonDetailTableViewDelegate> delegate_person;

@end
