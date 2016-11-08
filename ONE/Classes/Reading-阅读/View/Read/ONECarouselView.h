//
//  ONECarouselView.h
//  ONE
//
//  Created by 任玉祥 on 16/4/14.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ONECarouselView;

@protocol ONECarouselViewDelegate <NSObject>

@optional

/*
    点击轮播item时调用
 */
- (void)carouselView:(ONECarouselView *)carouselView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface ONECarouselView : UIView
/** 图片的数组 可以是url地址或者UIImage对象  */
@property (nonatomic, strong) NSArray                   *imageNames;
/** 代理 */
@property (nonatomic, weak) id<ONECarouselViewDelegate> delegate;
/** 翻页的时间 默认2.0s */
@property (nonatomic, assign) NSTimeInterval            intervalTime;

@end
