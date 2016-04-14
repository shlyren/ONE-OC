//
//  ONESerialItem.h
//  ONE
//
//  Created by 任玉祥 on 16/4/14.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import "ONEAuthorItem.h"

@interface ONESerialItem : NSObject
/** id */
@property (nonatomic, strong) NSString *content_id;
@property (nonatomic, strong) NSString *serial_id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *excerpt;
@property (nonatomic, strong) NSString *read_num;
@property (nonatomic, strong) NSString *maketime;
@property (nonatomic, strong) ONEAuthorItem *author;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *content;

@property (nonatomic, strong) NSString *charge_edt;
@property (nonatomic, strong) NSString *last_update_date;
@property (nonatomic, strong) NSString *audio;
@property (nonatomic, strong) NSString *web_url;
@property (nonatomic, strong) NSString *input_name;
@property (nonatomic, strong) NSString *last_update_name;
@property (nonatomic, strong) NSString *praisenum;
@property (nonatomic, strong) NSString *sharenum;
@property (nonatomic, strong) NSString *commentnum;


@property (nonatomic, assign) CGFloat rowHeight;

@end
