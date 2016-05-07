//
//  ONEDefaultCellItem.m
//  ONE
//
//  Created by 任玉祥 on 16/4/7.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEDefaultCellItem.h"

@implementation ONEDefaultCellItem

+ (instancetype)itemWithTitle:(NSString *)title
{
    return [self itemWithTitle:title image:nil subTitle:nil actionBlock:nil];
}
+ (instancetype)itemWithTitle:(NSString *)title action:(ONECellActionBlock)actionBlock
{
    return [self itemWithTitle:title image:nil subTitle:nil actionBlock:actionBlock];
}

+ (instancetype)itemWithTitle:(NSString *)title image:(NSString *)image
{
    return [self itemWithTitle:title image:image subTitle:nil actionBlock:nil];
}

+ (instancetype)itemWithTitle:(NSString *)title image:(NSString *)image subTitle:(NSString *)subTitle
{
    return [self itemWithTitle:title image:image subTitle:subTitle actionBlock:nil];
}

+ (instancetype)itemWithTitle:(NSString *)title image:(NSString *)image subTitle:(NSString *)subTitle actionBlock:(ONECellActionBlock)actionBlock
{
    ONEDefaultCellItem *item = [self new];
    item.title = title;
    item.subTitle = subTitle;
    item.image = image;
    item.actionBlock = actionBlock;
    return item;
}
@end
