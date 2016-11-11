//
//  UIButton+Extension.h
//  YXCategoriesDemo
//
//  Created by 任玉祥 on 2016/11/3.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)

#pragma mark - title
@property (nonatomic, strong) NSString *normalTitle;
@property (nonatomic, strong) NSString *highlightedTitle;
@property (nonatomic, strong) NSString *selectedTitle;
@property (nonatomic, strong) NSString *disabledTitle;

#pragma mark - title Color
@property (nonatomic, strong) UIColor *normalTitleColor;
@property (nonatomic, strong) UIColor *highlightedTitleColor;
@property (nonatomic, strong) UIColor *selectedTitleColor;
@property (nonatomic, strong) UIColor *disabledTitleColor;

#pragma mark - image
@property (nonatomic, strong) UIImage *normalImg;
@property (nonatomic, strong) UIImage *highlightedImg;
@property (nonatomic, strong) UIImage *selectedImg;
@property (nonatomic, strong) UIImage *disabledImg;

#pragma mark - background image
@property (nonatomic, strong) UIImage *normalBgImg;
@property (nonatomic, strong) UIImage *highlightedBgImg;
@property (nonatomic, strong) UIImage *selectedBgImg;
@property (nonatomic, strong) UIImage *disabledBgImg;
@end
