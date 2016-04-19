//
//  ONEMovieCommentItem.h
//  ONE
//
//  Created by 任玉祥 on 16/4/11.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEMusicCommentItem.h"


@interface ONEMovieCommentItem : ONEMusicCommentItem

@property (nonatomic, strong) NSString *score;

/** 用户信息 */
@property (nonatomic, strong) ONEAuthorItem *author;

/**  */
@property (nonatomic, strong) NSString *sort;

@property (nonatomic, strong) NSString *movie_id;
@end
