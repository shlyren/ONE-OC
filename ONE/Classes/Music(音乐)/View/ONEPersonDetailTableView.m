//
//  ONEPersonDetailTableView.m
//  ONE
//
//  Created by 任玉祥 on 16/4/7.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import "ONEPersonDetailTableView.h"

@implementation ONEPersonDetailTableView


//- (instancetype)initWithFrame:(CGRect)frame
//{
//    if (self = [super initWithFrame:frame]) {
//        self = [super initWithFrame: [UIScreen mainScreen].bounds];
//    }
//    return self;
//}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint curPoint = [touch locationInView:self];
    
    for (UIView *subView in _detailView.subviews)
    {
        if ([subView isKindOfClass:[UIButton class]]) // 取出所有的按钮
        {
            // 计算 按钮的 点
            CGPoint childPoint = [self convertPoint:curPoint toView:subView];
            
            if ([subView pointInside:childPoint withEvent:event])
            {
                
                 [self respondDelegate:(UIButton *)subView];
                
                // 处理完事件，结束当前事件处理
                return;
            }
        }
    }
    
    // 如果没有处理事件，就调用系统自带的处理方式
    [super touchesEnded:touches withEvent:event];
}



// 处理代理事件
- (void)respondDelegate:(UIButton *)button
{
    switch (button.tag)
    {
        // 小计
        case 1:
        {
            if ([_delegate_person respondsToSelector:@selector(personDetailTableView:didChilckSubtotalBtn:)])
            {
                [_delegate_person personDetailTableView:self didChilckSubtotalBtn:button];
                 break;
            }

        }
        // 歌单
        case 2:
        {
            if ([_delegate_person respondsToSelector:@selector(personDetailTableView:didChilckSonglistBtn:)])
            {
                [_delegate_person personDetailTableView:self didChilckSonglistBtn:button];
                break;
            }
        }
            
        default:
            break;
    }

}


@end
