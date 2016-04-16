//
//  ONEMusicDetailView.h
//  ONE
//
//  Created by 任玉祥 on 16/4/2.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ONEMusicDetailItem;
@class ONEMusicDetailView;

@protocol ONEMusicDetailViewDelegate<NSObject>

@optional
/**
 *  storyLable文字改变时(点击了故事,歌词,信息按钮)调用此方法
 *
 *  @param musicDetailView musicDetailView
 *  @param height          改变后musicDetailView的高度
 */
- (void)musicDetailView:(ONEMusicDetailView *)musicDetailView didChangedContent:(CGFloat)height;
/**
 *  点击播放时调用此方法
 *
 *  @param musicDetailView musicDetailView
 *  @param button          播放或暂停按钮
 */
- (void)musicDetailViwe:(ONEMusicDetailView *)musicDetailView didClickPlayerBtn:(UIButton *)button;

@end

@interface ONEMusicDetailView : UIView

@property (nonatomic, strong) ONEMusicDetailItem           *musicDetailItem;

@property (nonatomic, weak) id<ONEMusicDetailViewDelegate> delegate;
@end
