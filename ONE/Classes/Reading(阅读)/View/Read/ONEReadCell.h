//
//  ONEReadCell.h
//  ONE
//
//  Created by 任玉祥 on 16/4/14.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ONEReadListItem.h"

@interface ONEReadCell : UITableViewCell
@property (nonatomic, strong) ONEEssayItem     *essay;
@property (nonatomic, strong) ONESerialItem    *serial;
@property (nonatomic, strong) ONEQuestionItem  *question;
@end
