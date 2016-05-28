//
//  ONEDefaultCellGroupItem.m
//  ONE
//
//  Created by 任玉祥 on 16/4/7.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEDefaultCellGroupItem.h"

@implementation ONEDefaultCellGroupItem

+ (instancetype)groupWithItems:(NSArray *)items
{
    ONEDefaultCellGroupItem *group = [ONEDefaultCellGroupItem new];
    group.items = items;
    return group;
}

@end
