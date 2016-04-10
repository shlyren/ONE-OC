//
//  ONEMusicCommentItem.h
//  ONE
//
//  Created by 任玉祥 on 16/4/2.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ONEMusicAuthorItem;
@interface ONEMusicCommentItem : NSObject

/** 喜欢 */
@property (nonatomic, assign) NSInteger praisenum;

/** 评论id */
@property (nonatomic, strong) NSString *comment_id; // 返回 id

/** 评论时间 */
@property (nonatomic, strong) NSString *input_date;

/** 类型 */
@property (nonatomic, assign) NSInteger type;


/** 用户信息 */
@property (nonatomic, strong) ONEMusicAuthorItem *user;


/** 评论内容 */
@property (nonatomic, strong) NSString *content;
@end
