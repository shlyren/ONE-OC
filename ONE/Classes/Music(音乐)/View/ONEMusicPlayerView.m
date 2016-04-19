//
//  ONEMusicPlayerView.m
//  ONE
//
//  Created by 任玉祥 on 16/4/8.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEMusicPlayerView.h"

@implementation ONEMusicPlayerView
- (instancetype)init
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}

@end
