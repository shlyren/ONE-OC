//
//  ONESerialItem.m
//  ONE
//
//  Created by 任玉祥 on 16/4/14.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONESerialItem.h"

@implementation ONESerialItem

- (CGFloat)rowHeight
{
    if (_rowHeight) return _rowHeight;
    
    _rowHeight += ONEDefaultMargin;
    
    //System Semibold 17.0
    _rowHeight += [self.title boundingRectWithSize:CGSizeMake(ONEScreenWidth - 4 * ONEDefaultMargin, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:17]} context:nil].size.height + 5;
    
    _rowHeight += 20;
    _rowHeight += 5;
    
    _rowHeight += [self.excerpt boundingRectWithSize:CGSizeMake(ONEScreenWidth - 4 * ONEDefaultMargin, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height + ONEDefaultMargin;
    
    return _rowHeight += ONEDefaultMargin;
}

@end
