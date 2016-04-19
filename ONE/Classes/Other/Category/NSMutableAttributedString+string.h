//
//  NSMutableAttributedString+string.h
//  ONE
//
//  Created by 任玉祥 on 16/4/4.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (string)


/**
 *  根据一个字符串返回一个格式化好的字符串
 *
 *  @param str 字符串
 *
 *  @return 格式化成功的字符串
 */
+ (NSMutableAttributedString *)attributedStringWithString:(NSString *)str;
@end
