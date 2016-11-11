//
//  UIButton+Extension.m
//  YXCategoriesDemo
//
//  Created by 任玉祥 on 2016/11/3.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)
#pragma mark - title
- (void)setNormalTitle:(NSString *)title
{
    [self setTitle:title forState:UIControlStateNormal];
}
- (NSString *)normalTitle
{
    return [self titleForState:UIControlStateNormal];
}
- (void)setHighlightedTitle:(NSString *)title
{
    [self setTitle:title forState:UIControlStateHighlighted];
}
- (NSString *)highlightedTitle
{
    return [self titleForState:UIControlStateHighlighted];
}
- (void)setSelectedTitle:(NSString *)title
{
    [self setTitle:title forState:UIControlStateSelected];
}
- (NSString *)selectedTitle
{
    return [self titleForState:UIControlStateSelected];
}
- (void)setDisabledTitle:(NSString *)title
{
    [self setTitle:title forState:UIControlStateDisabled];
}
- (NSString *)disabledTitle
{
    return [self titleForState:UIControlStateDisabled];
}

#pragma mark - titlecolor
- (void)setNormalTitleColor:(UIColor *)color
{
    [self setTitleColor:color forState:UIControlStateNormal];
}
- (UIColor *)normalTitleColor
{
    return [self titleColorForState:UIControlStateNormal];
}
- (void)setHighlightedTitleColor:(UIColor *)color
{
    [self setTitleColor:color forState:UIControlStateHighlighted];
}
- (UIColor *)highlightedTitleColor
{
    return [self titleColorForState:UIControlStateHighlighted];
}
- (void)setSelectedTitleColor:(UIColor *)color
{
    [self setTitleColor:color forState:UIControlStateSelected];
}
- (UIColor *)selectedTitleColor
{
    return [self titleColorForState:UIControlStateSelected];
}
- (void)setDisabledTitleColor:(UIColor *)color
{
    [self setTitleColor:color forState:UIControlStateDisabled];
}
- (UIColor *)disabledTitleColor
{
    return [self titleColorForState:UIControlStateDisabled];
}

#pragma mark - image
- (void)setNormalImg:(UIImage *)imgN
{
    [self setImage:imgN forState:UIControlStateNormal];
}
- (UIImage *)normalImg
{
    return [self imageForState:UIControlStateNormal];
}
- (void)setHighlightedImg:(UIImage *)imgN
{
    [self setImage:imgN forState:UIControlStateHighlighted];
}
- (UIImage *)highlightedImg
{
    return [self imageForState:UIControlStateHighlighted];
}
- (void)setSelectedImg:(UIImage *)imgN
{
    [self setImage:imgN forState:UIControlStateSelected];
}
- (UIImage *)selectedImg
{
    return [self imageForState:UIControlStateSelected];
}
- (void)setDisabledImg:(UIImage *)imgN
{
    [self setImage:imgN forState:UIControlStateDisabled];
}
- (UIImage *)disabledImg
{
    return [self imageForState:UIControlStateDisabled];
}
#pragma mark - backgroundImg
- (void)setNormalBgImg:(UIImage *)imgN
{
    [self setBackgroundImage:imgN forState:UIControlStateNormal];
}
- (UIImage *)normalBgImg
{
    return [self backgroundImageForState:UIControlStateNormal];
}
- (void)setHighlightedBgImg:(UIImage *)imgN
{
    [self setBackgroundImage:imgN forState:UIControlStateHighlighted];
}
- (UIImage *)highlightedBgImg
{
    return [self backgroundImageForState:UIControlStateHighlighted];
}
- (void)setSelectedBgImg:(UIImage *)imgN
{
    [self setBackgroundImage:imgN forState:UIControlStateSelected];
}
- (UIImage *)selectedBgImg
{
    return [self backgroundImageForState:UIControlStateSelected];
}
- (void)setDisabledBgImg:(UIImage *)imgN
{
    [self setBackgroundImage:imgN forState:UIControlStateDisabled];
}
- (UIImage *)disabledBgImg
{
    return [self backgroundImageForState:UIControlStateDisabled];
}
@end
