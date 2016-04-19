//
//  ONEMovieStoryItem.h
//  ONE
//
//  Created by 任玉祥 on 16/4/11.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEAuthorItem.h"
@interface ONEMovieStoryItem : NSObject

/*
 story_type	String	1
 user_id	String	6382860
 praisenum	Integer	828
 id	String	811
 sort	String	0
 movie_id	String	48
 title	String	《火锅英雄》二三事
 input_date	String	2016-03-31 12:06:19
 user	Object
 content	String
 */

@property (nonatomic, strong) NSString *story_type;

/** <#注释#> */
@property (nonatomic, strong) NSString *user_id;

/** <#注释#> */
@property (nonatomic, assign) NSInteger praisenum;

/** 故事id 服务器 id */
@property (nonatomic, strong) NSString *movie_story_id;

/** <#注释#> */
@property (nonatomic, strong) NSString *sort;

/**  */
@property (nonatomic, strong) NSString *movie_id;

/** <#注释#> */
@property (nonatomic, strong) NSString *title;

/** <#注释#> */
@property (nonatomic, strong) NSString *input_date;

/**  */
@property (nonatomic, strong) ONEAuthorItem *user;

/** <#注释#> */
@property (nonatomic, strong) NSString *content;
@end
