//
//  ONEMusicDetailView.h
//  ONE
//
//  Created by 任玉祥 on 16/4/2.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ONEMusicDetailItem;
@class ONEMusicDetailView;

@protocol ONEMusicDetailViewDelegate<NSObject>

@optional
/**
 *  点击播放时调用此方法
 *
 *  @param musicDetailView musicDetailView
 *  @param button          播放或暂停按钮
 */
- (void)musicDetailViwe:(ONEMusicDetailView *)musicDetailView didClickPlayerBtn:(UIButton *)button;

@end

@interface ONEMusicDetailView : UIView

/** 模型 */
@property (nonatomic, strong) ONEMusicDetailItem           *musicDetailItem;

/** 记录行高的block */
@property (nonatomic, strong) void (^contentChangeBlock)(CGFloat height);

/** 代理 */
@property (nonatomic, weak) id<ONEMusicDetailViewDelegate> delegate;
@end
