//
//  ONENightModeTool.m
//  ONE
//
//  Created by 任玉祥 on 16/5/13.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONENightModeTool.h"

@interface ONENightModeTool ()
@property (nonatomic, strong) UIView *nightModelView;
@end

@implementation ONENightModeTool
+ (instancetype)shareInstance
{
    return [self new];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static ONENightModeTool *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    
    return _instance;
}
#pragma mark - lazy load
- (UIView *)nightModelView
{
    if (_nightModelView == nil) {
        UIView *nightModelView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        nightModelView.alpha = 0;
        nightModelView.backgroundColor = [UIColor blackColor];
        nightModelView.userInteractionEnabled = false;
        _nightModelView = nightModelView;
    }
    
    return _nightModelView;
}

#pragma mark - 公共方法
+ (void)setupNightMode
{
    [self setNightMode:[[NSUserDefaults standardUserDefaults] boolForKey: ONENightModelKey]];
}

+ (void)setNightMode:(BOOL)open
{
    if (open) {
        [self openNightMode];
    }else {
        [self closeNightMode];
    }
}

+ (void)openNightMode
{
    [[self shareInstance] openNightMode];
}

+ (void)closeNightMode
{
    [[self shareInstance] closeNightMode];
}


#pragma mark - 私有方法
- (void)openNightMode
{
    [[UIApplication sharedApplication].keyWindow addSubview:self.nightModelView];
    [UIView animateWithDuration:1 animations:^{
        self.nightModelView.alpha = 0.5;
    }];
}


- (void)closeNightMode
{
    [UIView animateWithDuration:1 animations:^{
        self.nightModelView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.nightModelView removeFromSuperview];
    }];
    
}

@end
