//
//  ONEMovieCommentCell.h
//  ONE
//
//  Created by 任玉祥 on 16/4/11.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ONEMovieCommentItem, ONEMovieStoryItem;
typedef  NS_ENUM(NSUInteger, ONEMovieCommentCellType){
    ONEMovieCommentCellTypeMovieStory = 0, // 电影故事
    ONEMovieCommentCellTypeMovieReview = 1, // 评审团
    ONEMovieCommentCellTypeMovieComment = 2, // 评论
    
};

@interface ONEMovieCommentCell : UITableViewCell


@property (nonatomic, strong) ONEMovieCommentItem           *commentItem;

@property (nonatomic, strong) ONEMovieStoryItem             *movieStoryItem;

@property (nonatomic, assign) ONEMovieCommentCellType       commentCellType;

@property (nonatomic, assign) CGFloat                       rowHeight;

@property (nonatomic, strong) NSString                      *movie_id;


- (void)praisenumBtnClick;
- (void)addPraise:(NSString *)url parameters:(NSDictionary *)parameters;

@end
