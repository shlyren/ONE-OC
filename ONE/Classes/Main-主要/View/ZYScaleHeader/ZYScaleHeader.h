//
//  ZYScaleHeader.h
//  https://github.com/shlyren/ZYScaleHeader
//
//  Created by JiaQi on 2016/12/6.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYScaleHeader : UIView
@property (nonatomic, strong) UIImage *image;

/**
 创建一个headerview
 默认宽度为屏幕的宽度, 高度为 宽度 * image高度 / image宽度

 @param image image
 @return ZYScaleHeader 对象
 */
+ (instancetype)headerWithImage:(UIImage *)image;

/**
 创建一个自定义高度的headerview

 @param image image
 @param height 如果为0, 高度为 宽度 * image高度 / image宽度
 @return ZYScaleHeader 对象
 */
+ (instancetype)headerWithImage:(UIImage *)image height:(CGFloat)height;
@end

#pragma mark - UIScrollView Category
@interface UIScrollView (ZYScaleHeader)
/**
 设置scrollView的scaleHeader
 这里有一个问题: tableView的时候,如果先设置了tableHeaderView,再设置ZYScaleHeader,
               tableView默认滚动到tableHeaderView所能见到的那个点(ZYScaleHeader是看不到的)
               所以需要在tableHeaderView 之前先设置 ZYScaleHeader
 */
@property (nonatomic, weak) ZYScaleHeader *zy_header;
@end
