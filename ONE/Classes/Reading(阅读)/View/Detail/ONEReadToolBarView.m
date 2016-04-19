//
//  ONEReadToolBarView.m
//  ONE
//
//  Created by 任玉祥 on 16/4/14.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEReadToolBarView.h"

@implementation ONEReadToolBarView

+ (instancetype)toolBarView
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
}

@end
