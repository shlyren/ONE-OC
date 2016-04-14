//
//  ONEQuestionItem.m
//  ONE
//
//  Created by 任玉祥 on 16/4/14.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import "ONEQuestionItem.h"

@implementation ONEQuestionItem
- (CGFloat)rowHeight
{
    if (_rowHeight) return _rowHeight;
    
    _rowHeight += ONEDefaultMargin;
    
    //System Semibold 17.0
    _rowHeight += [self.question_title boundingRectWithSize:CGSizeMake(ONEScreenWidth - 4 * ONEDefaultMargin, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:17]} context:nil].size.height + 5;
    
    _rowHeight += 20;
    _rowHeight += 5;
    
    _rowHeight += [self.answer_content boundingRectWithSize:CGSizeMake(ONEScreenWidth - 4 * ONEDefaultMargin, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height + ONEDefaultMargin;
    
    _rowHeight += ONEDefaultMargin;
    
    return _rowHeight;
}
@end
