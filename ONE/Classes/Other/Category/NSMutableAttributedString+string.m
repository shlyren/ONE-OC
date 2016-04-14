//
//  NSMutableAttributedString+string.m
//  ONE
//
//  Created by 任玉祥 on 16/4/4.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import "NSMutableAttributedString+string.h"

@implementation NSMutableAttributedString (string)
// 格式化故事详情的内容
+ (NSMutableAttributedString *)attributedStringWithString:(NSString *)str
{
    if (str == nil) return nil;
    // 换行
    NSString *story = [str stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
    story = [story stringByReplacingOccurrencesOfString:@"<strong>" withString:@""];
    story = [story stringByReplacingOccurrencesOfString:@"</strong>" withString:@""];
    story = [story stringByReplacingOccurrencesOfString:@"<em>" withString:@""];
    story = [story stringByReplacingOccurrencesOfString:@"</em>" withString:@""];
    story = [story stringByReplacingOccurrencesOfString:@"</em>" withString:@""];
    story = [story stringByReplacingOccurrencesOfString:@"<!--EndFragment-->" withString:@""];
    
    //<!--EndFragment-->
    // 设置内容格式
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:story];
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    
    [paragraphStyle setLineSpacing:4];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, story.length)];
    
    return attributedString;
}

@end
