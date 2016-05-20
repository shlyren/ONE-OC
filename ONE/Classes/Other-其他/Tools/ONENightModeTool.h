//
//  ONENightModeTool.h
//  ONE
//
//  Created by 任玉祥 on 16/5/13.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ONENightModeTool : UIView

/**
 *  初始化夜间模式
 */
+ (void)setupNightMode;
/**
 *  开启夜间模式
 */
+ (void)openNightMode;
/**
 *  关闭夜间模式
 */
+ (void)closeNightMode;
/**
 *  设置夜间模式
 */
+ (void)setNightMode:(BOOL)open;
@end
