//
//  ONEReadRelatedCell.h
//  ONE
//
//  Created by 任玉祥 on 16/4/15.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ONEEssayItem;
@class ONEQuestionItem;
@class ONESerialItem;

@interface ONEReadRelatedCell : UITableViewCell
@property (nonatomic, strong) ONEEssayItem *essayItem;
@property (nonatomic, strong) ONEQuestionItem *questionItem;
@property (nonatomic, strong) ONESerialItem *serialItem;
@property (nonatomic, assign) CGFloat rowHeight;
@end
