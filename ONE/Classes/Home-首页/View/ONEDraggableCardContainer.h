//
//  ONEDraggableCardContainer.h
//  ONE
//
//  Created by 任玉祥 on 16/4/1.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ONEDraggableCardContainer;

typedef NS_OPTIONS(NSInteger, ONEDraggableDirection) {
    ONEDraggableDirectionDefault     = 0,
    ONEDraggableDirectionLeft        = 1 << 0,
    ONEDraggableDirectionRight       = 1 << 1,
    ONEDraggableDirectionUp          = 1 << 2,
    ONEDraggableDirectionDown        = 1 << 3
};


@protocol ONEDraggableCardContainerDataSource <NSObject>

- (UIView *)cardContainerViewNextViewWithIndex:(NSInteger)index;

- (NSInteger)cardContainerViewNumberOfViewInIndex:(NSInteger)index;

@end

@protocol ONEDraggableCardContainerDelegate <NSObject>

- (void)cardContainerView:(ONEDraggableCardContainer *)cardContainerView
    didEndDraggingAtIndex:(NSInteger)index
             draggableView:(UIView *)draggableView
        draggableDirection:(ONEDraggableDirection)draggableDirection;

@optional
// ..
- (void)cardContainerView:(ONEDraggableCardContainer *)cardContainerView
     didShowDraggableViewAtIndex:(NSInteger)index;

- (void)cardContainerViewDidCompleteAll:(ONEDraggableCardContainer *)container;

- (void)cardContainerView:(ONEDraggableCardContainer *)cardContainerView
         didSelectAtIndex:(NSInteger)index
             draggableView:(UIView *)draggableView;

- (void)cardContainderView:(ONEDraggableCardContainer *)cardContainderView updatePositionWithDraggableView:(UIView *)draggableView draggableDirection:(ONEDraggableDirection)draggableDirection widthRatio:(CGFloat)widthRatio heightRatio:(CGFloat)heightRatio;

@end

@interface ONEDraggableCardContainer : UIView

/**
 *  default is ONEDraggableDirectionLeft | ONEDraggableDirectionRight
 */
@property (nonatomic, assign) ONEDraggableDirection canDraggableDirection;
@property (nonatomic, weak) id <ONEDraggableCardContainerDataSource> dataSource;
@property (nonatomic, weak) id <ONEDraggableCardContainerDelegate> delegate;

/**
 *  reloads everything from scratch. redisplaONE card.
 */
- (void)reloadCardContainer;

- (void)movePositionWithDirection:(ONEDraggableDirection)direction isAutomatic:(BOOL)isAutomatic;
- (void)movePositionWithDirection:(ONEDraggableDirection)direction isAutomatic:(BOOL)isAutomatic undoHandler:(void (^)())undoHandler;

- (UIView *)getCurrentView;


@end
