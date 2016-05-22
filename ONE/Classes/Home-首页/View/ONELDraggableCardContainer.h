//
//  ONELDraggableCardContainer.h
//  ONE
//
//  Created by 任玉祥 on 16/4/1.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ONELDraggableCardContainer;

typedef NS_OPTIONS(NSInteger, ONELDraggableDirection) {
    ONELDraggableDirectionDefault     = 0,
    ONELDraggableDirectionLeft        = 1 << 0,
    ONELDraggableDirectionRight       = 1 << 1,
    ONELDraggableDirectionUp          = 1 << 2,
    ONELDraggableDirectionDown        = 1 << 3
};


@protocol ONELDraggableCardContainerDataSource <NSObject>

- (UIView *)cardContainerViewNextViewWithIndex:(NSInteger)index;

- (NSInteger)cardContainerViewNumberOfViewInIndex:(NSInteger)index;

@end

@protocol ONELDraggableCardContainerDelegate <NSObject>

- (void)cardContainerView:(ONELDraggableCardContainer *)cardContainerView
    didEndDraggingAtIndex:(NSInteger)index
             draggableView:(UIView *)draggableView
        draggableDirection:(ONELDraggableDirection)draggableDirection;

@optional
// ..
- (void)cardContainerView:(ONELDraggableCardContainer *)cardContainerView
     didShowDraggableViewAtIndex:(NSInteger)index;

- (void)cardContainerViewDidCompleteAll:(ONELDraggableCardContainer *)container;

- (void)cardContainerView:(ONELDraggableCardContainer *)cardContainerView
         didSelectAtIndex:(NSInteger)index
             draggableView:(UIView *)draggableView;

- (void)cardContainderView:(ONELDraggableCardContainer *)cardContainderView updatePositionWithDraggableView:(UIView *)draggableView draggableDirection:(ONELDraggableDirection)draggableDirection widthRatio:(CGFloat)widthRatio heightRatio:(CGFloat)heightRatio;

@end

@interface ONELDraggableCardContainer : UIView

/**
 *  default is ONELDraggableDirectionLeft | ONELDraggableDirectionRight
 */
@property (nonatomic, assign) ONELDraggableDirection canDraggableDirection;
@property (nonatomic, weak) id <ONELDraggableCardContainerDataSource> dataSource;
@property (nonatomic, weak) id <ONELDraggableCardContainerDelegate> delegate;

/**
 *  reloads everything from scratch. redisplaONE card.
 */
- (void)reloadCardContainer;

- (void)movePositionWithDirection:(ONELDraggableDirection)direction isAutomatic:(BOOL)isAutomatic;
- (void)movePositionWithDirection:(ONELDraggableDirection)direction isAutomatic:(BOOL)isAutomatic undoHandler:(void (^)())undoHandler;

- (UIView *)getCurrentView;


@end
