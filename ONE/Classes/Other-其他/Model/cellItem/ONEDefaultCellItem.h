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

/** cell的类型 */
@property (nonatomic, assign) UITableViewCellStyle cellStyle;

/** cell附属物类型 */
@property (nonatomic, assign) UITableViewCellAccessoryType accessoryType;

/** cell附属物View */
@property (nonatomic, strong) UIView *accessoryView;


+ (instancetype)itemWithTitle:(NSString *)title
                        image:(NSString *)image
                     subTitle:(NSString *)subTitle
                    cellStyle:(UITableViewCellStyle)cellStyle
                accessoryType:(UITableViewCellAccessoryType)accessoryType
                accessoryView:(UIView*)accessoryView
                       action:(ONECellActionBlock)actionBlock;

+ (instancetype)itemWithTitle:(NSString *)title;

+ (instancetype)itemWithTitle:(NSString *)title
                        image:(NSString *)image;

+ (instancetype)itemWithTitle:(NSString *)title
                       action:(ONECellActionBlock)actionBlock;

+ (instancetype)itemWithTitle:(NSString *)title
                        image:(NSString *)image
                     subTitle:(NSString *)subTitle;

+ (instancetype)itemWithTitle:(NSString *)title
                        image:(NSString *)image
                     subTitle:(NSString *)subTitle
                       action:(ONECellActionBlock)actionBlock;
@end
