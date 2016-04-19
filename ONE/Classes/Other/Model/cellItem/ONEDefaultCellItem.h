//
//  ONEDefaultCellItem.h
//  ONE
//
//  Created by 任玉祥 on 16/4/7.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ONEDefaultCellItem : NSObject

/** title */
@property (nonatomic, strong) NSString *title;

/** 图片 */
@property (nonatomic, strong) NSString *image;

/** subTitle */
@property (nonatomic, strong) NSString *subTitle;


/** action */
@property (nonatomic, strong) void (^actionBlock)(id parameter);



+ (instancetype)itemWithTitle:(NSString *)title image:(NSString *)image;

+ (instancetype)itemWithTitle:(NSString *)title image:(NSString *)image subTitle:(NSString *)subTitle;

+ (instancetype)itemWithTitle:(NSString *)title image:(NSString *)image subTitle:(NSString *)subTitle actionBlock:(void (^)(id parameter))actionBlock;
@end
