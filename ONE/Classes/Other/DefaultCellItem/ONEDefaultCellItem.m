//
//  ONEDefaultCellItem.m
//  ONE
//
//  Created by 任玉祥 on 16/4/7.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import "ONEDefaultCellItem.h"

@implementation ONEDefaultCellItem

+ (instancetype)itemWithTitle:(NSString *)title image:(NSString *)image
{
    ONEDefaultCellItem *item = [self new];
    item.title = title;
    item.image = image;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title image:(NSString *)image subTitle:(NSString *)subTitle
{
    ONEDefaultCellItem *item = [self itemWithTitle:title image:image];
    item.subTitle = subTitle;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title image:(NSString *)image subTitle:(NSString *)subTitle actionBlock:(void (^)(id parameter))actionBlock
{
    ONEDefaultCellItem *item = [self itemWithTitle:title image:image subTitle:subTitle];
    item.actionBlock = actionBlock;
    return item;
}
@end
