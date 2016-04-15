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
@property (nonatomic, strong) NSString *question_content;
@property (nonatomic, strong) NSString *answer_title;
@property (nonatomic, strong) NSString *answer_content;
@property (nonatomic, strong) NSString *question_maketiem;
@property (nonatomic, strong) NSString *charge_edt;
@property (nonatomic, strong) NSString *last_update_date;
@property (nonatomic, strong) NSString *web_url;
@property (nonatomic, strong) NSString *read_num;
@property (nonatomic, strong) NSString *praisenum;
@property (nonatomic, strong) NSString *sharenum;
@property (nonatomic, strong) NSString *commentnum;


@property (nonatomic, assign) CGFloat rowHeight;
@end
