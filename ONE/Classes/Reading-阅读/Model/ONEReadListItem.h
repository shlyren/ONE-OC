//
//  ONEReadListItem.h
//  ONE
//
//  Created by 任玉祥 on 16/4/14.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEEssayItem.h"
#import "ONESerialItem.h"
#import "ONEQuestionItem.h"

@interface ONEReadListItem : NSObject
@property (nonatomic, strong) NSArray<ONEEssayItem *>   *essay;
@property (nonatomic, strong) NSArray<ONESerialItem *>   *serial;
@property (nonatomic, strong) NSArray<ONEQuestionItem *> *question;
@end
