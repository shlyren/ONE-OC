//
//  ONEDraggableCardView.h
//  ONE
//
//  Created by 任玉祥 on 16/4/17.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ONEHomeSubtotalItem;

@interface YSLCardView : UIView

/**
 *  Override
 */
- (void)setupCardView;

@end

@interface ONEDraggableCardView : YSLCardView

@property (nonatomic, strong) ONEHomeSubtotalItem *subtotalItem;

@end
