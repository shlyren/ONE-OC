//
//  UIColor+Hex.h
//  颜色常识
//
//  Created by 任玉祥 on 15/12/15.
//  Copyright © 2015年 任玉祥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)


/**
 *  从十六进制字符串获取颜色
 *
 *  @paramcolor:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 *
 */
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;


/**
 *  默认alpha位1
 *
 *  @paramcolor:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 */
+ (UIColor *)colorWithHexString:(NSString *)color;

@end
