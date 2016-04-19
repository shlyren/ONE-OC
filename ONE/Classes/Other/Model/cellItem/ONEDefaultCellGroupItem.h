//
//  ONEDefaultCellGroupItem.h
//  ONE
//
//  Created by 任玉祥 on 16/4/7.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ONEDefaultCellGroupItem : NSObject

/** 头标题 */
@property (nonatomic, strong) NSString *headerTitle;

/** 尾标题 */
@property (nonatomic, strong) NSString *footerTitle;

/** 头部高度 */
@property (nonatomic, assign) CGFloat headerHeight;

/** 尾部高度 */
@property (nonatomic, assign) CGFloat footerHeight;

/** headerView */
@property (nonatomic, strong) UIView *headerView;
/** footerView */
@property (nonatomic, strong) UIView *footerView;

/** 行的模型 */
@property (nonatomic, strong) NSArray *items;

+ (instancetype)groupWithItems:(NSArray *)items;

@end
