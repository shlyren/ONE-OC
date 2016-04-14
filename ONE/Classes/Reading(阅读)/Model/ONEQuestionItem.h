//
//  ONEQuestionItem.h
//  ONE
//
//  Created by 任玉祥 on 16/4/14.
//  Copyright © 2016年 ONE. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface ONEQuestionItem : NSObject

@property (nonatomic, strong) NSString *question_id;
@property (nonatomic, strong) NSString *question_title;
@property (nonatomic, strong) NSString *answer_title;
@property (nonatomic, strong) NSString *answer_content;
@property (nonatomic, strong) NSString *question_maketiem;




@property (nonatomic, assign) CGFloat rowHeight;
@end
