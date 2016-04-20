//
//  ONESearchTableViewCell.h
//  ONE
//
//  Created by 任玉祥 on 16/4/18.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ONEHomeSubtotalItem;
@class ONESearchMusicItem;

@interface ONESearchTableViewCell : UITableViewCell
@property (nonatomic, strong) ONEHomeSubtotalItem *item;

@property (nonatomic, strong) ONESearchMusicItem *musicItem;

@end
