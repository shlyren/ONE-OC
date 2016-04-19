//
//  ONEEssayItem.h
//  ONE
//
//  Created by 任玉祥 on 16/4/14.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEAuthorItem.h"

@interface ONEEssayItem : NSObject
@property (nonatomic, strong) NSString *content_id;
@property (nonatomic, strong) NSString *hp_title;
@property (nonatomic, strong) NSString *hp_makettime;
@property (nonatomic, strong) NSString *guide_word;

@property (nonatomic, strong) NSArray  *author;

@property (nonatomic, strong) NSString *sub_title;
@property (nonatomic, strong) NSString *hp_author;
@property (nonatomic, strong) NSString *auth_it;
@property (nonatomic, strong) NSString *hp_author_introduce;

@property (nonatomic, strong) NSString *hp_content;
@property (nonatomic, strong) NSString *wb_name;
@property (nonatomic, strong) NSString *wb_img_url;
@property (nonatomic, strong) NSString *last_update_date;
@property (nonatomic, strong) NSString *web_url;
@property (nonatomic, strong) NSString *audio;
@property (nonatomic, assign) BOOL     has_aduio;

@property (nonatomic, strong) NSString *praisenum;
@property (nonatomic, strong) NSString *sharenum;
@property (nonatomic, strong) NSString *commentnum;

@property (nonatomic, assign) CGFloat rowHeight;
@end
