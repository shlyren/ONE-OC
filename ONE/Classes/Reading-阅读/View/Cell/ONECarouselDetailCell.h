//
//  ONECarouselDetailCell.h
//  ONE
//
//  Created by 任玉祥 on 16/4/16.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ONECarouselDetailItem;
@interface ONECarouselDetailCell : UITableViewCell
@property (nonatomic, strong) ONECarouselDetailItem *carouselDetailItem;

@property (nonatomic, assign) CGFloat rowHeight;
@end
