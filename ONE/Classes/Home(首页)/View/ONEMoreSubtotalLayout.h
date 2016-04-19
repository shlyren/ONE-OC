//
//  ONEMoreSubtotalLayout.h
//  ONE
//
//  Created by 任玉祥 on 16/4/17.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ONEMoreSubtotalLayout;

@protocol ONEMoreSubtotalLayoutDelegate <NSObject>

/**
 *  每个item的高度
 *
 *  @param subtotallowLayout 布局参数
 *  @param width             item的宽度
 *  @param indexPath         item的索引
 *
 *  @return Item的高度
 */
@required
- (CGFloat)subtotallowLayout:(ONEMoreSubtotalLayout *)subtotallowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath;
@end

@interface ONEMoreSubtotalLayout : UICollectionViewFlowLayout
@property (nonatomic, weak) id<ONEMoreSubtotalLayoutDelegate> delegate;
@end
