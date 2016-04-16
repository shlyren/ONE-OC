//
//  ONECarouselView.h
//  ONE
//
//  Created by 任玉祥 on 16/4/14.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ONECarouselView;

@protocol ONECarouselViewDelegate <NSObject>

@optional
- (void)carouselView:(ONECarouselView *)carouselView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;


@end

@interface ONECarouselView : UIView
/** 图片名字的数组 */
@property (nonatomic, strong) NSArray<NSString *>       *imageNames;

@property (nonatomic, weak) id<ONECarouselViewDelegate>   delegate;
/** 翻页的时间 默认2.0s */
@property (nonatomic, assign) NSTimeInterval            intervalTime;

@end
