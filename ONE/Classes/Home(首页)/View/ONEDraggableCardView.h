//
//  ONEDraggableCardView.h
//  ONE
//
//  Created by 任玉祥 on 16/4/17.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface YSLCardView : UIView

/**
 *  Override
 */
- (void)setupCardView;

@end

@class ONEHomeSubtotalItem;
@interface ONEDraggableCardView : YSLCardView

@property (nonatomic, strong) ONEHomeSubtotalItem *subtotalItem;

@end
