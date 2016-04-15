//
//  ONEQuestionHeaderView.h
//  ONE
//
//  Created by 任玉祥 on 16/4/15.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import "ONEReadDetailHeaderView.h"

@class ONEQuestionItem;
@interface ONEQuestionHeaderView : ONEReadDetailHeaderView
@property (nonatomic, strong) ONEQuestionItem                    *questionItem;

+ (instancetype)questionDetailHeaderView;
@end
