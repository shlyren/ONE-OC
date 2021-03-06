//
//  NSMutableAttributedString+string.m
//  ONE
//
//  Created by 任玉祥 on 16/4/4.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "NSMutableAttributedString+string.h"

@implementation NSMutableAttributedString (string)
// 格式化故事详情的内容
+ (NSMutableAttributedString *)attributedStringWithString:(NSString *)str
{
    if (!str.length) return nil;
    
    NSString *tmpStr = str;

    // <!--StartFragment-->
    NSRange range;
    range = [tmpStr rangeOfString:@"<!--StartFragment-->"];
    if (range.location != NSNotFound)
    {
        tmpStr = [tmpStr stringByReplacingCharactersInRange:NSMakeRange(0, range.location + range.length) withString:@""];
    }
    // 换行
    tmpStr = [tmpStr stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
    tmpStr = [tmpStr stringByReplacingOccurrencesOfString:@"<strong>" withString:@""];
    tmpStr = [tmpStr stringByReplacingOccurrencesOfString:@"</strong>" withString:@""];
    tmpStr = [tmpStr stringByReplacingOccurrencesOfString:@"<em>" withString:@""];
    tmpStr = [tmpStr stringByReplacingOccurrencesOfString:@"</em>" withString:@""];
    
    range = [tmpStr rangeOfString:@"<!--EndFragment-->"];
    if (range.location != NSNotFound)
    {
        tmpStr = [tmpStr stringByReplacingCharactersInRange:range withString:@""];
    }
    
    //<!--EndFragment-->
    
    // 设置内容格式
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:tmpStr];
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    
    [paragraphStyle setLineSpacing:4];//调整行间距

    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, tmpStr.length)];
    
    return attributedString;
}

@end
