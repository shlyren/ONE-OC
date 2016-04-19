//
//  ONEDefaultCellArrItem.h
//  ONE
//
//  Created by 任玉祥 on 16/4/7.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEDefaultCellItem.h"

@interface ONEDefaultCellArrItem : ONEDefaultCellItem

@property (nonatomic, assign) Class pushClass;


+ (instancetype)itemWithTitle:(NSString *)title image:(NSString *)image pushClass:(Class)pushClass;
@end
