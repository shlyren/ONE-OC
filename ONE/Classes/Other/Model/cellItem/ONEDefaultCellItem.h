//
//  ONEDefaultCellItem.h
//  ONE
//
//  Created by 任玉祥 on 16/4/7.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ONECellActionBlock)(id parameter);

@interface ONEDefaultCellItem : NSObject

/** title */
@property (nonatomic, strong) NSString *title;

/** 图片 */
@property (nonatomic, strong) NSString *image;

/** subTitle */
@property (nonatomic, strong) NSString *subTitle;

/** action */
@property (nonatomic, strong) ONECellActionBlock actionBlock;

@property (nonatomic, assign) UITableViewCellStyle cellStyle;

@property (nonatomic, assign) UITableViewCellAccessoryType accessoryType;

@property (nonatomic, strong) UIView *accessoryView;

+ (instancetype)itemWithTitle:(NSString *)title;
+ (instancetype)itemWithTitle:(NSString *)title action:(ONECellActionBlock)actionBlock;

+ (instancetype)itemWithTitle:(NSString *)title image:(NSString *)image;

+ (instancetype)itemWithTitle:(NSString *)title image:(NSString *)image subTitle:(NSString *)subTitle;

+ (instancetype)itemWithTitle:(NSString *)title image:(NSString *)image subTitle:(NSString *)subTitle actionBlock:(ONECellActionBlock)actionBlock;
@end
