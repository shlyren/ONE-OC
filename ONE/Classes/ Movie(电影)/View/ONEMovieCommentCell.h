//
//  ONEMovieCommentCell.h
//  ONE
//
//  Created by 任玉祥 on 16/4/11.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ONEMovieCommentItem;
@interface ONEMovieCommentCell : UITableViewCell

@property (nonatomic, strong) ONEMovieCommentItem *commentItem;

@property (nonatomic, assign) CGFloat rowHeight;
@end
