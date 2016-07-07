//
//  ONEMovieMoreViewController.h
//  ONE
//
//  Created by 任玉祥 on 16/4/13.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef NS_ENUM (NSUInteger, ONEMovieMoreViewControllerType){
//    ONEMovieMoreViewControllerTypeMovieStory = 0, // 电影故事
//    ONEMovieMoreViewControllerTypeReview = 1, // 评审团
//    ONEMovieCommentCellTypeMovieComment = 2, // 评论
//    
//};

@interface ONEMovieMoreViewController : UITableViewController
@property (nonatomic, strong) NSString *movie_id;
@end
