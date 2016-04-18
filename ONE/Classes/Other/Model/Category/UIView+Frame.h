//
//  UIView+Frame.h
//  
//
//  Created by 任玉祥 on 16/3/7.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGSize  size;
@property (nonatomic, assign) CGPoint origin;

@end
