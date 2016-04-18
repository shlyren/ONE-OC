//
//  ONEMoreSubtotalLayout.h
//  ONE
//
//  Created by 任玉祥 on 16/4/17.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ONEMoreSubtotalLayout;

@protocol ONEMoreSubtotalLayoutDelegate <NSObject>
- (CGFloat)subtotallowLayout:(ONEMoreSubtotalLayout *)subtotallowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath;
@end

@interface ONEMoreSubtotalLayout : UICollectionViewFlowLayout
@property (nonatomic, weak) id<ONEMoreSubtotalLayoutDelegate> delegate;
@end
