//
//  ONEEssayItem.m
//  ONE
//
//  Created by 任玉祥 on 16/4/14.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEEssayItem.h"

@implementation ONEEssayItem


- (CGFloat)rowHeight
{
    if (_rowHeight) return _rowHeight;
    
    _rowHeight += ONEDefaultMargin;
    
    //System Semibold 17.0
    _rowHeight += [self.hp_title boundingRectWithSize:CGSizeMake(ONEScreenWidth - 4 *ONEDefaultMargin, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:17]} context:nil].size.height + 5;
    
    _rowHeight += 20;
    _rowHeight += 5;
    
    _rowHeight += [self.guide_word boundingRectWithSize:CGSizeMake(ONEScreenWidth - 4 * ONEDefaultMargin, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : ONEDefaultFont} context:nil].size.height + ONEDefaultMargin;
    
    return _rowHeight += ONEDefaultMargin;
}
@end
