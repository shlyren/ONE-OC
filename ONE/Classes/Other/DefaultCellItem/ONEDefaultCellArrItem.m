//
//  ONEDefaultCellArrItem.m
//  ONE
//
//  Created by 任玉祥 on 16/4/7.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import "ONEDefaultCellArrItem.h"

@implementation ONEDefaultCellArrItem
+ (instancetype)itemWithTitle:(NSString *)title image:(NSString *)image pushClass:(Class)pushClass
{
    ONEDefaultCellArrItem *item = [self itemWithTitle:title image:image];
    item.pushClass = pushClass;
    return item;
}
@end
