//
//  ONEDefaultCellGroupItem.h
//  ONE
//
//  Created by 任玉祥 on 16/4/7.
//  Copyright © 2016年 ONE. All rights reserved.
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

@property (nonatomic, strong) NSArray *items;

+ (instancetype)groupWithItems:(NSArray *)items;

@end
