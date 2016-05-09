//
//  ONEReadToolBarView.h
//  ONE
//
//  Created by 任玉祥 on 16/4/14.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ONEReadToolBarView : UIView

/**
 *  类型 essay serial question
 */
@property (nonatomic, strong) NSString *typeStr;
/**
 *  id
 */
@property (nonatomic, strong) NSString *content_id;

/**
 *  快速构造方法
 */
+ (instancetype)toolBarView;

/**
 *  设置按钮的标题
 */
- (void)setPraiseTitle:(NSString *)praiseTitle commentTitle:(NSString *)commentTitle shareTitle:(NSString *)shareTitle;

@end
